set fish_greeting ""

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
set -x PGDATA=/usr/local/var/postgres
alias mongod='mongod --dbpath /usr/local/var/mongodb'
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

alias vi="nvim"

eval (python -m virtualfish)

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status
    if set -q VIRTUAL_ENV
        echo -n -s (set_color white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    # PWD
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (__fish_git_prompt)

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '$ '

    set_color normal
end

[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

