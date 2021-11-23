#!/usr/bin/env bash
set -euo pipefail

YELLOW="\e[0;93m"
GREEN="\e[0;92m"
BOLD="\e[1m"
RESET="\e[0m"

HOME_APP=/home/app
ENVIRONMENT=development

step()    { echo -e "${YELLOW}${BOLD}===> ${RESET}${*}${RESET}"; }
success() { echo -e "${RESET}${GREEN}${BOLD}${*}${RESET}"; }

step "Environment: ${ENVIRONMENT}"
step "Current dir: $(pwd)"
step "Ruby version: $(ruby -v)"
step "Node version: $(node -v)"
step "Yarn version: $(yarn -v)"

# SETUP AND CHECK DEFINITIONS

function setup_shell() {
    if [[ ! -f /app/.bashrc ]]; then return 0; fi

    rm -f /home/app/.bashrc

    chown app.app ${HOME_APP}/
    gosu app ln -sf /app/.bashrc ${HOME_APP}/.bashrc

    step "Setup shell $(success [Done])"
}

function setup_initialized() {
#    if [[ ! -f /app/Gemfile ]]; then return 0; fi
    if [[ -f /app/.initialized ]]; then return 0; fi

    step "Installing requirements"

    (
        set -x

#        chown app.app -R /usr/local/bundle

#        gosu app gem install bundler | cat

        gosu app touch /app/.initialized
    )

    step "Initialized $(success [Done])"
}


case "$1" in
    -)
        # Switch to app user
        if [[ ${1} = '-' ]]; then shift; fi
        set -- gosu app bash
    ;;
    --shell)
        (
            setup_shell
            #setup_initialized
        )

        # Switch to app user
        if [[ ${1} = '-' ]]; then shift; fi
        set -- gosu app bash
    ;;
esac

step "Running: $@"
exec "$@"
exit 0
