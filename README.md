# mochaccino
Caffeine alternative for BunsenLabs

`toggle.sh` toggles between `xset +dpms` and `xset -dpms` by checking for a file existance.
Uses `notify-send` with icons to indicate status.
Uses a modded tint2rc file in order to indicate status through the background color (red when active).

Icon made by Freepik from www.flaticon.com

A variável $tint_config no script toggle.sh armazena o nome do arquivo de configuração que será usado pelo tint2.
