let
  keys = import ../secretinitializer/secrets.nix;
in
{
  "sshconfig.age".publicKeys = with keys; [ age ssh ];
}
