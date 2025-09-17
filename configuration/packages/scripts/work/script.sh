set -euo pipefail

WORK_NAME="${1:-$(basename "$PWD")}"

# Remove orphaned Tmux sockets
for s in "/run/user/$(id -u)/tmux-$(id -u)"/*; do
  if ! tmux -L "$(basename "$s")" ls &>/dev/null; then
    rm -f "$s"
  fi
done

# Attach or create session
if tmux -L "$WORK_NAME" has-session -t "$WORK_NAME" 2>/dev/null; then
  exec tmux -L "$WORK_NAME" attach -t "$WORK_NAME"
else
  exec tmux -L "$WORK_NAME" new -s "$WORK_NAME"
fi
