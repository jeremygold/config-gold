#!/bin/bash

files=".vimrc .xsession .tmux.conf .gitconfig .zshrc"

for file in $files
do
	if [ ! -e ~/$file ]
	then
		echo "~/$file does not exist - creating"
		ln -s ~/MyDocs/$file ~/$file
    else
        echo "~/$file alredy exists - not overwriting"
	fi
done

