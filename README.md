# cfg
dot files

Storing my dot files (.bashrc, .emacs, etc.) in a git repo according to technique stolen from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.

## Checkout the dot files
```
git clone --bare https://bitbucket.org/durdn/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
config checkout
config config status.showUntrackedFiles no
```

## Update a dot file
```
config add .bashrc
config commit -m "Changed .bashrc because"
config push origin master
```
