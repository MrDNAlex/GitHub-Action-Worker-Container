#!/usr/bin/expect -f

# Load environment variables
set REPO $env(REPO)
set TOKEN $env(TOKEN)
set RUNNERGROUP $env(RUNNERGROUP)
set RUNNERNAME $env(RUNNERNAME)
set RUNNERLABELS $env(RUNNERLABELS)
set RUNNERWORKDIR $env(RUNNERWORKDIR)

# Start the configuration process
spawn ./config.sh

# Provide the URL of the repository
expect "What is the URL of your repository?" { send "$REPO\n" }

sleep 0.1

# Provide the runner register token
expect "What is your runner register token?" { send "$TOKEN\n" }

sleep 1

# Provide default input for runner group
expect -re "Enter the name of the runner group to add this runner to.*" { send "$RUNNERGROUP\n" }

sleep 0.1

# Provide the runner name
expect -re "Enter the name of runner:.*" { send "$RUNNERNAME\n" }

sleep 0.1

# Accept the default labels
expect -re "This runner will have the following labels:.*" { send "$RUNNERLABELS\n" }

sleep 1

# Provide the work folder name
expect -re "Enter name of work folder:.*" { send "$RUNNERWORKDIR\n" }

sleep 0.1

expect eof

# Allow the script to complete
spawn bash -c "./run.sh"
interact

