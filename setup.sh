#!/bin/bash

cp -r ./nvim ${HOME}/.config/
cp -r ./awesome ${HOME}/.config/

cp ./colors.json ${HOME}/.config/
cp ./bashrc ${HOME}/.bashrc
cp ./xsession ${HOME}/.xsession

wal -f ${HOME}/.config/colors.json
