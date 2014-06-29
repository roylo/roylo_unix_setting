# aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# .titlebar
if [ -f ~/.titlebar ]; then
    . ~/.titlebar
fi

# Yahoo Setting File
if [ -f ~/.yahoo_setting ]; then
    . ~/.yahoo_setting
fi


txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
bakgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset


function current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

function git_prompt_info() {
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    #echo -e " $(parse_git_dirty)(git:$(current_branch))\e[0m"
    echo -e " (git:$(current_branch))"
}

function parse_git_dirty() {
    local SUBMODULE_SYNTAX=''
    local GIT_STATUS=''
    local CLEAN_MESSAGE='nothing to commit (working directory clean)'

    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    else
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    fi
    if [[ -n $GIT_STATUS ]]; then
      echo "\e[0;31m+"
    else
      echo "\e[1;32m"
    fi
}

function get_pwd() {
  echo "${PWD/$HOME/~}"
}

function put_spacing() {
    local git=$(git_prompt_info)
    if [ ${#git} != 0 ]; then
        ((git=${#git} - 10))
    else
        git=0
    fi

    local termwidth
    local pwd=$(get_pwd)
    (( termwidth = (${COLUMNS} - 30 - ${#YROOT} - ${#pwd} - ${git})/4 ))

    local spacing=""

    for (( i=1; i<=$termwidth; i++ ))
    do
        spacing="${spacing}\t"
    done
    echo -e $spacing
}


#[liao@tp bin]$ echo -e "\0342\0224\0214"
r='\342\224\217'
dash='\342\224\200'
l='\342\224\227'
point='\342\227\216'
left_brace='\342\246\227'
right_brace='\342\246\230'
arrow='\342\236\244'

hostname=`hostname`
export TZ=Asia/Taipei
date=`date +%m-%d`
myhost=${hostname%.yahoo.com}
prompt_1st_line="${bldblu}${r}${dash}${dash}${left_brace}${txtgrn}\u${bldwht}@${txtcyn}${myhost}${txtylw}${YROOT}${bldblu}${right_brace}${dash}${dash}${left_brace}${txtpur}${date} \@${bldblu}${right_brace}${dash}${dash}${left_brace}${bldylw}\w\$(git_prompt_info)${bldblu}${right_brace}${txtrst}"
prompt="\n${prompt_1st_line}
${bldblu}${l}${dash}${dash}${dash}${arrow}${txtrst}  "
export PS1=$prompt

export LC_ALL=en_US.UTF-8
export LANG=en_US.ISO8859-1
export LC_CTYPE=zh_TW.UTF-8
export locale=zh_TW.UTF-8

# set terminal in 256-color
set xterm-256color

# set command in vim mode
set -o vi

# If not running interactively, don't do anything
if [ -z "$PS1" ]; then
    return
fi

man_color_1()
{
    # colorful man page
    export PAGER="`which less` -s"
    export BROWSER="$PAGER"
    export LESS_TERMCAP_mb=$'\E[38;5;167m'
    export LESS_TERMCAP_md=$'\E[38;5;39m'
    export LESS_TERMCAP_me=$'\E[38;5;231m'
    export LESS_TERMCAP_se=$'\E[38;5;231m'
    export LESS_TERMCAP_so=$'\E[38;5;167m'
    export LESS_TERMCAP_ue=$'\E[38;5;231m'
    export LESS_TERMCAP_us=$'\E[38;5;133m'
}

man_color_2()
{
    # colorful man page
    export PAGER="`which less` -s"
    export BROWSER="$PAGER"
    export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
    export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
    export LESS_TERMCAP_me=$'\E[0m'           # end mode
    export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
    export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
    export LESS_TERMCAP_ue=$'\E[0m'           # end underline
    export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
}

# set default man color
man_color_1

#Make sure all terminals save history
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#History format
export HISTTIMEFORMAT='%F %T '

#Increase history size
export HISTSIZE=10000
export HISTFILESIZE=10000

#Remove duplicate history command
export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups

export HISTIGNORE="pwd:ls:ls -ltr:ls -alrt:hist*:clear:q:exit:vim .bashrc"

export HISTFILE=~/.myhistory

# history using up and down key
bind '"\x1b\x5b\x41":history-search-backward'
bind '"\x1b\x5b\x42":history-search-forward'

# automatically correct mistyped directory names on cd
shopt -s cdspell

#将一个多行命令的所有行保存在同一个历史项中
shopt -s cmdhist
shopt -s checkwinsize

if [[ `uname -a | grep -c Linux` -ne 0 ]]
then
    IS_LINUX=1;
else
    IS_LINUX=0;
fi

if (( $IS_LINUX == 0 ))
then
    res=`which gnuls 2> /dev/null`
    if [ -z $res ]
    then # no gnuls
        alias ls='ls -GF'
        if [ ${BASH_VERSINFO[1]} = "04" ]
        then
            export LSCOLORS=gxgx2x3x2x464301060203
        else
            DIR=hx
            SYM_LINK=gx
            SOCKET=Fx
            PIPE=dx
            EXE=Ex
            BLOCK_SP=Dx
            CHAR_SP=Dx
            EXE_SUID=hb
            EXE_GUID=ad
            DIR_STICKY=Ex
            DIR_WO_STICKY=Ex
            export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"
        fi
    else # got gnuls
        alias ls='gnuls --color=auto'
    fi
else
    LS_COLORS='no=00:fi=38;5;117:di=38;5;218:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;110:*.cmd=01;84:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=38;5;134:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:';
    export LS_COLORS
    alias ls='ls --color=auto'
fi

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

