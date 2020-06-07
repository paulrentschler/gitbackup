# gitbackup
Shell script for backing up a directory using a Git respository.

## Features

* Only backs up changes to existing and new files
* Can be run often as it only backs up when changes exist
* Works best on text files given the nature of revision control systems

## Requirements

* Bash shell
* Git revision control system

## Installation

1. Install Git
1. Clone the gitbackup repository into /usr/local/scripts/gitbackup
    mkdir -p /usr/local/scripts
    cd /usr/local/scripts
    git clone https://github.com/paulrentschler/gitbackup.git
    chmod 775 gitbackup.sh

## Configure the backup directory/repository

1. Create a Git repository for the files to back up
1. Ensure the repository is using SSH authentication
1. Ensure the user information is configured in the Git repository
    git config user.email "you@example.com"
    git config user.name "Your Name"
1. Setup a SSH deploy key with write access to the repo on GitHub
1. Configure the SSH deploy key for authentication
    git config core.sshCommand "ssh -i /path/to/id_rsa -F /dev/null"

## Schedule the backup

Schedule the backup script to run daily via cron by creating `/etc/cron.d/gitbackups`

    #
    # Schedule tasks to support the Git backup
    #   installed at: /usr/local/scripts/gitbackup
    #

    MAILTO=root

    # Example of job definition:
    # .------------------- minute (0 - 59)
    # |  .---------------- hour (0 - 23)
    # |  |     .---------- day of month (1 - 31)
    # |  |     |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    # |  |     |  |  .---- day of week (0 - 6) (Sunday=0 or 7)
    # |  |     |  |  |
    # *  *     *  *  *        username    command to be executed

    ### Run the Git backup every morning at 5am
     00  5     *  *  *        bakuser     /usr/local/scripts/gitbackup/gitbackup.sh /dir/to/backup > /dev/null 2>&1

    ### Run the Git backup every hour between 8am - 5pm Monday thru Friday
     00  8-17  *  *  mon-fri  bakuser     /usr/local/scripts/gitbackup/gitbackup.sh /other/dir/to/backup > /dev/null 2>&1

## License

This code is Copyright 2020 Paul Rentschler and provided "As Is" under the MIT license. See `LICENSE` for more details.
