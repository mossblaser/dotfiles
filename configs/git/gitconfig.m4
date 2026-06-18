CONFIG_FILE(gitconfig, ~/.gitconfig)
[user]
	name = Jonathan Heathcote
ON_COMPUTER(ARM_COMPUTER)
	email = jonathan.heathcote@arm.com
ELSE_COMPUTER()
	email = mail@jhnet.co.uk
END_COMPUTER()

[init]
	defaultBranch = main

[push]
	default = matching

[credential]
	helper = store

[gitreview]
ON_COMPUTER(ARM_COMPUTER)
	username = jonhea03
ELSE_COMPUTER()
	username = mossblaser
END_COMPUTER()

[diff]
	tool = gvimdiff
[difftool]
	prompt = false

