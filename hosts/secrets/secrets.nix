let
  masterkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILS702QCxlr2wTXjZDaJ0IiO5NKkYMAgN4Ei+YbS19sF kyle@sorin";
  sorin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITQ2cunkJfC060Z0RMTv1EfRBvUltziB8Eb4eNXK7hN root@sorin";
in
{
  #"lpavpn.ovpn".publicKeys = [ masterkey sorin ];
}
