{ ... }:
{
  services.xremap = {
    withX11 = true;
    watch = true;
    yamlConfig = ''
      keymap:
        - name: vim motions
          remap:
            alt-j: down
            alt-k: up
            alt-h: left
            alt-l: right
    '';
  };
}
