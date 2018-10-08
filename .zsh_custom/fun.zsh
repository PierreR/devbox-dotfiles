function ssrc () {
    git rev-list --all | GIT_PAGER=less xargs git grep "$1"
}

function updatenixpkgs () {
    nix-prefetch-git https://github.com/nixos/nixpkgs.git "$1" > .nixpkgs.json
}

function publishDevbox () {
    if [ -z "$1" ]
    then
        echo "Please specify a version to publish";
    else
        local boxFile="/vagrant/devbox-${1}.box"
        local target="svifscapl003.prd.srv.cirb.lan:/tmp"
        if [  -f $boxFile ]
        then
            echo "Publishing ${boxFile} to ${target}"
            scp -i ~/.ssh/cirb_rsa $boxFile pradermecker@$target
        else
            echo "No $boxFile found!";
        fi
    fi
}
