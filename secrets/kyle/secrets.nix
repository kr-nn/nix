let
  age = "age1f8zpkf0ycer8t96zd30veqd8r9626lt3uustu56pxlwrjtqmkqpq4w3txx";
  ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILS702QCxlr2wTXjZDaJ0IiO5NKkYMAgN4Ei+YbS19sF";
in
{
  "git.age".publicKeys = [ age ssh ];
}
