# Status

Current status of project is: **unstable, untested**

Use current version with caution.

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