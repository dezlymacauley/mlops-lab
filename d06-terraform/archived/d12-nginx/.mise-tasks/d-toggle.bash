#!/usr/bin/env bash
#MISE description="🐳  Toggle the state of the Docker daemon"
#MISE quiet=true

#______________________________________________________________________________

# Check if the Docker CLI is installed
if ! command -v docker &>/dev/null; then
    printf "\n❌ The Docker CLI is not installed\n\n"
    exit 1
fi

#______________________________________________________________________________

# Stop the script if systemctl is not available
if ! command -v systemctl &>/dev/null; then
    printf "\n❌ systemctl is not available on this system\n\n"
    exit 1
fi

#______________________________________________________________________________

# Toggle the state of the Docker daemon
if systemctl is-active --quiet docker; then
    sudo systemctl stop docker.service docker.socket
    printf "\n⬛ Docker daemon deactivated\n\n"
else
    sudo systemctl start docker.service docker.socket
    printf "\n✅ Docker daemon activated\n\n"
fi

#______________________________________________________________________________
