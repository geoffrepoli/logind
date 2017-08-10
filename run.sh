#!/usr/bin/env bash

# Commands to be run when user logs in
loginItems()
{
  echo "Replace these commands with"
  echo "ones you want to run at user"
  echo "login. These commands will"
  echo "run as root, so you do not"
  echo "need to use 'sudo'"
}


## -- END CONFIGURATION -- ##


# Function returns true if Finder pid is running
userLoggedIn()
{
  pgrep Finder && return 0 || return 1
}

# Unloads Launch Daemon and remove plist and script
cleanup()
{
  launchctl unload -w /Library/LaunchDaemons/com.doggles.logindaemon.plist
  rm -f /Library/LaunchDaemons/com.doggles.logindaemon.plist
  rm -rf /usr/local/logindaemon
}

if userLoggedIn; then
  loginItems            # Execute run-at-login workflow
  trap 'cleanup' EXIT   # Remove Launch Daemon on script exit
fi

exit
