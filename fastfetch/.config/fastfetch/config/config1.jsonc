{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "data";
        source = ''
                                     ▒    ▒
          ░                       ░▒▒▒▒▒▒▒▒▒
          ░░░░░░░          ░░░░░░░░░░░░░░░░            ░░░░
           ░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░
            ░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░
             ░░░░░░░░░░░░░░░░░░▒░░░▒░░░░░░░░░░░░░░░░░░░░░
            ░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░
             ░░░░░░░█████████░░░░░░░░░░░█████████░░░░░░░
              ░░░████▒▒▒▒▒▒█████░░░░░▓████▒▒▒▒▒▒████░░░░
              ░░████▒▒▒▒▒▒▒▒█████░░░█████▒▒▒▒▒▒▒▒████░░
              ░░████▒▒▒▒▒▒▒▒█████░░░█████▒▒▒▒▒▒▒▒████░░
              ░░░░███▒▒▒▒▒▒████░░░░░░░████▒▒▒▒▒▒███░░░░
               ░░░░░░███████░░░░░░░░░░░░░███████░░░░░░░
               ░░░░░░░░░░░░░░░░░███░░░░░░░░░░░░░░░░░░░
                 ░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░░░░
                  ░░░░░░░░░░░░░░█░█░░░░░░░░░░░░░░░░
                     ░░░░░░░░░░█░░░█░░░░░░░░░░░░
                          ░░░░░░░░░░░░░░░░░░
        '';
      };

      display.separator = " ";

      modules = [
        "break"
        "break"
        {
          type = "custom";
          key = "╭── ⋅ ⋅  ⋅ ⋅ ──╮";
        }
        {
          type = "title";
          key = "│{#31}   user       {#keys}│";
          format = "{user-name}";
        }
        {
          type = "os";
          key = "│{#32}   distro     {#keys}│";
          format = "{name}";
        }
        {
          type = "shell";
          key = "│{#33}   shell      {#keys}│";
          format = "{pretty-name}";
        }
        {
          type = "terminal";
          key = "│{#34}   terminal   {#keys}│";
          format = "{exe-name}";
        }
        {
          type = "packages";
          key = "│{#35}   packages   {#keys}│";
        }
        {
          type = "terminalfont";
          key = "│{#36}   font       {#keys}│";
        }
        {
          type = "custom";
          key = "├── ⋅ ⋅  ⋅ ⋅ ──┤";
        }
        {
          type = "cpu";
          key = "│{#31}   CPU        {#keys}│";
          format = "{name}";
        }
        {
          type = "gpu";
          key = "│{#32}   GPU        {#keys}│";
          format = "{name}";
        }
        {
          type = "memory";
          key = "│{#33} 󰍛  memory     {#keys}│";
        }
        {
          type = "disk";
          folders = "/";
          key = "│{#34} 󰉉  disk       {#keys}│";
        }
        {
          type = "custom";
          key = "╰── ⋅ ⋅  ⋅ ⋅ ──╯";
        }
        "break"
        {
          type = "custom";
          key = "    ⋅ ─   ─ ⋅";
        }
        {
          type = "colors";
          paddingLeft = 1;
          symbol = "circle";
        }
      ];
    };
  };
}
