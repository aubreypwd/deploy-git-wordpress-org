# Avoid Errors

Always change the tag when using deploy to avoid adding `/trunk > /tags/{existing tag}/trunk`.

# How to use

	sh deploy.wordpress.org.sh [plugin_file_with_header.php] [WordPress.org Username]

## Example

	sh deploy.wordpress.org.sh index.php aubreypwd

## Add to your repo as a subtree

	git subtree add --prefix deploy-git-wordpress-org https://github.com/aubreypwd/deploy-git-wordpress-org master --squash

## Periodically update (Updates your script from this repo)

	git subtree pull --prefix deploy-git-wordpress-org https://github.com/aubreypwd/deploy-git-wordpress-org master --squash

Or use `sh deploy-git-wordpress-org/update-subtree.sh` once you've already added it.