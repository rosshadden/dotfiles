#!/usr/bin/env bash

action=$1

file=`date +'%Y-%m-%d-%T.png'`
# TODO: read this from an env variable
path=~/Dropbox/Public/media/images/ss/$file

# take screenshot
if [[ $action == 'select' || $action == 'window' ]]; then
	escrotum -s $path
else
	escrotum $path
fi

# TODO: only do this if dropbox is passed as an argument
# generate public url
url=`dropbox puburl $path`

# copy the public url
echo $url | xsel -ib

notify-send "Screenshot taken" "path: $path\n\nURL: $url\n\nURL copied to clipboard."
