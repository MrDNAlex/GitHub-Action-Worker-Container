#!/bin/bash

# Name the Docker Container
Name="github-action-worker-container"

# Kill it if it's already running
docker kill $Name

# Remove it if it's already running
docker rm $Name

# Run the Docker Container
docker run -it --name $Name mrdnalex/github-action-worker-container