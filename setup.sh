#!/bin/bash

cp -r ./nvim ${HOME}/.config/
cp -r ./awesome ${HOME}/.config/

cp ./colors.json ${HOME}/.config/
cp ./bashrc ${HOME}/.bashrc

wal -f ${HOME}/.config/colors.json
