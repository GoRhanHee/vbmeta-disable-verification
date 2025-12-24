#!/bin/bash

##################################################
# vbmeta Verification Disabler Scripts
# made by @ravindu644 & @GoRhanHee & LLM AI Model
##################################################

shopt -s expand_aliases
set -e

export WDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export VBMETA_LINK="$1"
mkdir -p "recovery" "output" "log"

: > "${WDIR}/log/vbmeta_log.txt"

usage() {
  echo -e "\033[33mUsage:\033[0m ./vbmeta-patch.sh <URL/Path/to/vbmeta.img>"
  exit 1
}

[[ -z "$VBMETA_LINK" ]] && usage

init_requirements(){
    echo -e "[INFO] Checking requirements..."
    if ! command -v python3 &> /dev/null; then
        sudo apt update && sudo apt install -y python3 lz4 tar
    fi
    
    if [ ! -f "${WDIR}/patch-vbmeta.py" ]; then
        echo -e "[ERROR] patch-vbmeta.py file not found in ${WDIR}"
        exit 1
    fi
}

download_vbmeta(){
    if [[ "${VBMETA_LINK}" =~ ^https?:// ]]; then
        echo -e "[INFO] Downloading: ${VBMETA_LINK}"
        curl -L "${VBMETA_LINK}" -o "${WDIR}/recovery/$(basename "${VBMETA_LINK}")"
    elif [ -f "${VBMETA_LINK}" ]; then
        cp "${VBMETA_LINK}" "${WDIR}/recovery/"
    else
        echo -e "[ERROR] Invalid Input: Not a URL or File"
        exit 1
    fi
}

process_vbmeta(){
    cd "${WDIR}/recovery/"
    
    local FILE=$(ls)
    [[ "$FILE" == *.zip ]] && unzip "$FILE" && rm "$FILE"
    [[ "$FILE" == *.lz4 ]] && lz4 -d "$FILE" "${FILE%.lz4}" && rm "$FILE"
    [[ "$FILE" == *.tar ]] && tar -xf "$FILE" && rm "$FILE"

    if [ -f "vbmeta.img" ]; then
        export TARGET_VBMETA="$(pwd)/vbmeta.img"
    else
        echo -e "[ERROR] vbmeta.img not found."
        exit 1
    fi
    
    echo -e "[INFO] Patching vbmeta.img..."
    python3 "${WDIR}/patch-vbmeta.py" "${TARGET_VBMETA}" >> "${WDIR}/log/vbmeta_log.txt" 2>&1
    
    cp "${TARGET_VBMETA}" "${WDIR}/output/vbmeta.img"
    cd "${WDIR}/"
}

create_odin_tar(){
    echo -e "[INFO] Creating Patched-vbmeta.tar..."
    cd "${WDIR}/output/"

    lz4 -B6 --content-size vbmeta.img vbmeta.img.lz4

    tar -cvf "Patched-vbmeta.tar" vbmeta.img.lz4
    
    rm vbmeta.img.lz4
    echo -e "[SUCCESS] Final file: ${WDIR}/output/Patched-vbmeta.tar"
    cd "${WDIR}/"
}

cleanup(){
    rm -rf "${WDIR}/recovery/"*
    echo -e "[INFO] Cleanup complete."
}

init_requirements
download_vbmeta
process_vbmeta
create_odin_tar
cleanup