# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
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
export GREP_COLOR="35"
alias grep="grep --color"

# FiX up less
export LESS="-FiX"

# make sure everything uses less
#export PAGER="less -FiX"
#export PAGER="less"

# make sure vim is used for editing stuff
export EDITOR="vim"

# always use ssh for rsync'ing
export RSYNC_RSH="ssh"

# history options
# 1st, don't put successive, duplicate commands in history file
export HISTIGNORE="&"
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
export PATH=$PATH:/usr/lib64/qt-3.3/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$HOME/razer

# Add RVM Path for Ruby scripting
#export PATH=$PATH:$HOME/.rvm/bin
# source ~/.profile

# Set shell prompt
# Default is PS1=[\u@\h \W]\$
# Use powerline if it is installed
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
else
  PS1="\`if [ \$? = 0 ]; then echo \[\e[33\;42m\]\\\^\\\_\\\^\[\e[0m\]; else echo \[\e[36\;44m\]\\\-\\\_\[\e[36\;44m\]\\\-\[\e[0m\]; fi\` \[\e[38;41m\]\u \[\e[0;36;41m\]\j \[\e[1;32;41m\]\!\[\e[01;34;41m\] \W\[\e[0m\] \[\e[30m\]\[\e[00m\]\$ "
fi

# Alias to wake up second monitor on Lenovo laptop when connected to dock
alias fixmon="xrandr --output DP2-2 --mode 1024x768 && xrandr --output DP2-2 --auto"

# Set default connection for libvirt
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Aliases for working with KVM
alias pause='for i in $(virsh list --name --state-running); do virsh suspend $i; done'
alias resume='for i in $(virsh list --name --state-paused); do virsh resume $i; done'

# Alias for pretty printing json
alias json='python -m json.tool'

# Alias for tree to always display hidden files/dirs and ignore .git dir
alias tree='tree -a -I .git'

# Alias for Git log display
alias gitlog='git log --oneline --decorate --graph'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
