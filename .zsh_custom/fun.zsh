function sshi () {
	ssh -A -i ~/.ssh/alhazen_rsa alhazen@$1
}

function ssrc () {
  git rev-list --all | GIT_PAGER=less xargs git grep "$1"
}
