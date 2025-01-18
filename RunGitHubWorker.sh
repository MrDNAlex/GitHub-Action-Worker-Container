#!/bin/bash

#
# Variables (Change these)
#

# Github Repo Link
Repo = "https://github.com/..."

# Github Token
Token="****"

# Runner Group (Can be Empty)
RunnerGroup=""

# Runner Name (Can be Empty)
RunnerName="GitHubActionWorker"

# Runner Labels (Can be Empty)
RunnerLabels=""

# Runner Work Directory (Can be Empty)
RunnerWorkDir="Work"

# Name the Docker Container (Must be Lowercase)
Name="github-action-worker-container"

#
# Run the Docker Container (Don't Touch)
#

docker pull mrdnalex/github-action-worker-container

# Kill it if it's already running
docker kill $Name

# Remove it if it's already running
docker rm $Name

# Run the Docker Container
docker run -it --name $Name -e REPO=$Repo -e TOKEN=$Token -e RUNNERGROUP=$RunnerGroup -e RUNNERNAME=$RunnerName -e RUNNERLABELS=$RunnerLabels -e RUNNERWORKDIR=$RunnerWorkDir mrdnalex/github-action-worker-container