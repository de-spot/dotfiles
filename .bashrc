# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export LC_ALL=C.UTF-8
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# DeSpot BEG
#COLOR_PS_READLINE=$(tput setaf 7)
COLOR_BLACK="\e[30m"
COLOR_RED="\e[31m"
COLOR_GREEN="\e[32m"
COLOR_YELLOW="\e[33m"
COLOR_BLUE="\e[34m"
COLOR_MAGENTA="\e[35m"
COLOR_CYAN="\e[36m"
COLOR_LIGHT_GRAY="\e[37m"
COLOR_GRAY="\e[90m"
COLOR_WHITE="\e[97m"

str_to_color() {
    # get "random" string that depends on string, take first 2 bytes, convert to dec, then range to 32-37
    echo $1|md5sum|cut -c-2|xargs -i printf "%d\n" "0x{}"|awk '{print int($0/255.0*(37-32)+32)}'
}
# Git-related BEG
# Do not allow for root, as involves uncontrollable external resource
if [ $(id -u) -ne 0 -a -f ~/.git-setup ]; then
    source ~/.git-setup
fi
gen_ps_pwd() {
# TODO: measure curent dir length and shorten path if too long; use next line for beginning
# echo $PWD | sed -E -e "s:^${HOME}:~:" -e "s:([^/\.]{5})[^/]+/:\1/:g"
#TODO: Incomplete!
   # Skip for root, see comment above for .git-setup
   if [ $(id -u) -eq 0 ]; then
       echo '\w'
       return
   fi
   echo '\w'
   return
   local p1 p2
   if [[ is_inside_git ]]; then
       p1=$(dirname $PWD)
       p2=${p1/$HOME/\~}/123
#       echo "from: $p1    to: $p2"
       echo "$p2"
   else
       echo '\w 456'
   fi
}
# Git-related END
gen_ps_userhost() {
    local hostpart userpart
    hostpart=$(str_to_color $HOSTNAME)
    if [ $EUID -eq 0 ]; then
        userpart='31' # RED
    else
        userpart=$(str_to_color $USER)
    fi
    printf '\[\e[%d;1m\]\\u\[\e[m\]@\[\e[%d;1m\]\h\[\e[m\]' "$userpart" "$hostpart"
}
PS1="$(gen_ps_userhost)"'\$ '
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
COLOR_PS_READLINE="${COLOR_WHITE}"
COLOR_PS_DEFAULT=${COLOR_WHITE}
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
   PS1="$(gen_ps_userhost)"'\[\e[00m\]:\[\e[01;34m\]'$(gen_ps_pwd)'\[\e[00m\]'"$(gen_git_part)"' \$ '"${COLOR_PS_READLINE}"
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

if [ -x ~/.ssh-agent-ensure ]; then
    ~/.ssh-agent-ensure
    . ~/.ssh/agent.env
fi
# My aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# DeSpot END

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#DeSpot BEG
export HISTCONTROL=erasedups:ignoreboth
export HOSTNAME #need for screen
if [ -x ~/.bashrc_${USER} ]; then
  . ~/.bashrc_${USER}
fi
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if command -v kubectl &>/dev/null ; then
    source <(kubectl completion bash)
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/home/despot/.local/bin"
