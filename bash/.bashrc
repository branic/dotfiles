# shellcheck shell=bash
# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    # shellcheck source=/dev/null
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

####################################################
## My Customizations
####################################################

# Use VI mode
set -o vi

# keep from going insane when referencing the info pages
alias info="pinfo"
alias c="clear"

# see what i'm looking for
alias grep="grep --color"

# FiX up less
export LESS="-FiX"

# make sure everything uses less
#export PAGER="less -FiX"
#export PAGER="less"

# make sure vim is used for editing stuff
export EDITOR="gvim -v"
alias vi="gvim -v"
alias vim="gvim -v"

# always use ssh for rsync'ing
export RSYNC_RSH="ssh"

# history options
# 1st, don't put successive, duplicate commands in history file
export HISTIGNORE="&"
# 1st-a don't save lines beginning with a space or is a duplicate of the previous line
export HISTCONTROL=ignoreboth
# 2nd, append each shell's history to my main history file on exit
shopt -s histappend
# 3rd force history to be appended to file after every command
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
# 4th keep a lot of history
HISTSIZE=100000

# dummy-check before destroying a file (after all, i can always use -f )
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# What I really want my path to be (taken from root's path so I can use sudo without full pathing)
#export PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin
export PATH=$PATH:/usr/lib64/qt-3.3/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$HOME/razer:$HOME/.local/bin

# Set shell prompt
# Default is PS1=[\u@\h \W]\$

# Define ansi color sequences
# See https://en.wikipedia.org/wiki/ANSI_escape_code
_BOLD="\e[1m"
_RESET="\e[0m"
_WHITE_FG="\e[37m"
_CYAN_FG="\e[36m"
_MAGENTA_FG="\e[35m"
_BLUE_FG="\e[34m"
_YELLOW_FG="\e[33m"
_GREEN_FG="\e[32m"
_RED_FG="\e[31m"
_BLACK_FG="\e[30m"
_WHITE_BG="\e[47m"
_CYAN_BG="\e[46m"
_MAGENTA_BG="\e[45m"
_BLUE_BG="\e[44m"
_YELLOW_BG="\e[43m"
_GREEN_BG="\e[42m"
_RED_BG="\e[41m"
_BLACK_BG="\e[40m"
_ORANGE_FG="\e[38;5;214m"

HAPPY_FACE="^_^"
SAD_FACE="-_-"

function last_status {
    # Need to use \001 and \002 here otherwise line wrapping doesn't work
    # See https://stackoverflow.com/a/43462720
    if [ $? = 0 ]; then
        echo -e "\001${_GREEN_BG}${_WHITE_FG}${_BOLD}\002 ${HAPPY_FACE} \001${_RESET}\002"
    else
        echo -e "\001${_RED_BG}${_WHITE_FG}\002 ${SAD_FACE} \001${_RESET}\002"
    fi
}
# Use powerline if it is installed
if [ -f "$(which powerline-daemon 2>/dev/null)" ]; then
  powerline-daemon -q
  # shellcheck disable=SC2034
  POWERLINE_BASH_CONTINUATION=1
  # shellcheck disable=SC2034
  POWERLINE_BASH_SELECT=1
  # shellcheck source=/dev/null
  . /usr/share/powerline/bash/powerline.sh
else
  # Format:
  # last_status - Displays a happy face if the previous command has an exit code of zero or a straight face otherwise
  # \u - username
  # \j - number of jobs managed by the shell
  # \W - basename of the current working directory
  # \[ and \] can be used here as we are assigning directly to PS1
  PS1="\$(last_status)\[${_CYAN_BG}\] \u \j \W \[${_RESET}\] \$ "
fi

# Alias to wake up second monitor on Lenovo laptop when connected to dock
alias fixmon="xrandr --output DP2-2 --mode 1024x768 && xrandr --output DP2-2 --auto"

# Set default connection for libvirt
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Functions for working with KVM
function pause_vms {
    if command -v virsh; then
        for i in $(virsh list --name --state-running)
        do
            virsh suspend "${i}"
        done
    else
        echo "virsh not installed."
    fi
}

function resume_vms {
    if command -v virsh; then
        for i in $(virsh list --name --state-running)
        do
            virsh resume "${i}"
        done
    else
        echo "virsh not installed."
    fi
}


# Alias for pretty printing json
alias json='python -m json.tool'

# Alias for tree to always display hidden files/dirs and ignore .git dir
alias tree='tree -a -I .git'

# Alias for Git log display
alias gitlog='git log --oneline --decorate --graph'

# Aliases for URL Encoding and Decoding via pipe or string (encode will also encode slashes)
# Reference https://unix.stackexchange.com/a/216318
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote(  sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1], \"\"))"'
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote(sys.argv[1] if len(sys.argv) > 1 else sys.stdin.read()[0:-1]))"'

# Set the default ruby
if [ -n "$(LC_ALL=C type -t chruby)" ];
then
    chruby ruby-2.5.3
fi

function rhcase() {
    if [ -z "$1" ]; then
        echo "Usage: rhcase [case_number]";
        return 1;
    fi

    URL='https://access.redhat.com/support/cases/#/case/'
    URL+=$1
    xdg-open "$URL"
}

function rhjira() {
    if [ -z "$1" ]; then
        echo "Usage: rhjira [issue_number]";
        return 1;
    fi

    URL='https://issues.redhat.com/browse/'
    URL+=${1^^}
    xdg-open "$URL"
}
