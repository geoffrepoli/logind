#!/usr/bin/env bash
set -u
ROOT_DIR=$(dirname "$0")

# check if run.sh and plist are in folder
if [ ! -f "$ROOT_DIR"/com.doggles.logindaemon.plist ] || [ ! -f "$ROOT_DIR"/run.sh ]; then
	echo "Required files not found"
	exit 11
fi

# remove .build/ if exists
[ -d "$ROOT_DIR"/.build ] && rm -rf "$ROOT_DIR"/.build

# create pkgbuild staging dirs
mkdir -p \
	"$ROOT_DIR"/.build/ROOT/Library/LaunchDaemons \
	"$ROOT_DIR"/.build/ROOT/usr/local/logindaemon \
	"$ROOT_DIR"/.build/scripts

# copy plist
cp \
	"$ROOT_DIR"/com.doggles.logindaemon.plist \
	"$ROOT_DIR"/.build/ROOT/Library/LaunchDaemons

# copy script
cp \
	"$ROOT_DIR"/run.sh \
	"$ROOT_DIR"/.build/ROOT/usr/local/logindaemon

# create postinstall
cat > "$ROOT_DIR"/.build/scripts/postinstall <<SCRIPT
#!/usr/bin/env bash
chmod +x /usr/local/logindaemon/run.sh
launchctl load -w /Library/LaunchDaemons/com.doggles.logindaemon.plist
SCRIPT

# build package
pkgbuild \
	--root "$ROOT_DIR"/.build/ROOT \
	--scripts "$ROOT_DIR"/.build/scripts \
	--ownership recommended \
	--identifier com.doggles.logindaemon \
	"$ROOT_DIR"/deploy.pkg

# cleanup
_cleanup() { rm -rf "$ROOT_DIR"/.build; }
trap '_cleanup' EXIT

exit
