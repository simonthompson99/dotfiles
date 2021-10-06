# aliases
alias proj='cd ~/Documents/Projects'
alias shproj='cd ~/Documents/Projects/short-projects'
alias utils='cd ~/Documents/Utilities'
alias scratch='cd ~/scratch'
alias vim="nvim"
alias rr='ranger'
alias ip='iPython'
alias lal='ls -al'

# keep getting into trouble calling script by mistake when should be calling Rscript
alias script='echo "you did NOT want to do that\n"'

# alias to run twosets and quicktab
alias twosets='python /Users/simonthompson/Documents/Utilities/mini_utilities/twosets/twosets.py'
alias quicktab='python /Users/simonthompson/Documents/Utilities/mini_utilities/quicktab/quicktab.py'
alias mquicktab='python /Users/simonthompson/Documents/Utilities/mini_utilities/mquicktab/mquicktab.py'

# Virtualenv aliases and functions
alias vcreate='virtualenv venv -p python3'
function vact () {
	source venv/bin/activate
	# && tmux select-pane -P 'fg=blue'
}
function vdeact () {
	deactivate
	#tmux select-pane -P 'fg=default'
}

## aliases for connecting to cdt server stuff
#-- function to connect to dams db copy
function dams () {
	echo -ne "\033]0;"DAMS"\007"
	clear
	echo "[.....          [.       [..       [..  [.. ..  ";
	echo "[..   [..      [. ..     [. [..   [...[..    [..";
	echo "[..    [..    [.  [..    [.. [.. [ [.. [..      ";
	echo "[..    [..   [..   [..   [..  [..  [..   [..    ";
	echo "[..    [..  [...... [..  [..   [.  [..      [.. ";
	echo "[..   [..  [..       [.. [..       [..[..    [..";
	echo "[.....    [..         [..[..       [..  [.. ..  ";
	echo "                                                ";
	colorssh -L 5438:10.1.24.33:5432 sthompson@10.1.24.38
}

#-- alias to connect to ddf Prod db copy
alias ddfprod="clear; echo 'DDF PROD'; ssh -L 5439:10.1.24.34:5432 sthompson@10.1.24.38"

#-- function to connect to mis db copy
function mis () {
	echo -ne "\033]0;"MIS"\007"
	clear 
	echo "__/\\\\____________/\\\\__/\\\\\\\\\\\_____/\\\\\\\\\\\___        ";
	echo " _\/\\\\\\________/\\\\\\_\/////\\\///____/\\\/////////\\\_       ";
	echo "  _\/\\\//\\\____/\\\//\\\_____\/\\\______\//\\\______\///__      ";
	echo "   _\/\\\\///\\\/\\\/_\/\\\_____\/\\\_______\////\\\_________     ";
	echo "    _\/\\\__\///\\\/___\/\\\_____\/\\\__________\////\\\______    ";
	echo "     _\/\\\____\///_____\/\\\_____\/\\\_____________\////\\\___   ";
	echo "      _\/\\\_____________\/\\\_____\/\\\______/\\\______\//\\\__  ";
	echo "       _\/\\\_____________\/\\\__/\\\\\\\\\\\_\///\\\\\\\\\\\/___ ";
	echo "        _\///______________\///__\///////////____\///////////_____";
	colorssh -L 5440:10.1.24.37:5432 sthompson@10.1.24.38
}

#-- function to connect to index db
function indx () {
	echo -ne "\033]0;"INDX"\007"
	clear
	echo "::::::::::: ::::    ::: :::::::::  :::    ::: ";
	echo "    :+:     :+:+:   :+: :+:    :+: :+:    :+: ";
	echo "    +:+     :+:+:+  +:+ +:+    +:+  +:+  +:+  ";
	echo "    +#+     +#+ +:+ +#+ +#+    +:+   +#++:+   ";
	echo "    +#+     +#+  +#+#+# +#+    +#+  +#+  +#+  ";
	echo "    #+#     #+#   #+#+# #+#    #+# #+#    #+# ";
	echo "########### ###    #### #########  ###    ### ";
	colorssh -L 5441:10.1.24.39:5432 sthompson@10.1.24.38
}

# function to open up temporary file in vim, can specify file extension after command
# defaults to txt
function mktmp () {
	FILE_SUFFIX=${1:-txt}
	FILE_NAME="/Users/simonthompson/scratch/tmp$(date +%Y%m%d%H%M%S).$FILE_SUFFIX"
	vim $FILE_NAME
}

# Changing iTerm2 color in MacOSX when SSHing (so you know at a glance that you're no longer in Kansas)
# Adapted from https://gist.github.com/porras/5856906
# 1. Create a theme in your terminal setting with the name "SSH" and the desired colors, background, etc.
# 2. Add this to your .bash_profile (or .bashrc, I always forget the difference ;))
# 3. Optional but useful: in the terminal, go to Settings > Startup and set "New tabs open with" to
#    "default settings" (otherwise, if you open a new tab from the changed one, you get a local tab with
#    the SSH colors)

function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi # if you have trouble with this, change
                                                      # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

function colorssh() {
	# change either tmux background or terminal background color when sshing
  	if [[ "$TERM" = "screen"* ]] && [[ -n "$TMUX" ]]; then
  		# if in tmux then get window and pane index of where we are
		tmux_pane_index=$(tmux display -pt "${TMUX_PANE:?}" '#{pane_index}')
		tmux_win_index=$(tmux display-message -p '#I')
		# turn foreground yellow
		tmux select-pane -t:$tmux_win_index.$tmux_pane_index -P 'fg=yellow'
		# run ssh and turn it back to default if it executes, or if it fails (pipes through to ||)
		ssh $* && tmux select-pane -t:$tmux_win_index.$tmux_pane_index -P 'fg=default' || tmux select-pane -t:$tmux_win_index.$tmux_pane_index -P 'fg=default'
	else
		tabc SSH && ssh $* && tabc || tabc
	fi;
}

# allow searching of google and stackoverflow from command line
function ggl() {
    open -na "Firefox" --args "https://www.google.com/search?q=$*"
}

function rsync_rename() {
    # script to rsync then move load of files, quicker than individual scp
    # usage: rsync_rename files.txt
    # where files.txt is a pipe-separated file of <remote_path>|<local_path_to_move_to>
    input_file="$1"
    remote=${2:-sthompson@10.1.24.38}
    files_to_rsync=$(cut "-d|" -f1 $input_file)
    echo $files_to_rsync | tr " " "\n" | rsync -arvzh --progress $remote:/ /tmp --files-from=- 
    cat $input_file | while IFS='|' read src dest; do
        src="/tmp${src}"
        mkdir -p "$(dirname "${dest}")"
        cp $src $dest
    done
}
