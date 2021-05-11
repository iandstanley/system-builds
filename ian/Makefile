HOSTNAME = ian
#IPADDR = DHCP


help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## " ; print "\n\033[36mBuild system command options:\033[0m \n" }; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}; END { print "" }'

cleanup:
	echo "rm -rf $(TMP)/*"




users: 		## configure users
	echo "setting up users"

##	network:		configure network
network: 		## configure network

hardware: 	## install hardware support
	xargs -a files/hardware-packages sudo apt-get install -y
	

#
# Setup shell
#
bash: 
	echo "Setting up bash"


#	Setup .config, .ssh, .gpg
dotconfig:
	mkdir -p $(PWD)/.config
	
sshconfig:
	mkdir -p $(PWD)/.ssh
	
gpgconfig:
	mkdir -p $(PWD)/.gpg
	git config --global user.name "Ian Stanley"
	git config --global user.email "iandstanley@gmail.com"
	
##################################################################
# Backup all installed files and packages to a file where I can restore 
backup: 		## Backup list of installed Debian linux packages
	@echo "Backup Debian installed packages"
	mkdir -p $(PWD)/files
	apt-mark showmanual > $(PWD)/files/pkglist-current.txt
	@echo "Create list of packages that differ from pkglist"
	diff -u  $(PWD)/files/pkglist $(PWD)/files/pkglist-current.txt > $(PWD)/files/pkglist.diff

pipbackup: 		## Backup python packages
	@echo "Backup Python PIP packages"
	mkdir -p $(PWD)/files
	pip freeze > $(PWD)/files/pip-current.txt
	diff -u $(PWD)/files/pip-packages $(PWD)/files/pip-current.txt
#
# Install ALL chosen packages
#
pkginstall: 	## Install chosen packages 
	@echo "Installing software ..."
	xargs -a files/pkglist  sudo apt-get install -y

allbackup: backup pipbackup		## Make list of installed files and PIP packages
