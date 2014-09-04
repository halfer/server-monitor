Server monitor
===

These are a few scripts I use to keep an eye on a simple VPS - I'm making
it public partly for my convenience, and it might even be useful for someone
else. It has:

- a proxy to Apache's server-status feature
- APC's stats script
- a phpinfo() script
- password protection

To use it you'll need:

- a Unix-like OS
- Git installed
- Apache, obviously

To install it, just do:

- `git clone` this repo
- `cd` to the server-monitor folder
- run `./setup.sh`

It'll set up an htaccess file and get the APC script for you (so you don't have
to trust a copy provided here, and so it is always the latest version). You'll
need to set up the Apache vhost and the password file yourself, as per the
set up instructions.
