# https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2
DOTPATH            := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES_EXCLUDES  := .git .config
NEED_PARENT_TARGET := .config/fish
DOTFILES_TARGET    := $(wildcard .??*) $(NEED_PARENT_TARGET)
DOTFILES           := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
BACKUP_DIR         := $(HOME)/.back

parents:
	@echo '==> Start to make parent directories'
	@$(foreach val, $(dir $(NEED_PARENT_TARGET)), mkdir -p $(HOME)/$(val);)

backup:
	@echo '==> Start to back up old dotfiles to home/.back directory'
	mkdir -p $(BACKUP_DIR)
	@-$(foreach val, $(DOTFILES), mv -v $(HOME)/$(val) $(BACKUP_DIR);)

deploy: parents backup
	@echo '==> Start to deploy dotfiles to home directory.'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update:
	git pull origin master

clean:
	@echo '==> Remove the dot files and this repo'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)
