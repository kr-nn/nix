let
  keys = import ../secretinitializer/secrets.nix;
in
{
  "git.age".publicKeys = with keys; [ age ssh ];
}
