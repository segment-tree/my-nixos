alias prepare_vhome="unshare --pid --uts --user -r --mount-proc --mount --fork bash"
function vhome(){
    prepare_vhome -c "source $HOME/.bashrc ; vhome_work $1 $2 $3"
}
function vhome_work(){
    if [ $UID != 0 ]; then
        echo "Failed"
        return
    fi
    local a=$1
    mkdir -p "$HOME/.var/app/$a/data/.inbox"
    # ln -s $HOME/Public $HOME/.var/app/$a/data/Public
    mkdir -p "$HOME/.var/app/$a/tmp"
    # nix-shell -p util-linux --run "mount -t overlay overlay -o lowerdir=$HOME,upperdir=$HOME/.var/app/$a/data,workdir=$HOME/.var/app/$a/tmp $HOME"
    #nix shell nixpkgs#util-linux -c \
    PATH=${PATH//\/run\/wrappers\/bin\:}  # trick
    local mntdir=/mnt
    mount -t overlay overlay -o lowerdir=$HOME,upperdir=$HOME/.var/app/$a/data,workdir=$HOME/.var/app/$a/tmp $mntdir
    # mount --bind /run/current-system/sw/bin /run/wrappers/bin/ # remove
    # see https://github.com/NixOS/nixpkgs/pull/206658
    # https://github.com/NixOS/nixpkgs/issues/42117
    cd /
    hostname virt-$a
    # exec unshare --pid --user --mount-proc --mount --fork bash
    local directbd="$HOME/.config/ibus $HOME/.config/ibus"
    exec bwrap --dev-bind / / --bind $mntdir $HOME --bind $directbd --unshare-user --uid 1000 --gid 1000 bash
}
