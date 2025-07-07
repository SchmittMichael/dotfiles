function enable_conda
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  if test -f /home/michael/miniconda3/bin/conda
      eval /home/michael/miniconda3/bin/conda "shell.fish" "hook" $argv | source
  else
      if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
          . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
      else
          set -x PATH "$HOME/miniconda3/bin" $PATH
      end
  end
  # <<< conda initialize <<<
end
