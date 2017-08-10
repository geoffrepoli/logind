# Run-At-Login Launch Daemon

*Purpose:* In Mac Admininistration, we often have login workflows that require both (a) root permissions and (b) a user to be logged in (console user). While loginhooks used to serve this purpose, they've since been deprecated. Launch Agents, on the other hand, satisfy (b) but not (a).

This template attempts to solve the issue by using a RunAtLoad Launch Daemon that checks if Finder is running, indicating that a user is logged in. Until Finder is running, the Launch Daemon will check every 10 seconds. Once Finder is running, the script will perform the tasks you've included within the loginItems() function, then remove the Launch Daemon.

_NOTE:_ Since the script will unload and remove the Launch Daemon after completion of login items, this cannot be used in its current form for ongoing login tasks.
