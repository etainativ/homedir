if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
