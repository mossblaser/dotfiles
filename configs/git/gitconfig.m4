CONFIG_FILE(gitconfig, ~/.gitconfig)
[user]
	name = Jonathan Heathcote
ON_COMPUTER(BBC_COMPUTER)
	email = jonathan.heathcote@bbc.co.uk
ELSE_COMPUTER()
	email = mail@jhnet.co.uk
END_COMPUTE()
[push]
	default = matching
