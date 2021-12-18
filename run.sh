#!/usr/bin/env bash

# Commands to be run when user logs in.
loginItems() {
	echo "Change Me"
}

## -- END CONFIGURATION -- ##

# Function returns true if Finder pid is running
userLoggedIn() {
  pgrep Finder && return 0 || return 1
}

# Unloads Launch Daemon and remove plist and script
cleanup() {
  launchctl remove -F /Library/LaunchDaemons/com.doggles.logind.plist
  rm -f /Library/LaunchDaemons/com.doggles.logind.plist
  rm -rf /opt/logind
}

if userLoggedIn && [[ ! $(stat -f%Su /dev/console) = "_mbsetupuser" ]]; then
  loginItems            # Execute run-at-login workflow
  trap 'cleanup' EXIT   # Remove Launch Daemon on script exit
fi

exit