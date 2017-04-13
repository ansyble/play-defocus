#!make

.DEFAULT_GOAL=ansibles
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
	@ansible-vault encrypt $(file)\
		--vault-password-file=.vaultpass

decrypt:
	@ansible-vault decrypt $(file)\
		--vault-password-file=.vaultpass

requirements:
	@ansible-galaxy install -r requirements.yml

play: check.files
	@ansible-playbook -i $(host) $(playbook).yml $(options) \
		--vault-password-file=.vaultpass

.PHONY: check.files encrypt decrypt requirements play
