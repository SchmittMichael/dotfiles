if not type -q fisher
  echo "[WARNING]: Detected that 'fisher' isn't installed. Assuming fish isn't properly set up. Run 'fisher-init' to complete setup."
end

# loading .profile
if type -q bass
  bass source "$HOME/.profile"
else
  echo "[ERROR]: Couldn't load $HOME/.profile, 'bass' isn't installed..."
end
