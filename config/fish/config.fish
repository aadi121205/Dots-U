function fish_greeting
    Tux
    echo (set_color blue)"Greetings, Professor Falken."(set_color normal)
end

if status is-interactive
    # Aliases
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # NVM — add the default node version's bin dir to PATH
    set -gx NVM_DIR "$HOME/.nvm"
    set -l _nvm_default (cat "$NVM_DIR/alias/default" 2>/dev/null)
    # Resolve alias chains (e.g. "default" -> "node" -> alias file -> "v25.x.x")
    while test -f "$NVM_DIR/alias/$_nvm_default"
        set _nvm_default (cat "$NVM_DIR/alias/$_nvm_default")
    end
    # "node" / "stable" / "current" are special NVM aliases meaning latest installed
    if string match -qr '^(node|stable|current)$' -- "$_nvm_default"
        set _nvm_default (ls -v "$NVM_DIR/versions/node/" 2>/dev/null | tail -1)
    end
    if test -d "$NVM_DIR/versions/node/$_nvm_default/bin"
        fish_add_path "$NVM_DIR/versions/node/$_nvm_default/bin"
    end

    # Conda lazy loader — only initializes on first use
    function conda
        functions --erase conda
        if test -x /opt/miniconda3/bin/conda
            /opt/miniconda3/bin/conda shell.fish hook | source
        else
            fish_add_path /opt/miniconda3/bin
        end
        conda $argv
    end
end

# Created by `pipx` on 2026-04-18 20:12:45
set PATH $PATH /home/aadi/.local/bin
