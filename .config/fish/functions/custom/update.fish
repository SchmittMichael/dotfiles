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

function update
  set distro (sed -n "s/^ID=\(.*\)/\1/p" /etc/os-release)

  switch $distro
    case "arch"
      __update_arch
    case "ubuntu"
      __update_ubuntu
    case '*'
      echo "Unknown distribution '$distro'"
      exit 1
  end
end
