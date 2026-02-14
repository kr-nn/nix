### Secrets
My home-manager takes advantage of agenix to deploy secrets. This requires bootstrapping home-manager with a secret but we don't want to __KEEP__ the secret on the same system. so it will be temporary, because my key is a master key. I might change this to be more secure later but for now, we temprarily grab the secret from bitwarden and deploy things this way.
Inside my zshrc is a script for handling access to my bitwarden vault and deploying secrets.
right now it checks your access status on starting a new terminal, gets a session token, and checks if the master age key is available.

All secrets are deployed to /run/user/$UID/ so they are destroyed when the user is not logged in. They are always pulled from the vault when the user opens a terminal, and they are not there.

# TODO
- [ ] Move gitauth to it's own package
- [ ] migrate nix modules to dendritic modules
  - [ ] neovim
  - [ ] plasma settings
  - [ ] zshell settings
  - [ ] bash settings
  - [ ] zerotier
  - [ ] git secrets
  - [ ] ssh secrets
  - [ ] 
- [ ] Change gitauth to support ssh
- [ ] plasma manager for gui things (this should be a flake output rather than a specialisation)
- [ ] Zshell change
