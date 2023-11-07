PACKAGES		+= htop dua-cli duf eza cmake sxiv dmenu
PACKAGES		+= fzf fd lf tmux rsync zathura zathura-pdf-poppler feh lazygit
PACKAGES		+= scrot picom yt-dlp pass openssh
PACKAGES		+= ffmpeg mpv ripgrep
PACKAGES		+= mpd ncmpcpp

PACMAN = sudo pacman -S
LN = ln -vsf


help:
	@printf "\033[34mJosh's Arch linux Install Script\033[0m\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[31m%-30s\033[0m %s\n", $$1, $$2}'


init:
	$(PACMAN) xdg-user-dirs
	xdg-user-dirs-update

fonts: ## JetBrainsMono Nerd Font
	mkdir -p $(HOME)/.local/share/fonts/jetbrains && \
	cd $(HOME)/.local/share/fonts/jetbrains && \
	wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.tar.xz" && \
	tar xf JetBrainsMono.tar.xz && \
	cd -

zsh: ## zsh shell with completions, autosuggestions, and history
	mkdir -p $(HOME)/.cache/zsh
	touch $(HOME)/.cache/zsh/history
	rm -rf $(HOME)/.config/zsh
	$(LN) $(PWD)/config/zsh $(HOME)/.config
	$(LN) $(PWD)/config/profile/.zprofile $(HOME)/.zprofile
	sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting

rofi: ## Rofi program launcher
	rm -rf $(HOME)/.config/rofi
	$(LN) $(PWD)/config/rofi $(HOME)/.config/rofi
	$(PACMAN) rofi

pipewire: ## pipewire audio server
	sudo pacman -S pipewire pipewire-pulse pipewire-jack wireplumber
	systemctl --user enable --now pipewire pipewire-pulse wireplumber

x: ## xorg server
	$(LN) $(PWD)/xorg/.xinitrc $(HOME)/.xinitrc
	sudo pacman -S xorg-server xorg-apps xorg-xinit ttf-dejavu

bspwm: ## bspwm and sxhkd
	rm -rf $(HOME)/.config/{bspwm,sxhkd}
	$(LN) $(PWD)/config/bspwm $(HOME)/.config
	$(LN) $(PWD)/config/sxhkd $(HOME)/.config
	$(PACMAN) bspwm sxhkd

alacritty: ## Alacritty terminal emulator
	rm -rf $(HOME)/.config/$@
	$(LN) $(PWD)/config/alacritty $(HOME)/.config
	$(PACMAN) alacritty

amducode: ## amd ucode
	$(PACMAN) amd-ucode
	sudo grub-mkconfig -o /boot/grub/grub.cfg

yay: ## yay aur helper
	@echo "Installing yay aur helper..."
	git clone "https://aur.archlinux.org/yay.git"
	cd yay && makepkg -si
	rm -rf $(PWD)/yay
	@echo "yay installed."

librewolf: ## Librewolf browser
	yay librewolf-bin

installpackages: ## Install all other packages
	sudo pacman -S $(PACKAGES)

emacs: ## emacs
	sudo pacman -S emacs
	test -d $(HOME)/.emacs.d || git clone "https://github.com/joshporterdev/.emacs.d" $(HOME)/.emacs.d

qemu: ## Virtual machcine setup with qemu and virt-manager
	sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq bridge-utils
	sudo systemctl enable --now libvirtd.socket
	sudo usermod -aG libvirt $(USER)
