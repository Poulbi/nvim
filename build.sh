#!/bin/sh

set -eu

ScriptDirectory="$(dirname "$(readlink -f "$0")")"
cd "$ScriptDirectory"

files="$(find . -type f -name "*.lua")"

set -x
stylua $files
luacheck --no-color --globals=vim -- $files
