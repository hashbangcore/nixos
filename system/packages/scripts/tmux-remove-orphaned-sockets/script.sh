set -euo pipefail

# Remove orphaned Tmux sockets
socket_dir="/run/user/$(id -u)/tmux-$(id -u)"

# Check if directory exists
if [[ ! -d "$socket_dir" ]]; then
  echo "No Tmux socket directory found at $socket_dir" >&2
  exit 0
fi

# Process each socket
for socket in "$socket_dir"/*; do
  socket_name="$(basename "$socket")"

  # Skip if not a socket file
  [[ ! -S "$socket" ]] && continue

  # Check if the socket is orphaned
  if ! tmux -L "$socket_name" ls &>/dev/null; then
    echo "Removing orphaned socket: $socket" >&2
    rm -f "$socket"
  fi
done
