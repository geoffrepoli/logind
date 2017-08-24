# logind

Mac admins often have login workflows that require both (a) root permissions and (b) a user to be logged in (console user). While loginhooks used to serve this purpose, they've since been deprecated. Launch agents, on the other hand, satisfy (b) but not (a). **logind** attempts to solve the issue by using a launch daemon to check if a user is logged in before running your workflow.

## Getting Started

Download or clone the repository:

```
git clone https://github.com/doggles/logind.git
```

Replace the contents of `loginItems()` in [run.sh](run.sh) with the command(s) you want to execute at user login.

## Deployment

Once you've added your login tasks to `run.sh`, use the `build.sh` script to automatically configure a deployable pkg installer. In Terminal, enter the following:

```
cd logind && ./build.sh
```

An installer package `logind.pkg` will be created in the root of your logind directory, which you can then use to deploy to end users via MDM or other management tool.

If you intend to build the package installer yourself, make sure you've created the correct file paths in your package root. For reference: the default paths are `/Library/LaunchDaemons/com.doggles.logind.plist` and `/usr/local/logind/run.sh`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details


