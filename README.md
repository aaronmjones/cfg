# cfg
dot files

Storing my dot files (.bashrc, .emacs, etc.) in a git repo according to technique stolen from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.

## Checkout the dot files
```
cd $HOME
mv .bashrc .bashrc.old
mv .emacs .emacs.old
git clone --bare https://github.com/aaronmjones/cfg.git .cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
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
