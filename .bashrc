#
# The Personal Bashrc file of Janic Voser
# Its just an Bashrc file modify it the Way you want.
#
# Version 0.1
#
#

#Config options
enable_colours=yessir
enable_fancy_terminal=yessir
command_line=user #user, root or other (Only color dependent)
fav_editor=vim
enable_aliases=yessir
favtermmonitor=gotop #enter comand for your favorit ressource monitor (Prefered Terminal based) Examples: top,htop,bashtop,gotop
#Services Config
ssh_service=sshd #enter your ssh service
web_service=apache2 #apache2, httpd, nginx, lighttpd (webserver-service) used for system-control



# Set VIM to be the default editor
export EDITOR=$fav_editor
export VISUAL=$fav_editor

#Set Colors
if [ "$enable_colours" == "yessir" ] ; then
  # Normal Colors
  Black='\e[0;30m'        # Black
  Red='\e[0;31m'          # Red
  Green='\e[0;32m'        # Green
  Yellow='\e[0;33m'       # Yellow
  Blue='\e[0;34m'         # Blue
  Purple='\e[0;35m'       # Purple
  Cyan='\e[0;36m'         # Cyan
  White='\e[0;37m'        # White

  # Bold
  BBlack='\e[1;30m'       # Black
  BRed='\e[1;31m'         # Red
  BGreen='\e[1;32m'       # Green
  BYellow='\e[1;33m'      # Yellow
  BBlue='\e[1;34m'        # Blue
  BPurple='\e[1;35m'      # Purple
  BCyan='\e[1;36m'        # Cyan
  BWhite='\e[1;37m'       # White

  # Background
  On_Black='\e[40m'       # Black
  On_Red='\e[41m'         # Red
  On_Green='\e[42m'       # Green
  On_Yellow='\e[43m'      # Yellow
  On_Blue='\e[44m'        # Blue
  On_Purple='\e[45m'      # Purple
  On_Cyan='\e[46m'        # Cyan
  On_White='\e[47m'       # White

  NC="\e[m"               # Color Reset

  RESET="\[\017\]"
  NORMAL="\[\033[0m\]"
  WHITE="\[\033[37;1m\]"
  BLUE="\[\033[34;1m\]"
  RED="\[\033[31;1m\]"
  YELLOW="\[\033[33;1m\]"
  GREEN="\[\033[32;1m\]"
  SUCCESS="${GREEN}:)${NORMAL}"
  FAILURE="${RED}:(${NORMAL}"
fi

##############################################################################
#                           Fancy Terminal Prompt                            #
##############################################################################

if [ "$enable_fancy_terminal" == "yessir" ] ; then
  # Enable colours for grep, egrep, zgrep, etc.
  export CLICOLOR=1
  # This method is deprecated in a number of OS'
  # export GREP_OPTIONS='--color=auto'

  # Select Statement
  SELECT="if [ \$? = 0 ]; then echo \"${SUCCESS}\"; else echo \"${FAILURE}\"; fi"

  if [ "$command_line" == "user" ] ; then
    # <user>@<hostname> <working directory> <last command successful> >
    # codefined@server ~/working/directory :) >
    PS1="${RESET}${GREEN}\u${Purple}@${YELLOW}\h${NORMAL} ${BLUE}\w${NORMAL} \`${SELECT}\` ${YELLOW}>${NORMAL} "
  elif [ "$command_line" == "root" ] ; then
    # (<user>@<server>)-(<jobs>)-(<date>)->
    # (<~/currentDir>)-(<num files> files, <folder_size> kb)->
    PS1="${RESET}${RED}\u${Purple}@${YELLOW}\h${NORMAL} ${BLUE}\w${NORMAL} \`${SELECT}\` ${YELLOW}>${NORMAL} "
  elif [ "$command_line" == "other" ] ; then
    # (time) (user)@(hostname) ~$
    # 12:44:53 codefined@server ~$
    PS1="${RESET}${WHITE}\u${Purple}@${YELLOW}\h${NORMAL} ${BLUE}\w${NORMAL} \`${SELECT}\` ${YELLOW}>${NORMAL} "
  fi

  # Color for manpages
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;31m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;44;33m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;32m'
fi

##############################################################################
#                          Machine Specific Aliases                           #
#############################################################################

# Alias to go to common locations
#
if [ "$enable_aliases" == "yessir" ] ; then
  alias ll='ls -lait --color=auto'
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias e=$fav_editor
  alias resmon="$favtermmonitor"
  #Folder Shortcuts
  alias dow="cd ~/Downloads"
  alias doc="cd ~/Documents"
  alias des="cd ~/Desktop"
  alias mus="cd ~/Music"
  alias pic="cd ~/Pictures"
  alias vid="cd ~/Videos"
  alias nxc="cd ~/Nextcloud"
  alias h="cd ~"
  alias etc="cd /etc"
  alias lib="cd /lib"
  alias var="cd /var"
  alias web='cd /var/www/html'

  #Services Shortcuts
  alias sysres="systemctl restart"
  alias sysrel="systemctl reload"
  alias syssta="systemctl start"
  alias syssto="systemctl stop"
  alias sysstat="systemctl status"
  #SSH Shortcuts
  alias sshres="systemctl restart $ssh_service"
  alias sshrel="systemctl reload $ssh_service"
  alias sshsta="systemctl start $ssh_service"
  alias sshsto="systemctl stop $ssh_service"
  alias sshstat="systemctl status $ssh_service"
  #Webservice Shortcuts
  alias wwwres="systemctl restart $web_service"
  alias wwwrel="systemctl reload $web_service"
  alias wwwsta="systemctl start $web_service"
  alias wwwsto="systemctl stop $web_service"
  alias wwwstat="systemctl stat $web_service"
  #Function
  alias hi="host_information"
fi

##############################################################################
#                         Custom Information Commands                        #
##############################################################################

# Get host information
function host_information()
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additional information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Local IP Address :$NC" ; ip addr | grep inet
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}


##############################################################################
#                         System Variables                                   #
##############################################################################
# Proton
export STEAM_COMPAT_DATA_PATH=$HOME/.steam/steam/compatibilitytools.d/
