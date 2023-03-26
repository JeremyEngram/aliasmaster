# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#    alias ls='ls --color=auto'
#    alias dir='dir --color=auto'
#    alias vdir='vdir --color=auto'

#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
#fi

# colored GCC warnings and errors
 export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


# ADDITIONAL USER ALIASES
if [ -f ~/.bashrc_aliases ]; then
    . ~/.bashrc_aliases
fi

# USER FUNCTIONS
if [ -f ~/.bashrc_functions ]; then
    . ~/.bashrc_functions
fi

# EASY WAY TO ADD ALIASES
function addalias() {
  local name=$1 value="$2"
  echo alias $name=\'$value\' >>~/.bash_aliases
  eval alias $name=\'$value\'
  alias $name
}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
 sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#####################################################################

# LOG ALL COMMANDS TO /VAR/LOG/COMMANDS.LOG VIA RSYSLOG

whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'

#####################################################################

alias arm='sudo chmod +x'

alias implement='sudo apt install -y'
alias dropoff='sudo apt remove -y'
#alias blowoff='sudo apt clean && sudo apt purge && sudo apt autoremove'
alias arm='sudo chmod +x'
alias newshell='gnome-terminal'
alias url2pdf='wkhtmltopdf'
alias ducks='du -cks * | sort -rn | head'
alias ducks2='find /home/research -type f -printf %s %p\n'
alias add2zip='read -p add2zip:  add sudo zip -ur '
alias blowoff='sudo apt-get clean; sudo apt-get autoclean sudo apt-get purge; sudo apt autoremove sudo apt get check'
alias systemlog='journalctl -xe'
alias tarup='tar -zcf'
alias tardown='tar -zxf'
alias update='sudo apt update; sudo apt upgrade'
alias add2zip='read -p add2zip:  add sudo zip -ur '
alias ls7z='sudo 7z -l'
alias startscripting='script -a -f /tmp/script_log.txt && cp /tmp/script_log.txt ~/Desktop/'
#alias recterm='script -aq /home/research/term.log-Sun 19 Mar 2023 11:28:54 AM EDT'
alias networkrst='sudo service network-manager restart'
alias findfile='find . -name'
#alias phoneterm='gnome-terminal -x /run/user/1000/gvfs/mtp:host=TCL_A508DL_N79XRWO7XO8P7XBQ'
alias fixmissing='sudo apt-get update --fix-missing'
alias findandremoveall='read -p findrm: file; find . -type f -name * | xargs rm -f'
alias truncatedirs='find . -depth -mindepth 1 -type d -empty -exec rmdir {} \;'
alias untarall='tar -zxvf *.tar.gz'
alias tardown='tar -zxf'
alias tarup='tar -zcf'
alias zerousb='read -p zerodeviceusb setdev; sudo dd if=/dev/zero of=dev/ status=progress'
alias servicesreport='sudo service --status-all | tee -a ~/Desktop/servicesreport.log'

eval "$(direnv hook bash)"

alias vscodetunnel='xdg-open https://vscode.dev/tunnel/masterclient/c:/Users/jeremy'

# armed awesome github installer and scripts
export PATH=$HOME/.local/share/bin/awesome:$PATH
export PATH=$HOME/.local/share/bin:$PATH

# END ALIASES ################################################################


# OPENAI API KEY #############################################################
export OPENAI_KEY=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
