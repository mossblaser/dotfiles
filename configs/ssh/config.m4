CONFIG_FILE(ssh config, ~/.ssh/config)

# Make ssh-agent to automatically add all ssh keys on startup
AddKeysToAgent yes

ON_COMPUTER(BBCRD)

# CANS-specific SSH configurations (NB: these files have been copied from the
# ansible-mist repository and tweaked locally for old OpenSSH version support)
Include /home/jonathah/Projects/cans/ansible-mist/deployments/rddeploy/extra_files/rddeploy_ssh_config
Include /home/jonathah/Projects/cans/ansible-mist/deployments/mcr1/extra_files/mcr1_ssh_config
Include /home/jonathah/Projects/cans/ansible-mist/deployments/lon1/extra_files/lon1_ssh_config

Match final host *
	ProxyCommand /bin/nc -xsocks-gw.rd.bbc.co.uk:1085 -w 180 %h %p
	ServerAliveInterval 100
	ServerAliveCountMax 2

END_COMPUTER()

Host e-c07ki* kilburn kilburn.cs.man.ac.uk
	User mbax9jh2
	StrictHostKeyChecking no

Host rs0 rs0.cs.man.ac.uk
	User heathcj9
	StrictHostKeyChecking no

Host glass
	Hostname glass.cs.man.ac.uk
	User heathcj9

Host uni
	HostName kilburn.cs.man.ac.uk
	User mbax9jh2
	ForwardX11 yes
	ForwardX11Trusted yes

Host jhnet jhnet.co.uk
	HostName jhnet.co.uk
	User mossblaser

Host shelf
	HostName shelf
	User shelf
	ForwardX11 yes
	ForwardX11Trusted yes

Host home
	HostName home.jamh.org
	User jonathan

Host bitbucket.org
 User mossblaser

Host pi
	HostName raspberrypi
	User pi

Host stellahd
	HostName stellahd.cs.man.ac.uk
	User heathcj9

Host stella64
	HostName stella64.cs.man.ac.uk
	User heathcj9

Host dammam
	HostName dammam.cs.man.ac.uk
	User heathcj9
	
Host cspc*
	User heathcj9

Host spinnaker spinnaker.cs.man.ac.uk
	HostName spinnaker.cs.man.ac.uk
	User mbax9jh2
