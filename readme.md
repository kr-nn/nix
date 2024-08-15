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
- [ ] secrets management
    - Make bitwarden deploy a home-manager activation
- [X] fingerprint sddm
- [X] make syncthing start when logged in
- [X] make displaylink run conditionally without the lockscreen problem & remember monitor config
- [X] move modules to inside homes/hosts depending on if they're a nixos/home-manager module
- [X] move zcomp
- [X] configure zsh history
- [X] add displaylink driver as a declared resource # This was done in hosts
- [X] Make specialisations more centralised
- [ ] Migrate to nixvim
    - [ ] inventory plugins I use from kickstart
    - [ ] inventory my customizations
    - [ ] cleanup extras I don't use anymore
    - [ ] Stylix nixvim???
- [ ] Add to nix
    - [X] touchegg
    - [ ] dolphin # Look at plasma-manager
    - [ ] vivaldi # investigate Default overwritable dotfiles for chromeium
    - [X] konsole/yakuake
    - [X] khotkeys
    - [ ] plasmashell # Look at plasma-manager
- [ ] make a minified home-manager with only 2 profiles for small systems (don't need to have as many profiles)

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
Do not forget to delete this key (it's removed during deploy/activation)

