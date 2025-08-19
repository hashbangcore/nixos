if [[ "$(id -u)" -eq 0 ]]; then
	exec vis "$@"
else
	colorscheme=$(dconf read /org/gnome/desktop/interface/color-scheme | tr -d "'")

	SOCK_PATH="$XDG_RUNTIME_DIR/neovim-editor"
	HASH="$(pwgen -A 30 1)"

	if [ ! -d "$SOCK_PATH" ]; then
		mkdir -p "$SOCK_PATH"
	fi

	export NVIM_LISTEN_ADDRESS="$SOCK_PATH/$HASH.sock"

	if [[ $colorscheme == *"dark"* ]]; then
		exec nvim -c "set background=dark" "$@"
	else
		exec nvim -c "set background=light" "$@"
	fi
fi
