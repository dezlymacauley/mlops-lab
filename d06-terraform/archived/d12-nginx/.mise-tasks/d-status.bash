#!/usr/bin/env bash
#MISE description="🐳  Check the status of Docker CLI and daemon"
#MISE quiet=true

#______________________________________________________________________________

# Check if the Docker CLI is installed
if command -v docker &>/dev/null; then
    printf "\n✅ The Docker CLI is installed\n\n"
else
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

# Check if the Docker daemon is active
if systemctl is-active --quiet docker; then
    printf "✅ The Docker daemon is active \n\n"
else
    printf "⬛ The Docker daemon is inactive\n\n"
fi

#______________________________________________________________________________
