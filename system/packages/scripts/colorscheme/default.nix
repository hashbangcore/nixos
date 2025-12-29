{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "colorscheme";
      text = ''
        shopt -s nullglob

        THEME="$(gsettings get org.gnome.desktop.interface color-scheme | tr -d "'")"

        if [[ "$THEME" == "prefer-dark" ]]; then 
          gsettings set org.gnome.desktop.interface color-scheme 'default'
          gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
          gsettings set org.gnome.desktop.interface cursor-theme 'Sunity-cursors'
          cp ~/.config/alacritty/themes/light.toml ~/.config/alacritty/themes/default.toml
          for sock in /run/user/1000/neovim-editor/*.sock; do 
            nvim --server "$sock" --remote-send ':set background=light<CR>' 
            nvim --server "$sock" --remote-send ':colorscheme PaperColor<CR>'
          done
        else
          gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
          gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
          gsettings set org.gnome.desktop.interface cursor-theme 'Sunity-cursors-white'
          cp ~/.config/alacritty/themes/dark.toml ~/.config/alacritty/themes/default.toml
          for sock in /run/user/1000/neovim-editor/*.sock; do 
            nvim --server "$sock" --remote-send ':set background=dark<CR>'
            nvim --server "$sock" --remote-send ':colorscheme PaperColor<CR>'
          done
        fi
      '';
      meta.description = "Switch appearance settings between light and dark modes";
    })
  ];
}
