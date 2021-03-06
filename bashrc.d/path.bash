# PATH like a bawss

PATH=~/bin

if [ -d ~/Dropbox/bin ]; then
  PATH=$PATH:~/Dropbox/bin
fi

if [ -d ~/perl5/bin ]; then
  PATH=$PATH:~/perl5/bin
fi

if [ -d /ipg/local/bin ]; then
  PATH=$PATH:/ipg/local/bin
fi

if [ -d /ipg/bin ]; then
  PATH=$PATH:/ipg/bin
fi

if [ -d /usr/local/bin ]; then
  PATH=$PATH:/usr/local/bin
fi

if [ -d /usr/local/sbin ]; then
  PATH=$PATH:/usr/local/sbin
fi

if [ -d /opt/local/bin ]; then
  PATH=$PATH:/opt/local/bin
  PATH=$PATH:/opt/local/sbin
  PATH=$PATH:/opt/local/libexec/gnubin
fi

if [ -d /usr/local/opt/php56/bin ]; then
  PATH=$PATH:/usr/local/opt/php56/bin
fi

if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
fi

if [ -d /usr/local/opt/grep/libexec/gnubin ]; then
  PATH=$PATH:/usr/local/opt/grep/libexec/gnubin
fi

if [ -d /usr/local/mysql/bin ]; then
  PATH=$PATH:/usr/local/mysql/bin
fi

if [ -d ~/pear/bin ]; then
  PATH=$PATH:~/pear/bin
fi

if [ -d /ipg/phabricator/arcanist/bin ]; then
  PATH=$PATH:/ipg/phabricator/arcanist/bin
elif [ -d ~/src/phacility/arcanist/bin ]; then
  PATH=$PATH:~/src/phacility/arcanist/bin
fi

PATH=$PATH:/usr/bin
PATH=$PATH:/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/sbin

if [ -d /opt/X11/bin ]; then
  PATH=$PATH:/opt/X11/bin
fi

if [ -n "$ORACLE_HOME" ]; then
  PATH=$PATH:$ORACLE_HOME/bin
fi

if [ -d ~/.cask ]; then
  PATH=~/.cask/bin:$PATH
fi

export PATH
