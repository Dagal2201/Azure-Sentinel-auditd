#!/bin/bash

# Define cleanup function
cleanup() {
    echo "Cleaning up..."
    # Delete the user if it exists
    if id "$USERNAME" &>/dev/null; then
        userdel -r "$USERNAME"
        echo "User $USERNAME deleted."
    fi
}

# Exit on error
set -e

# Variables
USERNAME="testuser123"
PASSWORD="TestPassword123"

# Create the user
echo "Creating user $USERNAME..."
useradd "$USERNAME"
if [ $? -eq 0 ]; then
    echo "User $USERNAME created successfully."
else
    echo "Failed to create user $USERNAME."
    cleanup
    exit 1
fi

# Change the user's password
echo "Changing password for $USERNAME..."
passwd $USERNAME
if [ $? -eq 0 ]; then
    echo "Password for $USERNAME changed successfully."
else
    echo "Failed to change password for $USERNAME."
    cleanup
    exit 1
fi

# Delete the user
echo "Deleting user $USERNAME..."
userdel -r "$USERNAME"
if [ $? -eq 0 ]; then
    echo "User $USERNAME deleted successfully."
else
    echo "Failed to delete user $USERNAME."
    cleanup
    exit 1
fi

# Cleanup if anything failed at any point
cleanup
