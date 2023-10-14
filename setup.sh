#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"
echo "$script_dir"

ramdisk="ramdisk.img"
original_ramdisk_path="$ANDROID_SDK_ROOT/system-images/android-29/default/x86_64/original_$ramdisk"
ramdisk_path="$ANDROID_SDK_ROOT/system-images/android-29/default/x86_64/$ramdisk"
emulator_bin="$ANDROID_HOME/tools/emulator"

function check_exit_code() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error: The last command failed with exit code $exit_code."
        exit 1
    fi
}

function reset_ramdisk() {
    cp -v $original_ramdisk_path $ramdisk_path
    exit 0
}

function backup_ramdisk() {
    if [ ! -f "$original_ramdisk_path" ]; then
        echo "taking backup of $ramdisk_path"
        cp -v $ramdisk_path $original_ramdisk_path
    fi
}

function fetch_original_ramdisk() {
    cp -v $original_ramdisk_path $script_dir/$ramdisk
}

function download_magisk() {
    url="https://github.com/topjohnwu/Magisk/releases/download/v24.0/Magisk-v24.0.apk"
    filename="Magisk-v24.0.apk"
    # Version 26.3 does not work on emulator.
    # url="https://github.com/topjohnwu/Magisk/releases/download/v26.3/Magisk.v26.3.apk"
    # filename="Magisk.v26.3.apk"
    if [ ! -f "$filename" ]; then
        wget $url
    else
        echo "$filename already downloaded"
    fi
    cp -v $filename $script_dir/MagiskOnEmulator/magisk.zip
    cp -v $filename $script_dir/MagiskOnEmulator/magisk.apk
}

function patch_manager() {
    cd $script_dir/MagiskOnEmulator
    chmod +x patch.sh
    ./patch.sh manager
    cd $script_dir
}

function wait_for_gui_install() {
    while :; do
        tput bold
        tput setaf 1
        echo "Open AVD and click Install (patch a file) then continue here"
        tput sgr0
        read -rp "Type 'yes' to continue: " user_input
        if [ "${user_input,,}" = "yes" ]; then
            break
        else
            echo "You did not type 'yes.' Please try again."
        fi
    done
}

function pull_patched() {
    cd $script_dir/MagiskOnEmulator
    ./patch.sh pull
    cp -v $ramdisk $ramdisk_path
    cd $script_dir
    echo "Shutdown AVD and Wipe data"
}

wait_for_gui_install
exit 0

backup_ramdisk
# reset_ramdisk
fetch_original_ramdisk
download_magisk
patch_manager
wait_for_gui_install
pull_patched
