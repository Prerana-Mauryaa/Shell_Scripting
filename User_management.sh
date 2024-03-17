#!/bin/bash

# Step 1: Check if the script is being executed with superuser privileges
if [[ $(id -u) -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Step 2: Check if at least one argument is provided
if [[ $# -lt 1 ]]; then
    echo "Usage: ${0} <username> [comments...]"
    exit 1
fi

# Step 3: Extract the username from the first argument
username=$1
shift  # Remove the first argument from the list

# Step 4: Check if comments are provided
if [[ $# -lt 1 ]]; then
    echo "Please provide comments for the user"
    exit 1
fi

# Step 5: Generate a random password
password=$(openssl rand -base64 12)

# Step 6: Create the user with the generated password and comments
useradd -m -p $(openssl passwd -1 "$password") -c "$*" "$username"

# Step 7: Check if the useradd command succeeded
if [[ $? -eq 0 ]]; then
    echo "User $username created successfully."
    echo "Password for $username: $password"
else
    echo "Failed to create user $username"
fi

