# https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2
DOTPATH            := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES_EXCLUDES  := .git .config
DOTDIRECTORIES     := .config/fish .vim
DOTFILES_TARGET    := $(wildcard .??*)
DOTFILES           := $(filter-out $(DOTFILES_EXCLUDES) $(DOTDIRECTORIES), $(DOTFILES_TARGET))
BACKUP_DIR         := $(HOME)/.backup

.DEFAULT_GOAL = help

help:
	@echo "deploy       : add symlinks"
	@echo "update       : update dotfiles"
	@echo "tools-update : update tools"
	@echo "clean        : delete all dotfiles and this repository"

deploy: parents backup
	@echo '==> Start to deploy dotfiles to home directory.'
	@$(foreach val, $(DOTFILES),       ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(DOTDIRECTORIES), ln -sfnv $(abspath $(val)) $(HOME)/$(dir $(val));)

update:
	git pull origin master

tools-update: rbenv-update

clean:
	@echo '==> Remove the dot files and this repo'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

rbenv-update:
	@echo '==> Start to update rbenv'
	@if [ -d ${HOME}/.rbenv ]; then \
		cd ${HOME}/.rbenv && git pull; \
		cd ${HOME}/.rbenv/plugins/ruby-build && git pull; \
	fi

parents:
	@echo '==> Start to make parent directories'
	@$(foreach val, $(dir $(DOTDIRECTORIES)), mkdir -vp $(HOME)/$(val);)

backup:
	@echo '==> Start to back up old dotfiles to home/.back directory'
	mkdir -pv $(BACKUP_DIR)
	@-$(foreach val, $(DOTFILES) $(DOTDIRECTORIES), mv -v $(HOME)/$(val) $(BACKUP_DIR);)
