# Usage

Usage: `sh deploy.wordpress.org.sh [plugin_file_with_header.php] [WordPress.org Username] [Update Readme Only: true|false]`
I.e.: `sh deploy.wordpress.org.sh index.php aubreypwd false`

# Download Script

[Download](https://raw.githubusercontent.com/aubreypwd/deploy-git-wordpress-org/1.0-summit/deploy-git-wordpress-org.sh) *(Right Click and Save As)*

# Add to your project

*Replace `1.0-summit` below with `master` for the in-development version.*

## Add as a Subtree

	git subtree add --prefix deploy-git-wordpress-org https://github.com/aubreypwd/deploy-git-wordpress-org 1.0-summit --squash

### Update to the latest from the repository

	git subtree pull --prefix deploy-git-wordpress-org https://github.com/aubreypwd/deploy-git-wordpress-org 1.0-summit --squash

## As as Submodule

	git submodule add -b 1.0-summit https://github.com/aubreypwd/deploy-git-wordpress-org

_______________________

# Changelog

## 1.0 "Summit"

- Now accepts 3rd parameter that tells the script whether to just update the readme.txt or re-tag.
