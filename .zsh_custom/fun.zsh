function sshi () {
	TERM=xterm ssh -A -i ~/.ssh/alhazen_rsa alhazen@$1
}

function ssrc () {
  git rev-list --all | GIT_PAGER=less xargs git grep "$1"
}

function updateNixpkgs () {
    nix-prefetch-git https://github.com/NixOS/nixpkgs.git "$1" > ~/.config/nixpkgs/.nixpkgs.json
}
