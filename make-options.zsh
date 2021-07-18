#!/bin/zsh

(( ! $+argv[1] )) && print >&2 'set the first argument to a zsh source direcrory' && exit 1
src=$1

typeset -U all=()
for opt in $(grep '^pindex([A-Za-z_]*)$' "$src/Doc/Zsh/options.yo"); do
	x=${${(L)opt#pindex\(}%\)}
	[[ $x =~ '^no_' ]] && all+=(${x/no_/})
done
all+=(no_match)  # Special case: no_match / no_no_match.

print "syn match   zshOption nextgroup=zshOption,zshComment skipwhite contained /\\\v"
print "            \\\ <%(no_?)?%("
print "            \\\ ${(oj:|:)all//_/_?})>/"
print "            \\\)>/"  # Note: a space here will break the last entry.
