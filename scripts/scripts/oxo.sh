#!/bin/bash
# 0x0 - client for 0x0.st

me=${0##*/}
host=https://0x0.st

if [[ ! -t 1 ]];then
    quiet=true
fi

help() {
    cat >&2 <<EOF
Usage: ${me} [-f <file>] [-s <url>] [-u <url>] [file]
Client for interacting with 0x0.st.
If no file is given, upload stdin.
    -f <file>       - upload <file>
    -s <url>        - shorten <url>
    -u <url>        - upload content of <url>
EOF
}

clip() {
    if command -v xsel >/dev/null 2>&1;then
        printf '%s' "$@" | xsel -b
    fi
}

file_upload() {
    local curl_opts="-s" file="$1" type
    [[ "${quiet}" ]] || curl_opts="-#"
    [[ "${quiet}" ]] || echo "uploading \"${file}\"..." >&2
    [[ "$#" -gt 1 ]] && echo -n "${file} ... "
    url=$(curl ${curl_opts} -F "file=@${file}" "${host}")
    echo "${url}"
    clip "${url}"
}

shorten_url() {
    local curl_opts="-s" url="$1" shortened
    [[ "${quiet}" ]] || curl_opts="-#"
    [[ "${quiet}" ]] || echo "shortening \"${url}\"..." >&2
    [[ "$#" -gt 1 ]] && echo -n "${url} ... "
    shortened=$(curl ${curl_opts} -F "shorten=${url}" "${host}")
    echo "${shortened}"
    clip "${shortened}"
}

upload_url() {
    local curl_opts="-s" url="$1" uploaded
    [[ "${quiet}" ]] || curl_opts="-#"
    [[ "${quiet}" ]] || echo "uploading \"${url}\"..." >&2
    [[ "$#" -gt 1 ]] && echo -n "${url} ... "
    uploaded=$(curl ${curl_opts} -F "url=${url}" "${host}")
    echo "${uploaded}"
    clip "${uploaded}"
}

# 1KiB = 1024 bytes
# 1MiB = 1024 KiB
# max size - 256MiB

max_size=$(( (1024*1024) * 256 ))

if [[ -f "$1" || "$#" -lt 1 ]];then
    mode="default"
else
    mode="$1"
    shift
fi

case "$mode" in
    default)
        if [[ "$#" -gt 0 ]];then
            file_upload "${@}"
        else
            quiet=true file_upload "-"
        fi
    ;;
    -f)
        file_upload "${@}"
    ;;
    -u)
        upload_url "${@}"
    ;;
    -s)
        shorten_url "${@}"
    ;;
    -h|--help)
        help
    ;;
esac

