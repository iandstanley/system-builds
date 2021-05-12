HOSTNAME = ian
#IPADDR = DHCP
TORBROWSER = 10.0.16
TORTMP = tmp/torversion

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## " ; print "\n\033[36mBuild system command options:\033[0m \n" }; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}; END { print "" }'

test: dummy
	@echo run test stanza
dummy:
	@echo run dummy stanza

################################################################################
setup: network hardware security users ## SETUP THIS MACHINE

network: 		## configure network
	ip a

firewall: firewall-rules	## setup firewall
	sudo ufw enable
	sudo ufw status verbose numbered
firewall-install: firewall-rules
	sudo apt install -y ufw
firewall-rules:
	cat $(PWD)/files/ufw_rules | xargs -L 1 sudo ufw 

hardware: 	## install hardware support
	xargs -a files/hardware-packages sudo apt-get install -y

security:	gpgconfig sshconfig 	## secure server
	sudo apt install -y apparmor  ufw 


users: 		## configure users
	echo "setting up users"
	-sudo adduser ian 
	sed -i 's/\ /,/g'  $(PWD)/files/users/ian/groups
	-sudo usermod ian --groups $(shell cat $(PWD)/files/users/ian/groups )

software:	software-repos pkginstall 	## setup software
software-repos:
	sudo install -o root -g root -m 0644 files/apt/* /etc/apt/sources.list.d 

################################################################################

save-my-groups:
	groups | tee $(PWD)/files/users/ian/groups

setup-tmp: 	
	mkdir -p $(PWD)/tmp

cleanup-tmp: 
	echo "rm -rf $(PWD)/tmp/*"

git-projects: 	## Git clone current-projects into ~/Projects
	mkdir -p $(HOME)/Projects
	cd $(HOME)/Projects; xargs -n 1 -a $(PWD)/files/current-projects git clone
save-projects: 
	find $(HOME)/Projects -type d  -execdir git remote -v ';' 2>/dev/null | awk '{print $$2}' |uniq| tee $(PWD)/files/current-projects

torbrowser: ## install latest tor browser
	rm -rf $(PWD)/tmp/* $(HOME)/tor-browser 
	curl -s https://www.torproject.org/download/  | grep "downloadLink" | sed 's/^.*torbrowser\/// ' | sed 's/\/.*//' |uniq > tmp/torversion 
	TORBROWSER=$(shell cat tmp/torversion )
	wget https://www.torproject.org/dist/torbrowser/$(TORBROWSER)/tor-browser-linux64-$(TORBROWSER)_en-US.tar.xz -O tmp/tor-browser-linux64-$(TORBROWSER)_en-US.tar.xz 
	unxz tmp/tor-browser-linux64-$(TORBROWSER)_en-US.tar.xz 
	tar xvf tmp/tor-browser-linux64-$(TORBROWSER)_en-US.tar -C $(HOME)
	mv $(HOME)/tor-browser_en-US $(HOME)/tor-browser 
	cd $(HOME)/tor-browser; ./start-tor-browser.desktop  --register-app

pivy-tool: 		## install pivy-tool, pivy-agent, pivy-box and pivy-zfs 
	sudo apt install -y libpcsclite-dev libpcsclite1 pcsc-tools libbsd-dev libbsd0 
	rm -rf $(HOME)/Projects/pivy
	cd $(HOME)/Projects/; git clone git@github.com:joyent/pivy.git
	make HAVE_ZFS=yes USE_ZFS=yes -C $(HOME)/Projects/pivy
	-sudo addgroup --system wheel
	sudo make   HAVE_ZFS=yes USE_ZFS=yes prefix=/usr/local  -C $(HOME)/Projects/pivy  install_pivyzfs
	rm -rf $(HOME)/Projects/pivy
pivy-tool-remove:
	sudo rm -rf /usr/local/bin/pivy*

#
# Setup shell configs
#
vim:
	ln -s $(PWD)/.vimrc ~/.vimrc
	ln -s $(PWD)/.vimwiki ~/.vimwiki
	
bash: 
	echo "Setting up bash"

misc-configs:
	mkdir -p ~/.config
	ln -s $(PWD)/.config/Bitwarden ~/.config/Bitwarden
	ln -s $(PWD)/.config/calibre ~/.config/calibre
	ln -s $(PWD)/.config/'Raspberry Pi' ~/.config/'Raspberry Pi'
	ln -s $(PWD)/.config/Yubico ~/.config/Yubico
	ln -s $(PWD)/.config/zathura ~/.config/zathura
	ln -s $(PWD)/.config/kbibtexrc ~/.config/kbibtexrc
	ln -s $(PWD)/.config/kleopatrarc ~/.config/kleopatrarc
	

#	Setup .config, .ssh, .gpg
dotconfig:
	echo setup .config

sshconfig:
	echo setup .ssh
	ln -s $(PWD)/.ssh ~/.ssh
	
gnupgconfig:
	echo setup .gpg 
	git config --global user.name "Ian Stanley"
	git config --global user.email "iandstanley@gmail.com"
	ln -s $(PWD)/.gnupg ~/.gnupg
	
##################################################################
# Backup all installed files and packages to a file where I can restore 
backup: 		## Backup list of installed Debian linux packages
	@echo "Backup Debian installed packages"
	mkdir -p $(PWD)/files
	apt-mark showmanual > $(PWD)/files/pkglist-current.txt
	@echo "Create list of packages that differ from pkglist"
	diff -u  $(PWD)/files/pkglist $(PWD)/files/pkglist-current.txt > $(PWD)/files/pkglist.diff || true
#	using '|| true' to stop make from crashing from non-zero diff rc

pipbackup: 		## Backup python packages
	@echo "Backup Python PIP packages"
	mkdir -p $(PWD)/files
	pip freeze > $(PWD)/files/pip-current.txt
	diff -u $(PWD)/files/pip-packages $(PWD)/files/pip-current.txt || true
piprecover: 	## Reinstall Python PIP packages
	pip install --user -r ${PWD}/files/pip-packages
piprecovercurrent: 	## Reinstall currently installed Python PIP packages
	pip install --user -r ${PWD}/files/pip-current.txt
#
# Install ALL chosen packages
#
pkginstall: 	## Install chosen packages 
	@echo "Installing software ..."
	xargs -a files/pkglist  sudo apt-get install -y

allbackup: backup pipbackup		## Make list of installed files and PIP packages
