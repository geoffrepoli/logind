#!/usr/bin/env bash
set -u

ROOT_DIR=$(dirname "$0")
DATE=$(date +"%Y%m%d%H%M%S")

# Ensure user is running as root
if [[ $EUID != 0 ]]; then
	echo "Error: You need to run this script as root"
	exit 60
fi

# Check if required files are in folder
if [[ ! -f "${ROOT_DIR}"/com.doggles.logind.plist ]] || [[ ! -f "${ROOT_DIR}"/run.sh ]]; then
	echo "Required files not found"
	exit 99
fi

# Make postinstall script path
mkdir "${ROOT_DIR}"/scripts

# Create postinstall
cat > "${ROOT_DIR}"/scripts/postinstall <<POSTINSTALL
#!/usr/bin/env bash

ROOT_DIR=\$(dirname "\$0")

mkdir /opt/logind

cp "\${ROOT_DIR}"/run.sh /opt/logind
cp "\${ROOT_DIR}"/com.doggles.logind.plist /Library/LaunchDaemons

chown root:wheel /opt/logind/run.sh
chown root:wheel /Library/LaunchDaemons/com.doggles.logind.plist
chmod 744 /opt/logind/run.sh
chmod 644 /Library/LaunchDaemons/com.doggles.logind.plist

launchctl load -w /Library/LaunchDaemons/com.doggles.logind.plist

exit
POSTINSTALL

# Build package
pkgbuild \
	--root "$ROOT_DIR" \
	--install-location /private/tmp \
	--scripts "${ROOT_DIR}"/scripts \
	--identifier com.doggles.logind \
	"${ROOT_DIR}"/logind_"${DATE}".pkg

exit 0