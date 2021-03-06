#!/bin/bash
#
# prerelease.sh
#
# Bumps version number, commits all outstanding modifications,
# adds a git tag and appends draft Changes file entry
#
perl-reversion -bump
perl Build.PL
./Build distmeta
perl-reversion | tail -n1
VERSION=$(grep -P 'Version \d\.*\d{2,2}' lib/Date/Holidays/CZ.pm | cut -d' ' -f2)
echo "$VERSION $(date +'%Y-%m-%d %H:%M %Z')" >>Changes
git --no-pager log $(git describe --tags --abbrev=0)..HEAD --oneline --no-color --reverse >>Changes
echo >>Changes
vi Changes
git commit -as -m $VERSION
git tag -m $VERSION $VERSION
