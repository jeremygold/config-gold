#!/bin/bash

files=".vimrc .xsession .tmux.conf .gitconfig .zshrc .vim .Xmodmap .condarc .p10k.zsh .oh-my-zsh/themes/jeremy.zsh-theme .oh-my-zsh/custom/jeremy_aliases.zsh .claude/settings.json .config/ccstatusline/settings.json .claude/*"

for file in $files
do
	if [ ! -e ~/$file ]
	then
		echo "~/$file does not exist - creating"
		ln -s ~/config-gold/$file ~/$file
    else
        echo "~/$file alredy exists - not overwriting"
	fi
done

if [ ! -e ~/.config/fish/config.fish ]
then
    echo "Creating fish config file"
    mkdir -p ~/.config/fish
    ln -s ~/config-gold/config.fish ~/.config/fish/config.fish
    ln -s ~/config-gold/fish/conf.d ~/.config/fish/conf.d
else
    echo "~/.config/fish/config.fish alredy exists - not overwriting"
fi

