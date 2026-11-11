#!/usr/bin/env python3
"""Manage this repository's dotfiles by generating and removing symlinks."""

import argparse
import os
import shutil
import sys
from collections import defaultdict
from dataclasses import dataclass
from enum import Enum, auto
from pathlib import Path
from typing import Self

WORK_EXCLUDES = (
    "hypr",
    "mako",
    "swaync",
    "waybar",
    "wofi",
)
LAPTOP_EXCLUDES = (
    "alacritty",
    "hypr",
    "mako",
    "swaync",
    "waybar",
    "wofi",
)

HOME = Path.home()


class Command(Enum):
    LINK = auto()
    STATUS = auto()
    UNLINK = auto()

    @classmethod
    def from_str(cls, string: str) -> Self:
        return cls[string.upper()]


class FailureReason(Enum):
    DIR = auto()
    WRONG_LINK = auto()
    EXISTS = auto()
    FILE = auto()

    @property
    def pretty(self) -> str:
        return {
            FailureReason.DIR: "[DIRECTORY EXISTS]",
            FailureReason.FILE: "[FILE EXISTS]",
            FailureReason.EXISTS: "[LINK EXISTS]",
            FailureReason.WRONG_LINK: "[WRONG LINK EXISTS]",
        }[self]


@dataclass(frozen=True)
class Link:
    source: Path
    destination: Path

    def apply(self) -> None:
        self.destination.parent.mkdir(parents=True, exist_ok=True)
        self.destination.symlink_to(self.source)

    def remove(self) -> None:
        self.destination.unlink()

    def __str__(self) -> str:
        return f"{display_path(self.destination)} -> {display_path(self.source)}"


def points_to(target: Path, source: Path) -> bool:
    if not target.is_symlink():
        return False
    # Compare the link itself, not its resolved endpoint (which may be broken).
    destination = os.path.abspath(target.parent / os.readlink(target))
    return destination == os.path.abspath(source)


def display_path(path: Path) -> str:
    if path.is_relative_to(HOME):
        return str(Path("~") / path.relative_to(HOME))
    return str(path)


class Planner:
    def __init__(
        self,
        command: str,
        excludes: tuple[str, ...] = (),
    ) -> None:
        self.command = Command.from_str(command)
        self.excludes = excludes

        self.actions: list[Link] = []
        self.failures: dict[FailureReason, list[Link]] = defaultdict(list)

    def gather(self) -> Self:
        repo_root = Path(__file__).resolve().parent
        self.actions.clear()
        self.failures.clear()

        for folder, destination, prefix in (
            ("config", HOME / ".config", Path(".config")),
            ("home", HOME, Path()),
        ):
            for source in sorted((repo_root / folder).iterdir()):
                relative_path = prefix / source.name
                if any(relative_path.match(pattern.rstrip("/")) for pattern in self.excludes):
                    continue
                self._resolve(source, destination)

        return self

    def _resolve(self, source: Path, destination_dir: Path) -> None:
        name = source.name
        destination_path = destination_dir / name
        link = Link(source, destination_path)

        if not destination_path.exists() and not destination_path.is_symlink():
            self.actions.append(link)
            return

        if destination_path.is_symlink():
            if points_to(destination_path, source):
                self.failures[FailureReason.EXISTS].append(link)
            else:
                self.failures[FailureReason.WRONG_LINK].append(link)
        elif destination_path.is_dir():
            self.failures[FailureReason.DIR].append(link)
        elif destination_path.is_file():
            self.failures[FailureReason.FILE].append(link)
        else:
            raise RuntimeError(f"Invalid state encountered with {display_path(destination_path)}")

    def apply(self, force: bool = False, dry_run: bool = True) -> None:
        match self.command:
            case Command.STATUS:
                self._apply_status()
            case Command.LINK:
                self._apply_link(force, dry_run)
            case Command.UNLINK:
                self._apply_unlink(force, dry_run)
            case _:
                raise ValueError(f"Unknown command: {self.command!r}")

    def _print_failures(self) -> None:
        width = max(len(reason.pretty) for reason in FailureReason)

        for reason, links in self.failures.items():
            if reason is FailureReason.EXISTS:
                continue
            for link in links:
                print(f"{reason.pretty:<{width}}: {display_path(link.destination)}")

    def _apply_status(self) -> None:
        for reason, links in self.failures.items():
            for link in links:
                print(f"{reason.name}: {link}")
        print()

        for link in self.actions:
            print(f"[MISSING]: {link}")

    def _apply_link(self, force: bool, dry_run: bool) -> None:
        if force:
            print_prefix = "would replace" if dry_run else "replaced"

            for link in self.failures[FailureReason.DIR]:
                if not dry_run:
                    shutil.rmtree(link.destination)
                    link.apply()
                print(f"{print_prefix} directory with: {link}")

            for link in self.failures[FailureReason.FILE]:
                if not dry_run:
                    os.remove(link.destination)
                    link.apply()
                print(f"{print_prefix} file with: {link}")

            for link in self.failures[FailureReason.WRONG_LINK]:
                if not dry_run:
                    link.destination.unlink()
                    link.apply()
                print(f"{print_prefix} link with: {link}")
        else:
            self._print_failures()

        for link in self.actions:
            if not dry_run:
                link.apply()
            print(f"{'would link' if dry_run else 'linked'}: {link}")

    def _apply_unlink(self, force: bool, dry_run: bool) -> None:
        for link in self.failures[FailureReason.EXISTS]:
            if not dry_run:
                link.remove()
            print(f"{'would unlink' if dry_run else 'unlinked'}: {display_path(link.destination)}")


def get_excludes(args: argparse.Namespace) -> tuple[str, ...]:
    work_excludes_paths = {".config/" + name for name in WORK_EXCLUDES} if args.work else set()
    laptop_excludes_paths = {".config/" + name for name in LAPTOP_EXCLUDES} if args.laptop else set()

    excludes = work_excludes_paths.union(laptop_excludes_paths)
    excludes.update(args.exclude)

    return tuple(excludes)


def get_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        "command",
        nargs=argparse.OPTIONAL,
        default="link",
        choices=("link", "unlink", "status"),
    )
    parser.add_argument(
        "--work",
        action="store_true",
        help=f"exclude work irrelevant configs ({', '.join(WORK_EXCLUDES)})",
    )
    parser.add_argument(
        "--laptop",
        action="store_true",
        help=f"exclude laptop irrelevant configs ({', '.join(LAPTOP_EXCLUDES)})",
    )
    parser.add_argument(
        "--exclude",
        action="append",
        default=[],
        metavar="GLOB",
        help="exclude a repository-relative glob (repeatable)",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="delete conflicting files, directories, or symlinks when linking",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="show planned operations without changing anything",
    )

    args = parser.parse_args()

    if any(not pattern.rstrip("/") for pattern in args.exclude):
        parser.error("--exclude requires a nonempty repository-relative glob")

    return args


def main() -> int:
    args = get_args()
    excludes = get_excludes(args)

    try:
        Planner(args.command, excludes).gather().apply(args.force, args.dry_run)
        return 0
    except (OSError, ValueError, RuntimeError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
