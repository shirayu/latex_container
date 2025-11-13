#!/usr/bin/env bash

set -x

mkdir -p ~/.ssh
chmod 700 ~/.ssh
install -m 700 /config/ssh/github ~/.ssh/github
install -m 700 /config/ssh/github.pub ~/.ssh/github.pub
install -m 700 /config/ssh/known_hosts ~/.ssh/known_hosts
install -m 700 /config/ssh/config ~/.ssh/config

mkdir -p ~/.cache

mkdir -p ~/.config/nvim
git clone git@github.com:shirayu/config_nvim.git ~/.config/nvim
~/.config/nvim/setup.sh load

git clone git@github.com:shirayu/dotfiles.git ~/.dotfiles
~/.dotfiles/setup.py

echo 'alias codex="codex --dangerously-bypass-approvals-and-sandbox"' >>~/.zshenv
echo 'alias copilot="copilot --allow-all-tools"' >>~/.zshenv
echo 'alias claude="claude --dangerously-skip-permissions"' >>~/.zshenv
