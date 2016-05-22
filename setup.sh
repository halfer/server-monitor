#!/bin/bash
#
# Set-up script for basic password-protected scripts for APC and
# Apache status monitoring. The mod_status module must be enabled in
# your server. It is usually available only to localhost, so we
# proxy it in the apache.php script.

# Save pwd and then change dir to this location
STARTDIR=`pwd`
cd `dirname $0`

# If we do nothing then exit with a standard message, to add idempotency to
# server orchestration scripts
if [ -f apc.php ] && [ -f .htaccess ]; then

	echo "Set up already"
	exit

fi

echo

if [ -f apc.php ]; then

	echo "1. The APC script is already set up"

else

	# Fetch a shallow clone from the latest master of APC
	echo "1. Fetching the APC repo from git.php.net, around a 300Kb download..."
	git clone --quiet --depth 1 https://git.php.net/repository/pecl/caching/apc.git && \
		cp apc/apc.php . && \
		rm -rf apc

fi

if [ -f .htaccess ]; then

	echo "2. The .htaccess file is already set up"

else

	echo "2. Writing an htaccess file..."
	FOLDER=`pwd` && cat htaccess.txt | sed -e "s|__PWD__|$FOLDER|" > .htaccess

fi

# Add some instructions
echo -e "\
3. Make sure Apache is configured to allow the htaccess file to take
   effect, for example:

	# Allow indexed folders
	Options Indexes
	# Allow passwording, allow allow/deny, allow php_value
	AllowOverride AuthConfig Limit Options

4. You need to set a password. You can use something simple like
   this (drop the -c if you are not creating the file for the first time):

	htpasswd -c passwords <username>
"

# Go back to original dir
cd $STARTDIR 
