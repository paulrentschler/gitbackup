#!/bin/bash

##
# Shell script to backup a specified directory by making it a
# Git revision controlled repository.
#
# This script will commit all changes to the repository using a standard
# commit message and then push those changes to the default repository
# configured in the .git/config file.
#
# @author  Paul Rentschler <paul@rentschler.ws>
# @since   7 June 2020
##

syntax () {
    echo "Git-based backup script (gitbackup)"
    echo ""
    echo "    Syntax: ./gitbackup.sh <repo path to backup>"
    echo ""
    echo ""
    echo $1
}

# ensure the directory to back up was passed as a parameter
if [ "$#" -ne 1 ]; then
    syntax "ERROR: No path to the repo to backup provided."
    exit
fi
repo_path=$1

# ensure the directory exists
if [ ! -d $repo_path ]; then
    syntax "ERROR: $repo_path does not exist or is not a directory."
    exit
fi

# ensure the directory is a Git repository
if [ ! -d $repo_path/.git ]; then
    syntax "ERROR: $repo_path is not a Git repository."
    exit
fi

# determine today's date/time for the commit message
backup_date=`date +"%Y-%m-%d"`
backup_time=`date +"%H:%M"`

# add any new files
git -C $repo_path add .

# commit the changes
git -C $repo_path commit -m "regular backup on $backup_date at $backup_time"

# push the changes
git -C $repo_path push
