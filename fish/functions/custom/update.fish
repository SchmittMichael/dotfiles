function update
    sudo echo "Updating apt..."
    sudo apt update
    sudo apt upgrade -y

    echo "Updating snap..."
    sudo snap refresh
end
