class people::potix2 {

  class  { 'intellij':
    edition => 'ultimate',
    version => '13.0.2'
  }

  include java
  include iterm2::stable
  include keyremap4macbook::login_item
  include alfred
  include virtualbox
  include vagrant
  include redis
  include emacs
  include mysql
  include zsh
  include clojure
  include vim
  include ctags
  include tmux
  include wget

  include evernote
  include dropbox
  include skype
  include chrome
  include things
  include intellij
  include cyberduck
  include sequel_pro

  $home     = "/Users/${::boxen_user}"
  $ws       = "${home}/ws"
  $dotfiles = "${ws}/dotfiles"

  file { $ws:
    ensure  => directory
  }

  package {
    [
      'readline',
      'reattach-to-user-namespace',
      'tree',
      'tig'
    ]:
  }

  repository { $dotfiles:
    source   => 'potix2/dotfiles',
    require  => File[$ws]
  }

  exec { "sh ${dotfiles}/setup.sh":
    cwd => $dotfiles,
    require => Repository[$dotfiles]
  }

  # application settings
  keyremap4macbook::set { 'parameter.repeat.wait':
    value => '30'
  }
}
