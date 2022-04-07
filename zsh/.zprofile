# important folders
MY_PROJ_FOLDER="/Users/simonthompson/prj"
MY_SCRATCH_FOLDER="/Users/simonthompson/scr"
MY_UTILS_FOLDER="/Users/simonthompson/env/utilities"

# aliases
alias prj='cd $MY_PROJ_FOLDER'
alias shproj='cd $MY_PROJ_FOLDER/short-projects'
alias utils='cd $MY_UTILS_FOLDER'
alias scr='cd $MY_SCRATCH_FOLDER'
alias vim="nvim"
alias rr='pyenv activate utils && ranger && pyenv deactivate'
# alias ip='iPython'
alias vd='pyenv activate utils && visidata && pyenv deactivate'
alias lal='ls -al'
alias tsm='tmuxinator start main'
alias lg='lazygit'

# keep getting into trouble calling script by mistake when should be calling Rscript
alias script='echo "you did NOT want to do that\n"'

# alias to run twosets and quicktab
alias twosets='pyenv activate utils && python $MY_UTILS_FOLDER/twosets/twosets.py & pyenv deactivate'
alias quicktab='pyenv activate utils && python $MY_UTILS_FOLDER/quicktab/quicktab.py & pyenv deactivate'
alias mquicktab='pyenv activate utils && python $MY_UTILS_FOLDER/mquicktab/mquicktab.py & pyenv deactivate'

# function to open up temporary file in vim, can specify file extension after command
# defaults to txt
function mktmp () {
	FILE_SUFFIX=${1:-txt}
	FILE_NAME="$MY_SCRATCH_FOLDER/$(date +%Y%m%d%H%M%S).$FILE_SUFFIX"
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

function backup() {
    # function to backup a folder excluding files/directories in a
    # .buignore reference file
    # .buginore should be list of either files or folders to be excluded
    # e.g.:
    # *.DS_Store
    # ignore-fldr
    
    BACKUP_ROOT=${1:?"missing backup root"}
    BACKUP_DEST=${2:?"missing backup destination"}
    BACKUPTIME=`date +%y-%m-%d` #get the current date
    BACKUP_FILENAME="$BACKUP_DEST-$BACKUPTIME.tar.gz"

    if [ -f $BACKUP_ROOT/.buignore ]; then

        echo "-- ignoring files from $BACKUP_ROOT/.buignore"
        tar czfv "$BACKUP_FILENAME" -X "$BACKUP_ROOT/.buignore" $BACKUP_ROOT

    else

        echo "-- no .buignore file found"
        tar czfv "$BACKUP_FILENAME" $BACKUP_ROOT

    fi

    echo "-- backup $BACKUP_ROOT to $BACKUP_FILENAME done"

}

# some init stuff
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init --path)"
