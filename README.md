# Login Daemon

Mac admins often have login workflows that require both (a) root permissions and (b) a user to be logged in (console user). While loginhooks used to serve this purpose, they've since been deprecated. Launch Agents, on the other hand, satisfy (b) but not (a). This tool attempts to solve the issue using a Launch Daemon that checks to see if the user is logged in before running your workflow.
## Getting Started

Download or clone the repository:

```
git clone https://github.com/geoffrepoli/logindaemon.git
```

Replace the contents of `loginItems()` in `run.sh` with the command(s) you want to execute at user login.
## Deployment

Once you've added your login tasks to `run.sh`, use the `build.sh` script to automatically configure a deployable pkg installer. In Terminal, enter the following:

```
cd logindaemon && ./build.sh
```

An installer package `deploy.pkg` will be created in the root of your logindaemon directory, which you can then use to deploy to end users via MDM or other management tool.

If you intend to build the package installer yourself, make sure you've created the correct file paths in your package root. For reference: the default paths are `/Library/LaunchDaemons/fm.pkg.logindaemon.plist` and `/usr/local/logindaemon/run.sh`.
## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


