CONFIG_FILE(ssh config, ~/.ssh/config)
Host *.cs.man.ac.uk
	User heathcj9
	ForwardX11 yes
	ForwardX11Trusted yes
	StrictHostKeyChecking no

Host uni
	HostName cdtpc016.cs.man.ac.uk
	User heathcj9
	ForwardX11 yes
	ForwardX11Trusted yes
	StrictHostKeyChecking no

Host mcore48
	HostName mcore48.cs.man.ac.uk
	User heathcj9

Host fallout
	HostName fallout.cs.man.ac.uk
	User heathcj9

Host jhnet jhnet.co.uk
	HostName jhnet.co.uk
	User mossblaser

Host shelf
	HostName shelf
	User shelf
	ForwardX11 yes
	ForwardX11Trusted yes

Host home
	HostName h.jhnet.co.uk
	User root

Host bitbucket.org
 User mossblaser
