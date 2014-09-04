#!/bin/bash
#
# Set-up script for basic password-protected scripts for APC and
# Apache status monitoring. The mod_status module must be enabled in
# your server. It is usually available only to localhost, so we
# proxy it in the apache.php script.

echo

# Fetch the latest master of the APC script
echo "1. Fetching the APC script from git.php.net, it's a just a small file..."
wget -q -O apc.php http://git.php.net/?p=pecl/caching/apc.git;a=blob_plain;f=apc.php;hb=HEAD

echo "2. Writing an htaccess file..."
FOLDER=`pwd` && cat htaccess.txt | sed -e "s|__PWD__|$FOLDER|" > .htaccess

# Add some instructions
echo -e "\
3. Make sure Apache is configured to allow the htaccess file to take
   effect, for example:

	# Allow indexed folders
	Options Indexes
	# Allow passwording, allow allow/deny
	AllowOverride AuthConfig Limit

4. You need to set a password. You can use something simple like
   this (drop the -c if you are not creating the file for the first time):

	htpasswd -c passwords <username>
"
