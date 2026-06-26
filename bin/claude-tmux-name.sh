#!/usr/bin/env bash
# Propagate the Claude Code conversation name to the tmux window name.
#
# Wired from ~/.claude/settings.json hooks:
#   SessionStart      -> start   (stop cwd-basename auto-rename from clobbering)
#   UserPromptSubmit  -> topic   (refresh name from Claude's topic each turn)
#   Stop              -> topic   (copy Claude's conversation topic from pane_title)
#   SessionEnd        -> end     (restore cwd-basename auto-rename)
#
# The 'prompt' mode (name the window from the raw user prompt) is kept available
# but intentionally NOT wired -- naming from the topic reads better than echoing
# back whatever was just typed.
#
# Claude emits its topic as an xterm OSC-2 title, which tmux stores as
# #{pane_title} (NOT window_name -- allow-rename only governs the tmux \ek
# escape). So we read pane_title and copy it into the window name ourselves.
#
# No-ops cleanly when not inside tmux ($TMUX_PANE unset).
set -euo pipefail

mode="${1:-}"
[ -z "${TMUX_PANE:-}" ] && exit 0   # not in tmux; nothing to do

set_name() {  # $1 = desired window name (already trimmed); skip if empty
  [ -n "${1:-}" ] && tmux rename-window -t "$TMUX_PANE" "$1" 2>/dev/null || true
}

case "$mode" in
  start)
    # Keep automatic-rename-format ('#{b:pane_current_path}') from overwriting
    # the name we set. rename-window also does this implicitly, but a resumed
    # session may not hit the prompt hook before the format reasserts.
    tmux set-window-option -t "$TMUX_PANE" automatic-rename off 2>/dev/null || true
    ;;

  prompt)
    # Immediate, meaningful name from the user's prompt. Runs every turn; the
    # Stop hook overwrites it with Claude's refined topic once the turn ends.
    input="$(cat)"
    prompt="$(printf '%s' "$input" | jq -r '.prompt // empty' 2>/dev/null || true)"
    name="$(printf '%s' "$prompt" | tr '\n' ' ' | sed 's/  */ /g; s/^ *//; s/ *$//' | cut -c1-40)"
    set_name "$name"
    ;;

  topic)
    # Claude's conversation topic lives in pane_title (OSC-2). Strip the leading
    # spinner glyph (a non-ASCII braille char) and surrounding whitespace.
    title="$(tmux display-message -p -t "$TMUX_PANE" '#{pane_title}' 2>/dev/null || true)"
    name="$(printf '%s' "$title" | sed 's/^[^[:alnum:]]*//; s/  */ /g; s/^ *//; s/ *$//' | cut -c1-40 | sed 's/ *$//')"
    set_name "$name"
    ;;

  end)
    # Restore the default cwd-basename auto-rename behavior.
    tmux set-window-option -t "$TMUX_PANE" automatic-rename on 2>/dev/null || true
    ;;
esac

exit 0
