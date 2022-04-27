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

|&word

# Named descriptors currently not highlighted.
integer myfd
exec {myfd}>~/logs/mylogfile.txt
print This is a log message. >&$myfd
exec {myfd}>&-
