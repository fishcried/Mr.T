#!/bin/bash
#
# The MIT License (MIT)
# Copyright (c) 2014 fishcried(tianqing.w@gmail.com)
#

LOG() {
	echo "$(date +'%Y/%m/%d %T')-> $@" 
}

SYNC_FILE="rsync -vl"
SYNC_DIR="rsync -vlr"
SYNC_DIR_S="rsync -vlr --delete"

plugin_dir="$HOME/.tmux/plugins"

LOG "Begin install tmux-plugin"
if [ ! -e "$plugin_dir" ]; then
	mkdir -p $plugin_dir
fi

if [ ! -e "$plugin_dir/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm $plugin_dir/tpm
else
	LOG "Tmux-plugin　has installed, just update"
	pushd $plugin_dir/tpm
	git pull origin master
	popd
fi

LOG "End install tmux-plugin"

LOG "Begin config Tmux ..."
$SYNC_DIR_S configs/ ~/.tmux/configs/
mv ~/.tmux/configs/main.conf ~/.tmux.conf
LOG "End config Tmux ..."

LOG "Begin sync workspace profiles"
$SYNC_DIR workspaces/ ~/.tmuxp/
LOG "End sync workspace profiles"
