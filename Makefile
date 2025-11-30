
DOTFILES_DIR := $(shell pwd)
PKG_LIST := pkglist.txt
EXTRAS_LIST := extras.txt
BIN_DIR := $(HOME)/.local/bin

.PHONY: all packages user system git extras tools

all: packages tools user system


packages:
	@echo "Installing packages from $(PKG_LIST)"
	sudo pacman -S --needed - < $(PKG_LIST)

user:
	@echo "Linking User defined config (stow)"
	stow --verbose --target=$$HOME --restow hypr
	stow --verbose --target=$$HOME --restow wallpapers
	
	rm -rf $(HOME)/.bashrc $(HOME)/.bash_profile
	stow --verbose --target=$$HOME --restow shell

system:
	@echo "Applying system config (with sudo)"
	sudo cp $(DOTFILES_DIR)/etc/ly/config.ini /etc/ly/config.ini

save:
	@echo "Updating package list at $(PKG_LIST)"
	awk '{print $$1}' $(EXTRAS_LIST) > /tmp/exclude_patterns
	pacman -Qqe | grep -vxF -f /tmp/exclude_patterns > $(PKG_LIST)
	@rm -f /tmp/exclude_patterns

git: save
	@echo "Commiting to git"
	git add .
	git commit -m "$(m)"
	git push

extras:
	@./extras.sh

tools:
	@echo "Compiling tools"
	go build -o ./bin/app-scanner ./tools/app-scanner/main.go
	@echo "Installing compiled tools"
	mkdir -p $(BIN_DIR)
	install -m 755 ./bin/* $(BIN_DIR)/

