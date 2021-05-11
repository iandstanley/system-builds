HOSTNAME = ian
#IPADDR = DHCP
DOTCONFIG = ${PWD}/${HOSTNAME}/.config
DOTSSH = ${PWD}/${HOSTNAME}/.ssh
DOTGPG = ${PWD}/${HOSTNAME}/.gpg


help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## " ; print "\n\033[36mBuild system command options:\033[0m \n" }; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}; END { print "" }'





users: 		## configure users
	echo "setting up users"

##	network:		configure network
network: 		## configure network


#
# Setup shell
#
bash: 
	echo "Setting up bash"


#
#	Setup .config 
#
dotconfig:
	echo "setup .config"
	mkdir -p ${DOTCONFIG}
	
sshconfig:
	echo "setup .ssh"
	mkdir -p ${SSHCONFIG}
	
gpgconfig:
	echo "setup .gpg"
	mkdir -p ${GPGCONFIG}
	
#
# Backup all installed files and packages to a file where I can restore 
#
backup: 		## Backup arch linux packages
	mkdir -p ${PWD}/files
	apt-mark showmanual > ${PWD}/files/pkglist

pipbackup: 		## Backup python packages
	mkdir -p ${PWD}/files
	pip freeze > ${PWD}/files/pip-requirements.txt


allbackup: backup pipbackup
