#!/bin/zsh
#
# Test zshRedir.

<word
<>word
>word    >|word >!word
>>word  >>|word >>!word
<<<word

>&1 <&1 >& 1 <& 1
<&- >&- <& - >& -
<&p >&p <& p >& p
>&word >&|word >&!word
&>word &>|word &>!word

>>&word >>&|word >>&!word
&>>word &>>|word &>>!word

>word   1>word   1>|word   1>!word
>>word  1>>word  1>>|word  1>>!word
>&word  1>&word  1>&|word  1>&!word
>&1word 1>&2word 1>&2|word 1>&2!word

>& 1 word >&p word >&word >&-word

&>word   1&>word  1&>|word  1&>!word
>>&word  1>>&word 1>>&|word 1>>&!word
&>>word  1&>>word 1&>>|word 1&>>!word

word | word  word|word  word |& word  word|&word
word || word word||word    # Make sure it doesn't highlight ||

# Only single digit is allowed.
# TODO: some of these aren't entirely correct, and the "4" in 42 or 43 get
# highlighted.
>&42 <&42 >& 42 <& 42
42>word   42>|word   42>!word
42>>word  42>>|word  42>>!word
42>&word  42>&|word  42>&!word
>&42word 42>&43word 42>&43|word 42>&43!word
>& 42
42&>word  42&>|word  42&>!word
42>>&word 42>>&|word 42>>&!word
42&>>word 42&>>|word 42&>>!word

# Named descriptors currently not highlighted.
integer myfd
exec {myfd}>~/logs/mylogfile.txt
print This is a log message. >&$myfd
exec {myfd}>&-
