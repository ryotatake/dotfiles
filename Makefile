# https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2
DOTPATH            := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOTFILES_EXCLUDES  := .git .config .gitignore .gitmodules .gitconfig.local
DOTDIRECTORIES     := .config/atcoder-cli-nodejs/cpp .config/mise .vim
DOTFILES_TARGET    := $(wildcard .??*)
DOTFILES           := $(filter-out $(DOTFILES_EXCLUDES) $(DOTDIRECTORIES), $(DOTFILES_TARGET))
BACKUP_DIR         := $(HOME)/.backup
SOURCE_DIR         := $(HOME)/src
DETECTOS           := $(shell $(DOTPATH)/bin/get_os_info.sh)

GO_TOOLS    := github.com/x-motemen/ghq github.com/mattn/memo
CARGO_TOOLS := bat
APT         := silversearcher-ag postgresql-common postgresql-10 libpq-dev
YUM         := the_silver_searcher

.DEFAULT_GOAL = help

help:
	@echo "symlinks     : add symlinks"
	@echo "update       : update dotfiles"
	@echo "tools-setup  : setup tools"
	@echo "tools        : install tools"
	@echo "tools-update : update tools"
	@echo "clean        : delete all dotfiles and this repository"

symlinks: parents backup
	@echo '==> Start to add symlinks to home directory.'
	@$(foreach val, $(DOTFILES),       ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(DOTDIRECTORIES), ln -sfnv $(abspath $(val)) $(HOME)/$(dir $(val));)

update:
	git pull origin master

tools-setup: cargo

tools: package go-tools cargo-tools

tools-update: package-update go-tools-update cargo-tools-update

clean:
	@echo '==> Remove the dot files and this repo'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

# -------------------------------------------------------------------
#  Private
# -------------------------------------------------------------------

package:
	@echo '==> Start to install packages'
ifeq ($(DETECTOS), ubuntu)
	sudo apt install $(APT)
endif
ifeq ($(DETECTOS), centos)
	sudo yum install --enablerepo=epel $(YUM)
endif

package-update:
	@echo '==> Start to update packages'
ifeq ($(DETECTOS), ubuntu)
	sudo apt update
	sudo apt upgrade
endif

go-tools:
	@echo '==> Start to install or update go tools'
	$(foreach go, $(GO_TOOLS), go get -u $(go);)

go-tools-update: go-tools

cargo:
	@echo '==> Start to install Rust and Cargo'
	@if [ ! -d ${HOME}/.cargo ]; then \
		curl https://sh.rustup.rs -sSf | sh; \
	else \
		echo 'already installed!'; \
	fi

cargo-tools:
	@echo '==> Start to install Cargo tools'
	$(foreach tool, $(CARGO_TOOLS), cargo install $(tool);)

cargo-tools-update: cargo-tools

parents:
	@echo '==> Start to make parent directories'
	@$(foreach val, $(dir $(DOTDIRECTORIES)), mkdir -vp $(HOME)/$(val);)

backup:
	@echo '==> Start to back up old dotfiles to home/.back directory'
	mkdir -pv $(BACKUP_DIR)
	@-$(foreach val, $(DOTFILES) $(DOTDIRECTORIES), mv -v $(HOME)/$(val) $(BACKUP_DIR);)
