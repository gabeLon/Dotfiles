# Load dotfiles:
for file in ~/.{bash_prompt,aliases,private}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#Git auto-complete
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

# >>> conda nitialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ubuntu/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0  ]; then
        eval "$__conda_setup"
    else
            if [ -f "/home/ubuntu/anaconda3/etc/profile.d/conda.sh"  ]; then
                        . "/home/ubuntu/anaconda3/etc/profile.d/conda.sh"
                            else
                                        export PATH="/home/ubuntu/anaconda3/bin:$PATH"
                                            fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/home/ubuntu/.local/bin:$PATH"  
