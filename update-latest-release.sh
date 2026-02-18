#!/bin/bash

set -euo pipefail

BPF_INSTALLDIR=$1

latest_release_tag=$(gh release list -L 1 --json tagName -q .[].tagName)

cilium_revision=$(cat "$BPF_INSTALLDIR/cilium-revision" 2>/dev/null || true)
built_release_tag="cilium-${cilium_revision}"

if [[ "$latest_release_tag" == "$built_release_tag" ]]; then
    echo "Release with tag $latest_release_tag already exists"
    exit 0
fi

if [[ -z "$cilium_revision" ]]; then
    echo "Could not determine built release tag"
    exit 1
fi

cd $(dirname $(realpath $BPF_INSTALLDIR))
tar -I "zstd -19 -T0" -cf ${built_release_tag}.tar.zst $(basename $(realpath $BPF_INSTALLDIR))

# assume access to gh and upload a new release
gh release create ${built_release_tag} ./${built_release_tag}.tar.zst -p

