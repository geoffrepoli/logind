# logind

Mac admins often have login workflows that require both (a) root permissions and (b) a user to be logged in (console user). While loginhooks used to serve this purpose, they've since been deprecated. Launch agents, on the other hand, satisfy (b) but not (a). **logind** attempts to solve the issue by using a launch daemon to check if a user is logged in before running your workflow.

## Getting Started

Download or clone the repository:

```
git clone https://github.com/geoffrepoli/logind.git
```

Replace the contents of `loginItems()` in [run.sh](run.sh) with the command(s) you want to execute at user login.

## Deployment

Once you've added your login tasks to `run.sh`, use the `build.sh` script to automatically configure a deployable pkg installer. In Terminal, enter the following:

```
sudo bash ./build.sh
```

An installer package `logind_<timestamp>.pkg` will be created in the root of your logind directory, which you can then use to deploy to end users via MDM or other management tool. Since you must run `build.sh` as root, you'll likely want to adjust permissions on the pkg with `sudo chown $(id -u):$(id -g) logind_<timestamp>.pkg`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details


