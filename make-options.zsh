#!/bin/zsh

(( ! $+argv[1] )) && print >&2 'set the first argument to a zsh source direcrory' && exit 1
src=$1

typeset -U all=()
for opt in $(grep '^pindex([A-Za-z_]*)$' "$src/Doc/Zsh/options.yo"); do
	all+=(${${(L)opt#pindex\(}%\)})
done

IFS=$'\n' lines=($(fold -sw100 <<<${(oj: :)all}))
print -r 'syn keyword zshOption nextgroup=zshOption,zshComment skipwhite contained'
print    "           \\\ ${(j:\n           \\ :)lines}"
