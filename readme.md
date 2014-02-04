# Status

Current status of project is: **stable, ~~unstable~~, ~~untested~~, needs-community-testing**

Things appear to be stable.

- Tested the readme.txt update with success at https://plugins.trac.wordpress.org/changeset/851031 using true readme update switch.
- Tested the tag deploy method (old method) at http://plugins.trac.wordpress.org/changeset/851034 and http://plugins.trac.wordpress.org/changeset/851035

# How to use

Usage: `sh deploy.wordpress.org.sh [plugin_file_with_header.php] [WordPress.org Username] [Update Readme Only: true|false]`
I.e.: `sh deploy.wordpress.org.sh index.php aubreypwd false`

## Add to your repo as a subtree

	git subtree add --prefix deploy-git-wordpress-org https://github.com/aubreypwd/deploy-git-wordpress-org master --squash

## Update to the latest from the repository

	git subtree pull --prefix deploy-git-wordpress-org https://github.com/aubreypwd/deploy-git-wordpress-org master --squash

Or, use `sh deploy-git-wordpress-org/update-subtree.sh` once you've already added it.

# Changelog

## 1.0

* Now accepts 3rd parameter that tells the script whether to just update the readme.txt or re-tag.