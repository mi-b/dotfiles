# Start into tmux session directly on startup.
# Set env. variable `RUN_TMUX=true` and `RUN_TMUX_SESSION_ID=???`.
if [ "${RUN_TMUX:-}" = "true" ] &&
    [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then

    RUN_TMUX_SESSION_ID="${RUN_TMUX_SESSION_ID:-Main}"
    echo "Entering tmux session '$RUN_TMUX_SESSION_ID' from '.zshrc' "

    # Unset this variable as soon as its consumed.
    unset RUN_TMUX
    tmux new-session -A -s "$RUN_TMUX_SESSION_ID" >/dev/null 2>&1

    echo "Leaving tmux session."
fi