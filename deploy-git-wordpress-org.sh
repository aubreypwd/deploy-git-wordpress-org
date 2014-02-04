#! /bin/bash

# deploy-git-wordpress-org.sh
# =================================================
# By: Aubrey Portwood
# https://github.com/aubreypwd/deploy-git-wordpress-org
# Version: 1.0
# =================================================
# Based on:
# https://github.com/brainstormmedia/deploy-plugin-to-wordpress-dot-org/blob/master/deploy.sh
# =================================================

# HEADERS MUST BE FORMATTED LIKE:
# =================================================
# /*
# Plugin Name: Google Destination URL
# Plugin URI: https://bitbucket.org/aubreypwd/gdurl
# Description: Perform a Google Search when adding a link in the editor.
# Version: 1.0
# Author: Aubrey Portwood
# Author URI: http://profiles.wordpress.org/aubreypwd/
# License: GPL2
# */ 
# 
# DOCBLOCKS DO NOT WORK!


echo "<deploy-git-wordpress-org>"
echo "=================================="

# Current directory
PLUGINSLUG=${PWD##*/}
CURRENTDIR=`pwd`
SVNIGNORE="deploy-git-wordpress-org
	README.md
	readme.md
	.hg
	.hgcheck
	.hgignore
	.git
	.gitignore"

echo "- We will be ignoring some files in your Git repo:"
echo $SVNIGNORE

# Deps
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then 
	echo "Usage: sh deploy.wordpress.org.sh [plugin_file_with_header.php] [WordPress.org Username] [Update Readme Only: true|false]";
	echo "I.e.: sh deploy.wordpress.org.sh index.php aubreypwd false";
	exit 1;
fi

# Temp place to put the SVN
SVNPATH="/tmp/$PLUGINSLUG"
SVNURL="http://plugins.svn.wordpress.org/$PLUGINSLUG"

echo "- Checking to make sure that your plugin and the stable tag in readme.txt are the same..."

# readme.txt Checks
NEWVERSION1=`grep "^Stable tag" $CURRENTDIR/readme.txt | awk -F' ' '{print $3}' | sed 's/[[:space:]]//g'`
	
	echo "- readme.txt Version: $NEWVERSION1"

NEWVERSION2=`grep "^Version" $CURRENTDIR/$1 | awk -F' ' '{print $2}' | sed 's/[[:space:]]//g'`
	
	echo "- $1 Version: $NEWVERSION2"

# Commit Message
echo "- SVN Commit Message: \c"
read COMMITMSG

# SVN Work
svn co $SVNURL $SVNPATH
echo "- Just made a temporary copy of your SVN repo to $SVNPATH"

LANG1="- Just copied your Git repo to our temporary clone of your svn repo to $SVNPATH/trunk"
LANG2="- Committing your changes to WP.org..."

# Exit if they don't match
if [ "$NEWVERSION1" != "$NEWVERSION2" ]; then echo "- Versions don't match, sorry. Try again. Exiting...."; exit 1; fi

# If readme $3 is true
if [ $3 = "true" ]; then

	echo "- You are just updating your readme.txt to the stable tag $SVNPATH/tags/$NEWVERSION2..."

	# Export master to SVN
	git checkout-index -a -f --prefix=$SVNPATH/trunk/
	echo "$LANG1"

	cd $SVNPATH/trunk/

	# Ignore some common files
	svn propset svn:ignore "$SVN_IGNORE" "$SVNPATH/trunk/"
	
	# Copy the readme from trunk to the stable tag.
	cp $SVNPATH/trunk/readme.txt $SVNPATH/tags/$NEWVERSION1/readme.txt
	echo "- Just copied readme.txt from $SVNPATH/trunk/readme.txt to $SVNPATH/tags/$NEWVERSION1/readme.txt."

	cd $SVNPATH/

	echo "$LANG2"
	svn commit --username=$2 -m "$COMMITMSG"

else

	# Export master to SVN
	git checkout-index -a -f --prefix=$SVNPATH/trunk/
	echo "$LANG1"

	# Ignore some common files
	svn propset svn:ignore "$SVN_IGNORE" "$SVNPATH/trunk/"

	# More SVN Work (commit)
	cd $SVNPATH/trunk/

	# Addremove (YES!)
	svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
	echo LANG1

	# Commit the code
	echo "$LANG2"
	svn commit --username=$2 -m "$COMMITMSG"

	# Commit the tag
	cd $SVNPATH

	echo "- Copying files from $SVNPATH/trunk to $SVNPATH/tags/$NEWVERSION2"
	svn copy trunk/ tags/$NEWVERSION1/
	cd $SVNPATH/tags/$NEWVERSION1

	echo "- Comitting $NEWVERSION2 to WP.org..."
	svn commit --username=$2 -m "Version/Tag: $NEWVERSION1"

fi

# Cleanup!
echo "- Removing the SVN repo at $SVNPATH"
rm -fr $SVNPATH/

cd $CURRENTDIR
