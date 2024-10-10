#!/usr/bin/env bash

install_repo() {
    # shellcheck disable=SC2155
    local temp_deb="$(mktemp).deb"
    # shellcheck disable=SC2155
    local repo_deb=$(curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r '(.assets[].browser_download_url | select(. | contains("_amd64.deb")))')

    echo "Fetching $repo_deb ..."
    wget -q -O "$temp_deb" "$repo_deb" 

    echo "... Installing $repo_deb ..."
    sudo dpkg -i "$temp_deb"

    echo "... Cleaning Up ..."
    rm -f "$temp_deb"

    echo "... done!"
}

install_repo "obsidianmd/obsidian-releases"
