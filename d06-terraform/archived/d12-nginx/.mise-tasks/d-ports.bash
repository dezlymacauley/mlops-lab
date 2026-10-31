#!/usr/bin/env bash
#MISE description="🐳  List the ID, Name, and Ports of all containers"
#MISE quiet=true

#______________________________________________________________________________

# Stop the script if the Docker CLI is not installed
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

# Stop the script if the Docker daemon is not active
if ! systemctl is-active --quiet docker; then
    printf "\n❌ The Docker daemon is not active \n\n"
    exit 1
fi

#______________________________________________________________________________

# List the ID, Name, and Ports of all containers"
printf "\n%s\n\n" \
    "$(docker ps -a --format \
    "table {{.ID}}\t{{.Names}}\t{{.Ports}}")"

#______________________________________________________________________________
