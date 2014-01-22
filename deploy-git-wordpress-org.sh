#! /bin/bash

# HEADERS MUST BE FORMATTED LIKE:
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
# /** DOCBLOCKS DO NOT WORK!

# Based on:
# https://github.com/brainstormmedia/deploy-plugin-to-wordpress-dot-org/blob/master/deploy.sh
# =========================================================

# Current directory
PLUGINSLUG=${PWD##*/}
CURRENTDIR=`pwd`

# Deps
if [ -z "$1" ] || [ -z "$2" ]; then 
	echo "Usage: sh deploy.wordpress.org.sh [plugin_file_with_header.php] [WordPress.org Username]"; 
	exit 1;
fi

# Temp place to put the SVN
SVNPATH="/tmp/$PLUGINSLUG"
SVNURL="http://plugins.svn.wordpress.org/$PLUGINSLUG" 

# readme.txt Checks
NEWVERSION1=`grep "^Stable tag" $CURRENTDIR/readme.txt | awk -F' ' '{print $3}' | sed 's/[[:space:]]//g'`
	
	echo "readme.txt Version: $NEWVERSION1"

NEWVERSION2=`grep "^Version" $CURRENTDIR/$1 | awk -F' ' '{print $2}' | sed 's/[[:space:]]//g'`
	
	echo "$1 Version: $NEWVERSION2"

# Exit if they don't match
if [ "$NEWVERSION1" != "$NEWVERSION2" ]; then echo "Versions don't match, sorry. Try again."; exit 1; fi

# Commit Message
echo "SVN Commit Message: \c"
read COMMITMSG

# SVN Work
svn co $SVNURL $SVNPATH

# Export master to SVN
git checkout-index -a -f --prefix=$SVNPATH/trunk/

# Ignore some common files
svn propset svn:ignore "deploy-git-wordpress-org
README.md
readme.md
.hg
.hgcheck
.hgignore
.git
.gitignore" "$SVNPATH/trunk/"

# More SVN Work (commit)
cd $SVNPATH/trunk/

# Addremove (YES!)
svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add

# Commit the code
svn commit --username=$2 -m "$COMMITMSG"

# Commit the tag
cd $SVNPATH
svn copy trunk/ tags/$NEWVERSION1/
cd $SVNPATH/tags/$NEWVERSION1
svn commit --username=$2 -m "Version/Tag: $NEWVERSION1"

# Cleanup!
rm -fr $SVNPATH/

cd $CURRENTDIR