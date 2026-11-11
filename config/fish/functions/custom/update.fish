function __update_arch
    echo "Updating pacman..."
    sudo pacman -Syu --noconfirm

    echo "Updating yay..."
    yay
end

function __update_ubuntu
    echo "Updating apt..."
    sudo apt update
    sudo apt upgrade -y

    echo "Updating snap..."
    sudo snap refresh
end

function update --description 'Update system packages, or list available updates with --check'
    argparse check -- $argv
    or return

    set distro (sed -n "s/^ID=\(.*\)/\1/p" /etc/os-release)

    switch $distro
        case arch
            if set -q _flag_check
                checkupdates
            else
                __update_arch
            end
        case ubuntu
            if set -q _flag_check
                sudo apt update
                apt list --upgradable
            else
                __update_ubuntu
            end
        case '*'
            echo "Unknown distribution '$distro'"
            exit 1
    end
end
