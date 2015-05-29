" Vim syntax file
" Language:             Zsh shell script
" Maintainer:           Christian Brabandt <cb@256bit.org>
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2015-05-29
" License:              Vim (see :h license)

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

setlocal iskeyword+=-

syn keyword zshTodo             contained TODO FIXME XXX NOTE

syn region  zshComment          oneline start='\%(^\|\s\)#' end='$'
                                \ contains=zshTodo,@Spell

syn match   zshPreProc          '^\%1l#\%(!\|compdef\|autoload\).*$'

syn match   zshQuoted           '\\.'
syn region  zshString           matchgroup=zshStringDelimiter start=+"+ end=+"+
                                \ contains=zshQuoted,@zshDerefs,@zshSubst
syn region  zshString           matchgroup=zshStringDelimiter start=+'+ end=+'+
" XXX: This should probably be more precise, but Zsh seems a bit confused about it itself
syn region  zshPOSIXString      matchgroup=zshStringDelimiter start=+\$'+
                                \ end=+'+ contains=zshQuoted
syn match   zshJobSpec          '%\(\d\+\|?\=\w\+\|[%+-]\)'

syn keyword zshPrecommand       noglob nocorrect exec command builtin - time

syn keyword zshDelimiter        do done end

syn keyword zshConditional      if then elif else fi case in esac select

syn keyword zshRepeat           while until repeat

syn keyword zshRepeat           for foreach nextgroup=zshVariable skipwhite

syn keyword zshException        always

syn keyword zshKeyword          function nextgroup=zshKSHFunction skipwhite

syn match   zshKSHFunction      contained '\k\+'
syn match   zshFunction         '^\s*\k\+\ze\s*()'

syn match   zshOperator         '||\|&&\|;\|&!\='

syn match   zshRedir            '\d\=\(<\|<>\|<<<\|<&\s*[0-9p-]\=\)'
syn match   zshRedir            '\d\=\(>\|>>\|>&\s*[0-9p-]\=\|&>\|>>&\|&>>\)[|!]\='
syn match   zshRedir            '|&\='

syn region  zshHereDoc          matchgroup=zshRedir
                                \ start='<\@<!<<\s*\z([^<]\S*\)'
                                \ end='^\z1\>'
                                \ contains=@zshSubst
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start='<\@<!<<\s*\\\z(\S\+\)'
                                \ end='^\z1\>'
                                \ contains=@zshSubst
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start='<\@<!<<-\s*\\\=\z(\S\+\)'
                                \ end='^\s*\z1\>'
                                \ contains=@zshSubst
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start=+<\@<!<<\s*\(["']\)\z(\S\+\)\1+ 
                                \ end='^\z1\>'
syn region  zshHereDoc          matchgroup=zshRedir
                                \ start=+<\@<!<<-\s*\(["']\)\z(\S\+\)\1+
                                \ end='^\s*\z1\>'

syn match   zshVariable         '\<\h\w*' contained

syn match   zshVariableDef      '\<\h\w*\ze+\=='
" XXX: how safe is this?
syn region  zshVariableDef      oneline
                                \ start='\$\@<!\<\h\w*\[' end='\]\ze+\=='
                                \ contains=@zshSubst

syn cluster zshDerefs           contains=zshShortDeref,zshLongDeref,zshDeref

if !exists("g:zsh_syntax_variables")
  let s:zsh_syntax_variables = 'all'
else
  let s:zsh_syntax_variables = g:zsh_syntax_variables
endif

if s:zsh_syntax_variables =~ 'short\|all'
  syn match zshShortDeref       '\$[!#$*@?_-]\w\@!'
  syn match zshShortDeref       '\$[=^~]*[#+]*\d\+\>'
endif

if s:zsh_syntax_variables =~ 'long\|all'
  syn match zshLongDeref        '\$\%(ARGC\|argv\|status\|pipestatus\|CPUTYPE\|EGID\|EUID\|ERRNO\|GID\|HOST\|LINENO\|LOGNAME\)'
  syn match zshLongDeref        '\$\%(MACHTYPE\|OLDPWD OPTARG\|OPTIND\|OSTYPE\|PPID\|PWD\|RANDOM\|SECONDS\|SHLVL\|signals\)'
  syn match zshLongDeref        '\$\%(TRY_BLOCK_ERROR\|TTY\|TTYIDLE\|UID\|USERNAME\|VENDOR\|ZSH_NAME\|ZSH_VERSION\|REPLY\|reply\|TERM\)'
endif

if s:zsh_syntax_variables =~ 'all'
  syn match zshDeref            '\$[=^~]*[#+]*\h\w*\>'
else
  syn match zshDeref            transparent contains=NONE '\$[=^~]*[#+]*\h\w*\>'
endif

syn match   zshCommands         '\%(^\|\s\)[.:]\ze\s'
syn keyword zshCommands         alias autoload bg bindkey break bye cap cd
                                \ chdir clone comparguments compcall compctl
                                \ compdescribe compfiles compgroups compquote
                                \ comptags comptry compvalues continue dirs
                                \ disable disown echo echotc echoti emulate
                                \ enable eval exec exit export false fc fg
                                \ functions getcap getln getopts hash history
                                \ jobs kill let limit log logout popd print
                                \ printf pushd pushln pwd r read readonly
                                \ rehash return sched set setcap setopt shift
                                \ source stat suspend test times trap true
                                \ ttyctl type ulimit umask unalias unfunction
                                \ unhash unlimit unset unsetopt vared wait
                                \ whence where which zcompile zformat zftp zle
                                \ zmodload zparseopts zprof zpty zregexparse
                                \ zsocket zstyle ztcp
" Options, generated by: echo ${(j:\n:)options[(I)*]} | sort
syn keyword zshOptions          aliases allexport alwayslastprompt alwaystoend
                                \ appendhistory autocd autocontinue autolist
                                \ automenu autonamedirs autoparamkeys
                                \ autoparamslash autopushd autoremoveslash
                                \ autoresume badpattern banghist bareglobqual
                                \ bashautolist bashrematch beep bgnice braceccl
                                \ braceexpand bsdecho caseglob casematch cbases
                                \ cdablevars chasedots chaselinks checkjobs
                                \ clobber combiningchars completealiases
                                \ completeinword continueonerror correct
                                \ correctall cprecedences cshjunkiehistory
                                \ cshjunkieloops cshjunkiequotes cshnullcmd
                                \ cshnullglob debugbeforecmd dotglob dvorak
                                \ emacs equals errexit errreturn evallineno
                                \ exec extendedglob extendedhistory flowcontrol
                                \ forcefloat functionargzero glob globalexport
                                \ globalrcs globassign globcomplete globdots
                                \ globsubst hashall hashcmds hashdirs
                                \ hashexecutablesonly hashlistall
                                \ histallowclobber histappend histbeep
                                \ histexpand histexpiredupsfirst histfcntllock
                                \ histfindnodups histignorealldups
                                \ histignoredups histignorespace histlexwords
                                \ histnofunctions histnostore histreduceblanks
                                \ histsavebycopy histsavenodups
                                \ histsubstpattern histverify hup ignorebraces
                                \ ignoreclosebraces ignoreeof incappendhistory
                                \ incappendhistorytime interactive
                                \ interactivecomments ksharrays kshautoload
                                \ kshglob kshoptionprint kshtypeset
                                \ kshzerosubscript listambiguous listbeep
                                \ listpacked listrowsfirst listtypes localloops
                                \ localoptions localpatterns localtraps log
                                \ login longlistjobs magicequalsubst mailwarn
                                \ mailwarning markdirs menucomplete monitor
                                \ multibyte multifuncdef multios nomatch notify
                                \ nullglob numericglobsort octalzeroes onecmd
                                \ overstrike pathdirs pathscript physical
                                \ pipefail posixaliases posixargzero
                                \ posixbuiltins posixcd posixidentifiers
                                \ posixjobs posixstrings posixtraps
                                \ printeightbit printexitvalue privileged
                                \ promptbang promptcr promptpercent promptsp
                                \ promptsubst promptvars pushdignoredups
                                \ pushdminus pushdsilent pushdtohome
                                \ rcexpandparam rcquotes rcs recexact
                                \ rematchpcre restricted rmstarsilent
                                \ rmstarwait sharehistory shfileexpansion
                                \ shglob shinstdin shnullcmd shoptionletters
                                \ shortloops shwordsplit singlecommand
                                \ singlelinezle sourcetrace stdin
                                \ sunkeyboardhack trackall transientrprompt
                                \ trapsasync typesetsilent unset verbose vi
                                \ warncreateglobal xtrace zle

syn keyword zshOptions          noaliases noallexport noalwayslastprompt noalwaystoend
                                \ noappendhistory noautocd noautocontinue noautolist
                                \ noautomenu noautonamedirs noautoparamkeys
                                \ noautoparamslash noautopushd noautoremoveslash
                                \ noautoresume nobadpattern nobanghist nobareglobqual
                                \ nobashautolist nobashrematch nobeep nobgnice nobraceccl
                                \ nobraceexpand nobsdecho nocaseglob nocasematch nocbases
                                \ nocdablevars nochasedots nochaselinks nocheckjobs
                                \ noclobber nocombiningchars nocompletealiases
                                \ nocompleteinword nocontinueonerror nocorrect
                                \ nocorrectall nocprecedences nocshjunkiehistory
                                \ nocshjunkieloops nocshjunkiequotes nocshnullcmd
                                \ nocshnullglob nodebugbeforecmd nodotglob nodvorak
                                \ noemacs noequals noerrexit noerrreturn noevallineno
                                \ noexec noextendedglob noextendedhistory noflowcontrol
                                \ noforcefloat nofunctionargzero noglob noglobalexport
                                \ noglobalrcs noglobassign noglobcomplete noglobdots
                                \ noglobsubst nohashall nohashcmds nohashdirs
                                \ nohashexecutablesonly nohashlistall
                                \ nohistallowclobber nohistappend nohistbeep
                                \ nohistexpand nohistexpiredupsfirst nohistfcntllock
                                \ nohistfindnodups nohistignorealldups
                                \ nohistignoredups nohistignorespace nohistlexwords
                                \ nohistnofunctions nohistnostore nohistreduceblanks
                                \ nohistsavebycopy nohistsavenodups
                                \ nohistsubstpattern nohistverify nohup noignorebraces
                                \ noignoreclosebraces noignoreeof noincappendhistory
                                \ noincappendhistorytime nointeractive
                                \ nointeractivecomments noksharrays nokshautoload
                                \ nokshglob nokshoptionprint nokshtypeset
                                \ nokshzerosubscript nolistambiguous nolistbeep
                                \ nolistpacked nolistrowsfirst nolisttypes nolocalloops
                                \ nolocaloptions nolocalpatterns nolocaltraps nolog
                                \ nologin nolonglistjobs nomagicequalsubst nomailwarn
                                \ nomailwarning nomarkdirs nomenucomplete nomonitor
                                \ nomultibyte nomultifuncdef nomultios nonomatch nonotify
                                \ nonullglob nonumericglobsort nooctalzeroes noonecmd
                                \ nooverstrike nopathdirs nopathscript nophysical
                                \ nopipefail noposixaliases noposixargzero
                                \ noposixbuiltins noposixcd noposixidentifiers
                                \ noposixjobs noposixstrings noposixtraps
                                \ noprinteightbit noprintexitvalue noprivileged
                                \ nopromptbang nopromptcr nopromptpercent nopromptsp
                                \ nopromptsubst nopromptvars nopushdignoredups
                                \ nopushdminus nopushdsilent nopushdtohome
                                \ norcexpandparam norcquotes norcs norecexact
                                \ norematchpcre norestricted normstarsilent
                                \ normstarwait nosharehistory noshfileexpansion
                                \ noshglob noshinstdin noshnullcmd noshoptionletters
                                \ noshortloops noshwordsplit nosinglecommand
                                \ nosinglelinezle nosourcetrace nostdin
                                \ nosunkeyboardhack notrackall notransientrprompt
                                \ notrapsasync notypesetsilent nounset noverbose novi
                                \ nowarncreateglobal noxtrace nozle

syn keyword zshTypes            float integer local typeset declare

" XXX: this may be too much
" syn match   zshSwitches         '\s\zs--\=[a-zA-Z0-9-]\+'

syn match   zshNumber           '[+-]\=\<\d\+\>'
syn match   zshNumber           '[+-]\=\<0x\x\+\>'
syn match   zshNumber           '[+-]\=\<0\o\+\>'
syn match   zshNumber           '[+-]\=\d\+#[-+]\=\w\+\>'
syn match   zshNumber           '[+-]\=\d\+\.\d\+\>'

" TODO: $[...] is the same as $((...)), so add that as well.
syn cluster zshSubst            contains=zshSubst,zshOldSubst,zshMathSubst
syn region  zshSubst            matchgroup=zshSubstDelim transparent
                                \ start='\$(' skip='\\)' end=')' contains=TOP
syn region  zshParentheses      transparent start='(' skip='\\)' end=')'
syn region  zshMathSubst        matchgroup=zshSubstDelim transparent
                                \ start='\$((' skip='\\)'
                                \ matchgroup=zshSubstDelim end='))'
                                \ contains=zshParentheses,@zshSubst,zshNumber,
                                \ @zshDerefs,zshString
syn region  zshBrackets         contained transparent start='{' skip='\\}'
                                \ end='}'
syn region  zshSubst            matchgroup=zshSubstDelim start='\${' skip='\\}'
                                \ end='}' contains=@zshSubst,zshBrackets,zshQuoted,zshString
syn region  zshOldSubst         matchgroup=zshSubstDelim start=+`+ skip=+\\`+
                                \ end=+`+ contains=TOP,zshOldSubst

syn sync    minlines=50
syn sync    match zshHereDocSync    grouphere   NONE '<<-\=\s*\%(\\\=\S\+\|\(["']\)\S\+\1\)'
syn sync    match zshHereDocEndSync groupthere  NONE '^\s*EO\a\+\>'

hi def link zshTodo             Todo
hi def link zshComment          Comment
hi def link zshPreProc          PreProc
hi def link zshQuoted           SpecialChar
hi def link zshString           String
hi def link zshStringDelimiter  zshString
hi def link zshPOSIXString      zshString
hi def link zshJobSpec          Special
hi def link zshPrecommand       Special
hi def link zshDelimiter        Keyword
hi def link zshConditional      Conditional
hi def link zshException        Exception
hi def link zshRepeat           Repeat
hi def link zshKeyword          Keyword
hi def link zshFunction         None
hi def link zshKSHFunction      zshFunction
hi def link zshHereDoc          String
hi def link zshOperator         None
hi def link zshRedir            Operator
hi def link zshVariable         None
hi def link zshVariableDef      zshVariable
hi def link zshDereferencing    PreProc
if s:zsh_syntax_variables =~ 'short\|all'
  hi def link zshShortDeref     zshDereferencing
else
  hi def link zshShortDeref     None
endif
if s:zsh_syntax_variables =~ 'long\|all'
  hi def link zshLongDeref      zshDereferencing
else
  hi def link zshLongDeref      None
endif
if s:zsh_syntax_variables =~ 'all'
  hi def link zshDeref          zshDereferencing
else
  hi def link zshDeref          None
endif
hi def link zshCommands         Keyword
hi def link zshOptions          Constant
hi def link zshTypes            Type
hi def link zshSwitches         Special
hi def link zshNumber           Number
hi def link zshSubst            PreProc
hi def link zshMathSubst        zshSubst
hi def link zshOldSubst         zshSubst
hi def link zshSubstDelim       zshSubst

let b:current_syntax = "zsh"

let &cpo = s:cpo_save
unlet s:cpo_save
