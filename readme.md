# Structure

My home manager is as device agnostic as I can make it.
For obvious reasons we can't do impure things but I wanted a dynamic hm I could use in many situations so I can have one mono-repo for all my hm needs.

I created a home-manager profile switcher allowing you to use specialisations to change what your profile does.
using a profileSwitcher activation and a script I wrote called hmpr you can quickly flip between multiple home-manager specialisations.

### Users
You can have any username you wish, creating the user is as easy as editing your flake to have a username coorespond to a user.nix file which only needs the home-manager basics with no configurations.
inside that file you should import `_home` where you put all your configurations and specialisations.

### Specialisations
using specialisations you can take advantage of the profile switcher to have 1 user many configurations. You can even do some dependancy handling like whether you have a gui or not.

### Design paradigm
Nix is a very flexible language and you can do weird things.
for ex. this is valid nix code:
```nix
{ ... }:
let
  main = {
    home.enable = true;
  };
in
main
```

Taking advantage of this and lib.mkMerge you can make profiles like lego:
```nix
{ ... }:
let
  main = {
    home.enable = true;
    specialisation.developmode.configuration = lib.mkMerge [ git neovim ];
    git = { programs.git.enable = true; };
    neovim = { home.packages = [ neovim ]; };
  };
in
main
```

Using this code we can run `hmpr developmode` and the profile switcher will activate the developmode profile

# TODO
- [ ] Nix function that copies files from nix store instead of links to them
- [ ] Faster Bitwarden interface
- [ ] Switch from specialisations to different builds, specialisations should activate specific things (specialisations are too slow to build)
- [ ] Change gitauth to support ssh
- [ ] plasma manager for gui things (this should be a flake output rather than a specialisation)
- [ ] Zshell change
- [ ] Remove home-builder
- [ ] Move away from monolithic configuration

### Secrets
My home-manager takes advantage of agenix to deploy secrets. This requires bootstrapping home-manager with a secret but we don't want to __KEEP__ the secret on the same system. so it will be temporary, because my key is a master key. I might change this to be more secure later but for now, we temprarily grab the secret from bitwarden and deploy things this way.
Inside my zshrc is a script for handling access to my bitwarden vault and deploying secrets.
right now it checks your access status on starting a new terminal, gets a session token, and checks if the master age key is available.

All secrets are deployed to /run/user/$UID/ so they are destroyed when the user is not logged in. They are always pulled from the vault when the user opens a terminal, and they are not there.
