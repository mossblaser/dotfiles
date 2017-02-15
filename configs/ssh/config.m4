CONFIG_FILE(ssh config, ~/.ssh/config)
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
	HostName h.jhnet.co.uk
	User root

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
