{ pkgs, theme, ... }:

let
  name = "pw";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  lemonbar = "${pkgs.lemonbar-xft}/bin/lemonbar";
in
pkgs.writeShellScriptBin name
  ''
    #!/usr/bin/env bash
    # pw - a mnml password manager
    command -v gpg >/dev/null 2>&1 && gpg=gpg
    command -v gpg2 >/dev/null 2>&1 && gpg=gpg2
    # check if xclip or pbcopy exist
    # command -v xclip >/dev/null 2>&1 && copy="xclip -rmlastnl -selection clipboard"
    # command -v pbcopy >/dev/null 2>&1 && copy="pbcopy | tr -d '\n'"
    # export PW_DIR to your own path
    [[ -z "$PW_DIR" ]] && PW_DIR="$HOME/.pw"
    init() {
        if [[ ! -e "$PW_DIR" ]]; then
            mkdir -p "$PW_DIR"
            printf "pw: password directory initialized at %s\n" "$PW_DIR"
        else
            printf "PW_DIR is %s\n" "$PW_DIR"
            die "$PW_DIR exists"
        fi
    }
    add() {
        # $1: path to file
        # $2 [optional]: password text
        [[ -z "$PW_KEY" ]] && die "\$PW_KEY not set"
        if [[ "$#" -eq 2 ]]; then
            pass="$2"
        else
            # uses default length of 25 chars, unless PW_LEN is set
            pass="$(pwgen "${PW_LEN:-25}" 1 -s)"
            printf "pw: generated password for %s\n" "$1"
        fi
        if [[ ! -f "$PW_DIR/$1.gpg" ]]; then
            printf "%s" "$pass" | "$gpg" -aer "$PW_KEY" -o "$PW_DIR/$1.gpg"
            printf "pw: %s/%s.gpg created\n" "$PW_DIR" "$1"
        else
            die "the file $PW_DIR/$1.gpg exists"
        fi
        (
            cd $PW_DIR
            git add .
            git commit -m "$(date)"
            remote="$(git remote show)"
            branch="$(git branch --show-current)"
            git pull -r "$remote" "$branch"
            git push "$remote" "$branch"
        )
    }
    list() {
        (cd "$PW_DIR"; find *.gpg | awk -F '.gpg' '{ print $1 }' )
    }
    del() {
        checkf "$PW_DIR/$1.gpg"
        read -rn 1 -p "pw: are you sure you want to delete $1? [y/n]: "
        printf "\n"
        [[ "$REPLY" == [yY] ]] && {
            rm -f "$PW_DIR/$1.gpg"
            printf "pw: deleted %s" "$1"
        }
    }
    show() {
        checkf "$PW_DIR/$1.gpg"
        "$gpg" --decrypt --quiet --use-agent "$PW_DIR/$1.gpg"
    }
    # TODO: rework having to checkf twice
    copy() {
        checkf "$PW_DIR/$1.gpg"
        if [[ "$OSTYPE" =~ darwin* ]]; then
            show "$1" | head -1 | pbcopy | tr -d '\n'
        else
            show "$1" | head -1 | xclip -rmlastnl -selection clipboard
        fi
        printf "pw: copied %s to clipboard\n" "$1"
    }
    usage() {
        usage="
    pw - mnml password manager
    usage: pw [options] [NAME]
    All options except -i and -h require a NAME argument.
    options:
      -i            Initializes password directory at \$HOME/.pw or at \$PW_DIR, if it exists.
      -a            Add a password.
      -g            Generate a password.
      -s            Print password to STDOUT.
      -l            List out all passwords.
      -c            Copy existing password to clipboard.
      -d            Delete password.
      -h            Display this help message and exit.
    Requires PW_KEY to be set. Optionally, set PW_DIR for custom directory location.
    Set PW_LEN to an integer of your choice, to override the default password length of 25.
    "
        printf "%s" "$usage"
        exit 1
    }
    checkf() {
        [[ ! -f "$1" ]] &&
            die "$1 does not exist"
    }
    die() {
        printf "error: %s\n" "$1" >&2
        exit 1
    }
    main() {
        [[ -z "$1" ]] && {
            usage
        }
        while getopts "ila:g:s:c:d:h" options
        do
            # shellcheck disable=SC2221,SC2222
            case "$options" in
                i) init ;;
                l) list ;;
                g) add "$OPTARG" ;;
                a)
                   read -rsp "enter password: " pass
                   printf "\n"
                   add "$OPTARG" "$pass"
                   ;;
                s) show "$OPTARG" ;;
                c) copy "$OPTARG" ;;
                d) del "$OPTARG" ;;
                *|h) usage ;;
            esac
        done
        shift $(( OPTIND -1 ))
    }
    main "$@"
  ''
