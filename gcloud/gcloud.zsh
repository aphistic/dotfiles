# Update the path for the gcloud sdk
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/bin/google-cloud-sdk/path.zsh.inc"; fi

# Enable shell completion for gcloud
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/bin/google-cloud-sdk/completion.zsh.inc"; fi
