#!/usr/bin/env bash

if [[ -z $SYSPROV_GIT_REMOTE ]]; then
    SYSPROV_GIT_REMOTE=https://github.com/garrett-he/sysprov.git
fi

git clone $SYSPROV_GIT_REMOTE /tmp/sysprov

cd /tmp/sysprov
git submodule init
git submodule update
/tmp/sysprov/install.sh "$SYSPROV_FLAGS" < /dev/tty

rm -rf /tmp/sysprov
