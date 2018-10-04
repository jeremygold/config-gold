#!/bin/bash

files=".vimrc .xsession .tmux.conf .gitconfig .zshrc .vim .Xmodmap"

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
else
    echo "~/.config/fish/config.fish alredy exists - not overwriting"
fi

