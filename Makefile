#!make

.DEFAULT_GOAL=play

playbook ?= webservers

ifeq ($(host),)
	host := domake.io
endif

ifneq ($(tags),)
	options := --tags '$(tags)'
endif

.vaultpass:
	@echo 'Need a ".vaultpass" to decrypt the keys.'
	@exit 1

check.files: .vaultpass

encrypt:
	@ansible-vault encrypt\
		--vault-password-file=.vaultpass\
		$(shell find keys/* -type f)

decrypt:
	@ansible-vault decrypt\
		--vault-password-file=.vaultpass\
		$(shell find keys/* -type f)

requirements:
	@ansible-galaxy install -r requirements.yml

play: check.files
	@ansible-playbook -i $(host) $(playbook).yml $(options)\
		--vault-password-file=.vaultpass

.PHONY: check.files encrypt decrypt requirements play
