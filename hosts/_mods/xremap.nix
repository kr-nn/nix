{ ... }:
{
  services.xremap = {
    withX11 = true;
    watch = true;
    config = {
      keymap = [
        { name = "vim directional maps";
          remap = { "alt-h" = "left"; "alt-j" = "down"; "alt-k" = "up"; "alt-l" = "right"; }; }
      ];
    };
  };
}
