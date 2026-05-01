# ~/.bashrc — interactive shell configuration
# Sourced by interactive non-login shells, and by ~/.bash_profile for login shells.

# ---- PATH ----
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="$PATH:/Users/kevin.crowley/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ---- Readline / completion ----
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z": menu-complete-backward'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind "set menu-complete-display-prefix on"

# ---- Aliases ----
alias vpn='sudo ~/vpn/vpn.sh'
alias sso='aws sso login --profile sandbox'
alias ll='ls -lah'
alias k=kubectl

# ---- Functions ----
# kubectx: pick a kube context with fzf and switch to it (also opens k9s)
kubectx() {
    local ctx
    ctx=$(kubectl config get-contexts -o name 2>/dev/null \
        | fzf --reverse --preview 'kubectl config view --minify --flatten --context={}' 2>/dev/null) || return
    [[ -n "$ctx" ]] || return
    kubectl config use-context "$ctx" 2>/dev/null
    k9s --namespace kube-system
}

# kubectxchoose: pick a kube context with fzf, switch, no k9s
kubectxchoose() {
    local ctx
    ctx=$(kubectl config get-contexts -o name 2>/dev/null \
        | fzf --reverse --preview 'kubectl config view --minify --flatten --context={}' 2>/dev/null) || return
    [[ -n "$ctx" ]] || return
    kubectl config use-context "$ctx" 2>/dev/null
}

# ocr: pick a local repo with fzf and (re)launch opencode in it.
# Quits the current shell via exec, so chain-switching doesn't stack shells.
ocr() {
    local search_roots=("$HOME/repos" "$HOME/terra/terraform" "$HOME/terra/terragrunt")
    local repo
    repo=$(
        find "${search_roots[@]}" -maxdepth 4 -type d -name .git -prune 2>/dev/null \
            | sed 's|/\.git$||' \
            | fzf --reverse --height 40% --prompt 'opencode repo> '
    ) || return
    [[ -n "$repo" ]] || return
    cd "$repo" && exec opencode "$repo"
}

# ocrc: same as ocr, but resume the most recent opencode session for that repo.
ocrc() {
    local search_roots=("$HOME/repos" "$HOME/terra/terraform" "$HOME/terra/terragrunt")
    local repo
    repo=$(
        find "${search_roots[@]}" -maxdepth 4 -type d -name .git -prune 2>/dev/null \
            | sed 's|/\.git$||' \
            | fzf --reverse --height 40% --prompt 'opencode repo (continue)> '
    ) || return
    [[ -n "$repo" ]] || return
    cd "$repo" && exec opencode --continue "$repo"
}

# ---- AWS hygiene ----
unset AWS_SESSION_TOKEN
unset AWS_SECRET_ACCESS_KEY
unset AWS_ACCESS_KEY_ID

# ---- Prompt / shell integrations ----
# Skip under non-interactive / dumb terminals (e.g. opencode bash tool)
if [ -t 1 ] && [ "$TERM" != "dumb" ]; then
    eval "$(starship init bash)"
    eval "$(zellij setup --generate-auto-start bash)"
fi
