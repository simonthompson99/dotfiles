# go to my projects folder
alias proj='cd ~/Documents/Projects'
alias shproj='cd ~/Documents/Projects/short-projects'

# go to scratch folder
alias scratch='cd ~/scratch'

# run the ddf connection script
alias ddf='bash ~/scripts/ddf-connect/ddf_ssh.sh'

# added by Anaconda3 5.0.1 installer
export PATH="/Users/simonthompson/anaconda3/bin:$PATH"

# alias for vim to nvim
alias vim="nvim"

# alias to run twosets and quicktab
alias twosets='python /Users/simonthompson/Documents/Projects/utilities/twosets/twosets.py'
alias quicktab='python /Users/simonthompson/Documents/Projects/utilities/quicktab/quicktab.py'
alias mquicktab='python /Users/simonthompson/Documents/Projects/utilities/mquicktab/mquicktab.py'

## aliases for connecting to cdt server stuff
#-- alias to connect to dams db copy
alias dams="clear; echo 'DAMS'; ssh -L 5438:10.1.24.33:5432 sthompson@10.1.24.38"

#-- alias to connect to ddf Prod db copy
alias ddfprod="clear; echo 'DDF PROD'; ssh -L 5439:10.1.24.34:5432 sthompson@10.1.24.38"

#-- alias to connect to mis db copy
alias mis="clear; echo 'MIS'; ssh -L 5440:10.1.24.37:5432 sthompson@10.1.24.38"

#-- alias to connect to index db
alias indx="clear; echo 'INDEX'; ssh -L 5441:10.1.24.39:5433 sthompson@10.1.24.38"

#-- function to make scp to query box easier
toqueryscp() {
	scp "$1" sthompson@10.1.24.38:/home/sthompson/"$2"
}
fromqueryscp() {
	scp sthompson@10.1.24.38:/home/sthompson/"$1" "$2"
}

# function to open up temporary file in vim, can specify file extension after command
# defaults to txt
mktmp() {
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
  tabc SSH
  ssh $*
  tabc
}

alias ssh="colorssh"

#add in fzf commands
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
