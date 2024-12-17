# TODO
- [ ] move imports to flake nixosConfiguration declarations
- [ ] Add to nix
    - [X] touchegg
    - [ ] dolphin
    - [ ] vivaldi
    - [ ] konsole/yakuake
    - [X] khotkeys
    - [ ] plasmashell
- [ ] add displaylink driver as a declared resource
- [X] add configurationRevision management to hosts
- [ ] make themes more pluggable with function gentheme
- [ ] use specialisations for recovery mode
- [ ] use specialisations for dual booting
- [ ] update to 24.11

# home-manager deploy
### Brief
My home-manager takes advantage of agenix to deploy secrets. This requires bootstrapping home-manager with a secret but we don't want to __KEEP__ the secret on the same system. so it will be temporary, because my key is a master key. I might change this to be more secure later but for now, we temprarily grab the secret from bitwarden and deploy things this way.

### How to deploy
- cd to flake repo
- nix develop
- login to bwcli
- this will automatically build home-manager and activate it

### Updates
You shouldn't need to nix develop to update home-manager unless you are adding secrets
To do these updates you will need to download the private key temporarily to do work.
The id for the age master key is af9d248c-93e9-4de4-8e15-61b5801d326c

`bw get password af9d248c-93e9-4de4-8e15-61b5801d326c`

place this key in one of these places:
```
/run/user/1000/age.key
~/.ssh/age.key
```
you can then use, age, agenix, home-manager switch as needed.
Do not forget to delete this key
