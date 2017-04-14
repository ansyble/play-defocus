# Play defocus

[![Build Status](https://travis-ci.org/ansyble/play-defocus.svg?branch=master)](https://travis-ci.org/ansyble/play-defocus)

* Download Ansible roles:

```sh
$ make requirements
```

* Vault:

> You should create a `.vaultpass` file with the *vault-password* in a single line.

* Server orchestration:

```sh
$ make play inventory=[dev] play=[webservers|drone] tags=tag1,tag2
```
