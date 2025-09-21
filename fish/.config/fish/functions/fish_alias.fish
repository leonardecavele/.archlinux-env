function fish_alias
	echo "alias $argv[1]=\"$argv[2]\"" >> "$HOME/.dotfiles/fish/.config/fish/conf.d/alias.fish"
end
