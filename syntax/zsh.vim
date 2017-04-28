" Vim syntax file
" Language:             Zsh shell script
" Maintainer:           Christian Brabandt <cb@256bit.org>
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2017-04-28
" License:              Vim (see :h license)
" Repository:           https://github.com/chrisbra/vim-zsh

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

if v:version > 704 || (v:version == 704 && has("patch1142"))
    syn iskeyword @,48-57,_,192-255,#,-
else
    setlocal iskeyword+=-
endif
if get(g:, 'zsh_fold_enable', 0)
    setlocal foldmethod=syntax
endif

syn keyword zshTodo             contained TODO FIXME XXX NOTE

syn region  zshComment          oneline start='\%(^\|\s\+\)#' end='$'
                                \ contains=zshTodo,@Spell fold

syn region  zshComment          start='^\s*#' end='^\%(\s*#\)\@!'
                                \ contains=zshTodo,@Spell fold

syn match   zshPreProc          '^\%1l#\%(!\|compdef\|autoload\).*$'

syn match   zshQuoted           '\\.'
syn region  zshString           matchgroup=zshStringDelimiter start=+"+ end=+"+
                                \ contains=zshQuoted,@zshDerefs,@zshSubst fold
syn region  zshString           matchgroup=zshStringDelimiter start=+'+ end=+'+ fold
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

syn match   zshKSHFunction      contained '\w\S\+'
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
                                \ start='\$\@<!\<\h\w*\[' end='\]\ze+\?=\?'
                                \ contains=@zshSubst

syn cluster zshDerefs           contains=zshShortDeref,zshLongDeref,zshDeref,zshDollarVar

syn match zshShortDeref       '\$[!#$*@?_-]\w\@!'
syn match zshShortDeref       '\$[=^~]*[#+]*\d\+\>'

syn match zshLongDeref        '\$\%(ARGC\|argv\|status\|pipestatus\|CPUTYPE\|EGID\|EUID\|ERRNO\|GID\|HOST\|LINENO\|LOGNAME\)'
syn match zshLongDeref        '\$\%(MACHTYPE\|OLDPWD OPTARG\|OPTIND\|OSTYPE\|PPID\|PWD\|RANDOM\|SECONDS\|SHLVL\|signals\)'
syn match zshLongDeref        '\$\%(TRY_BLOCK_ERROR\|TTY\|TTYIDLE\|UID\|USERNAME\|VENDOR\|ZSH_NAME\|ZSH_VERSION\|REPLY\|reply\|TERM\)'

syn match zshDollarVar        '\$\h\w*'
syn match zshDeref            '\$[=^~]*[#+]*\h\w*\>'

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
                                \ rehash return sched set setcap shift
                                \ source stat suspend test times trap true
                                \ ttyctl type ulimit umask unalias unfunction
                                \ unhash unlimit unset  vared wait
                                \ whence where which zcompile zformat zftp zle
                                \ zmodload zparseopts zprof zpty zregexparse
                                \ zsocket zstyle ztcp

" Options, generated by: echo ${(j:\n:)options[(I)*]} | sort
" Create a list of option names from zsh source dir:
"     #!/bin/zsh
"    topdir=/path/to/zsh-xxx
"    grep '^pindex([A-Za-z_]*)$' $topdir/Src/Doc/Zsh/optionsyo |
"    while read opt
"    do
"        echo ${${(L)opt#pindex\(}%\)}
"    done

syn case ignore

syn match   zshOptStart /^\s*\%(\%(\%(un\)\?setopt\)\|set\s+[-+]o\)/ nextgroup=zshOption skipwhite
syn match   zshOption /\%(\%(no\>\)\?\<aliases\>\)\|\%(\%(no\>\)\?\<allexport\>\)\|\%(\%(no\>\)\?\<all_export\>\)\|\%(\%(no\>\)\?\<alwayslastprompt\>\)\|\%(\%(no\>\)\?\<always_last_prompt\>\)\|\%(\%(no\>\)\?\<always_lastprompt\>\)\|\%(\%(no\>\)\?\<alwaystoend\>\)\|\%(\%(no\>\)\?\<always_to_end\>\)\|\%(\%(no\>\)\?\<appendcreate\>\)\|\%(\%(no\>\)\?\<append_create\>\)\|\%(\%(no\>\)\?\<appendhistory\>\)\|\%(\%(no\>\)\?\<append_history\>\)\|\%(\%(no\>\)\?\<autocd\>\)\|\%(\%(no\>\)\?\<auto_cd\>\)\|\%(\%(no\>\)\?\<autocontinue\>\)\|\%(\%(no\>\)\?\<auto_continue\>\)\|\%(\%(no\>\)\?\<autolist\>\)\|\%(\%(no\>\)\?\<auto_list\>\)\|\%(\%(no\>\)\?\<automenu\>\)\|\%(\%(no\>\)\?\<auto_menu\>\)\|\%(\%(no\>\)\?\<autonamedirs\>\)\|\%(\%(no\>\)\?\<auto_name_dirs\>\)\|\%(\%(no\>\)\?\<autoparamkeys\>\)\|\%(\%(no\>\)\?\<auto_param_keys\>\)\|\%(\%(no\>\)\?\<autoparamslash\>\)\|\%(\%(no\>\)\?\<auto_param_slash\>\)\|\%(\%(no\>\)\?\<autopushd\>\)\|\%(\%(no\>\)\?\<auto_pushd\>\)\|\%(\%(no\>\)\?\<autoremoveslash\>\)\|\%(\%(no\>\)\?\<auto_remove_slash\>\)\|\%(\%(no\>\)\?\<autoresume\>\)\|\%(\%(no\>\)\?\<auto_resume\>\)\|\%(\%(no\>\)\?\<badpattern\>\)\|\%(\%(no\>\)\?\<bad_pattern\>\)\|\%(\%(no\>\)\?\<banghist\>\)\|\%(\%(no\>\)\?\<bang_hist\>\)\|\%(\%(no\>\)\?\<bareglobqual\>\)\|\%(\%(no\>\)\?\<bare_glob_qual\>\)\|\%(\%(no\>\)\?\<bashautolist\>\)\|\%(\%(no\>\)\?\<bash_auto_list\>\)\|\%(\%(no\>\)\?\<bashrematch\>\)\|\%(\%(no\>\)\?\<bash_rematch\>\)\|\%(\%(no\>\)\?\<beep\>\)\|\%(\%(no\>\)\?\<bgnice\>\)\|\%(\%(no\>\)\?\<bg_nice\>\)\|\%(\%(no\>\)\?\<braceccl\>\)\|\%(\%(no\>\)\?\<brace_ccl\>\)\|\%(\%(no\>\)\?\<braceexpand\>\)\|\%(\%(no\>\)\?\<brace_expand\>\)\|\%(\%(no\>\)\?\<bsdecho\>\)\|\%(\%(no\>\)\?\<bsd_echo\>\)\|\%(\%(no\>\)\?\<caseglob\>\)\|\%(\%(no\>\)\?\<case_glob\>\)\|\%(\%(no\>\)\?\<casematch\>\)\|\%(\%(no\>\)\?\<case_match\>\)\|\%(\%(no\>\)\?\<cbases\>\)\|\%(\%(no\>\)\?\<c_bases\>\)\|\%(\%(no\>\)\?\<cdablevars\>\)\|\%(\%(no\>\)\?\<cdable_vars\>\)\|\%(\%(no\>\)\?\<cd_able_vars\>\)\|\%(\%(no\>\)\?\<chasedots\>\)\|\%(\%(no\>\)\?\<chase_dots\>\)\|\%(\%(no\>\)\?\<chaselinks\>\)\|\%(\%(no\>\)\?\<chase_links\>\)\|\%(\%(no\>\)\?\<checkjobs\>\)\|\%(\%(no\>\)\?\<check_jobs\>\)\|\%(\%(no\>\)\?\<clobber\>\)\|\%(\%(no\>\)\?\<combiningchars\>\)\|\%(\%(no\>\)\?\<combining_chars\>\)\|\%(\%(no\>\)\?\<completealiases\>\)\|\%(\%(no\>\)\?\<complete_aliases\>\)\|\%(\%(no\>\)\?\<completeinword\>\)\|\%(\%(no\>\)\?\<complete_in_word\>\)\|\%(\%(no\>\)\?\<continueonerror\>\)\|\%(\%(no\>\)\?\<continue_on_error\>\)\|\%(\%(no\>\)\?\<correct\>\)\|\%(\%(no\>\)\?\<correctall\>\)\|\%(\%(no\>\)\?\<correct_all\>\)\|\%(\%(no\>\)\?\<cprecedences\>\)\|\%(\%(no\>\)\?\<c_precedences\>\)\|\%(\%(no\>\)\?\<cshjunkiehistory\>\)\|\%(\%(no\>\)\?\<csh_junkie_history\>\)\|\%(\%(no\>\)\?\<cshjunkieloops\>\)\|\%(\%(no\>\)\?\<csh_junkie_loops\>\)\|\%(\%(no\>\)\?\<cshjunkiequotes\>\)\|\%(\%(no\>\)\?\<csh_junkie_quotes\>\)\|\%(\%(no\>\)\?\<csh_nullcmd\>\)\|\%(\%(no\>\)\?\<csh_null_cmd\>\)\|\%(\%(no\>\)\?\<cshnullcmd\>\)\|\%(\%(no\>\)\?\<csh_null_cmd\>\)\|\%(\%(no\>\)\?\<cshnullglob\>\)\|\%(\%(no\>\)\?\<csh_null_glob\>\)\|\%(\%(no\>\)\?\<debugbeforecmd\>\)\|\%(\%(no\>\)\?\<debug_before_cmd\>\)\|\%(\%(no\>\)\?\<dotglob\>\)\|\%(\%(no\>\)\?\<dot_glob\>\)\|\%(\%(no\>\)\?\<dvorak\>\)\|\%(\%(no\>\)\?\<emacs\>\)\|\%(\%(no\>\)\?\<equals\>\)\|\%(\%(no\>\)\?\<errexit\>\)\|\%(\%(no\>\)\?\<err_exit\>\)\|\%(\%(no\>\)\?\<errreturn\>\)\|\%(\%(no\>\)\?\<err_return\>\)\|\%(\%(no\>\)\?\<evallineno\>\)\|\%(\%(no\>\)\?\<eval_lineno\>\)\|\%(\%(no\>\)\?\<exec\>\)\|\%(\%(no\>\)\?\<extendedglob\>\)\|\%(\%(no\>\)\?\<extended_glob\>\)\|\%(\%(no\>\)\?\<extendedhistory\>\)\|\%(\%(no\>\)\?\<extended_history\>\)\|\%(\%(no\>\)\?\<flowcontrol\>\)\|\%(\%(no\>\)\?\<flow_control\>\)\|\%(\%(no\>\)\?\<forcefloat\>\)\|\%(\%(no\>\)\?\<force_float\>\)\|\%(\%(no\>\)\?\<functionargzero\>\)\|\%(\%(no\>\)\?\<function_argzero\>\)\|\%(\%(no\>\)\?\<function_arg_zero\>\)\|\%(\%(no\>\)\?\<glob\>\)\|\%(\%(no\>\)\?\<globalexport\>\)\|\%(\%(no\>\)\?\<global_export\>\)\|\%(\%(no\>\)\?\<globalrcs\>\)\|\%(\%(no\>\)\?\<global_rcs\>\)\|\%(\%(no\>\)\?\<globassign\>\)\|\%(\%(no\>\)\?\<glob_assign\>\)\|\%(\%(no\>\)\?\<globcomplete\>\)\|\%(\%(no\>\)\?\<glob_complete\>\)\|\%(\%(no\>\)\?\<globdots\>\)\|\%(\%(no\>\)\?\<glob_dots\>\)\|\%(\%(no\>\)\?\<glob_subst\>\)\|\%(\%(no\>\)\?\<globsubst\>\)\|\%(\%(no\>\)\?\<globstarshort\>\)\|\%(\%(no\>\)\?\<glob_star_short\>\)\|\%(\%(no\>\)\?\<hashall\>\)\|\%(\%(no\>\)\?\<hash_all\>\)\|\%(\%(no\>\)\?\<hashcmds\>\)\|\%(\%(no\>\)\?\<hash_cmds\>\)\|\%(\%(no\>\)\?\<hashdirs\>\)\|\%(\%(no\>\)\?\<hash_dirs\>\)\|\%(\%(no\>\)\?\<hashexecutablesonly\>\)\|\%(\%(no\>\)\?\<hash_executables_only\>\)\|\%(\%(no\>\)\?\<hashlistall\>\)\|\%(\%(no\>\)\?\<hash_list_all\>\)\|\%(\%(no\>\)\?\<histallowclobber\>\)\|\%(\%(no\>\)\?\<hist_allow_clobber\>\)\|\%(\%(no\>\)\?\<histappend\>\)\|\%(\%(no\>\)\?\<hist_append\>\)\|\%(\%(no\>\)\?\<histbeep\>\)\|\%(\%(no\>\)\?\<hist_beep\>\)\|\%(\%(no\>\)\?\<hist_expand\>\)\|\%(\%(no\>\)\?\<hist_expire_dups_first\>\)\|\%(\%(no\>\)\?\<histexpand\>\)\|\%(\%(no\>\)\?\<histexpiredupsfirst\>\)\|\%(\%(no\>\)\?\<histfcntllock\>\)\|\%(\%(no\>\)\?\<hist_fcntl_lock\>\)\|\%(\%(no\>\)\?\<histfindnodups\>\)\|\%(\%(no\>\)\?\<hist_find_no_dups\>\)\|\%(\%(no\>\)\?\<histignorealldups\>\)\|\%(\%(no\>\)\?\<hist_ignore_all_dups\>\)\|\%(\%(no\>\)\?\<histignoredups\>\)\|\%(\%(no\>\)\?\<hist_ignore_dups\>\)\|\%(\%(no\>\)\?\<histignorespace\>\)\|\%(\%(no\>\)\?\<hist_ignore_space\>\)\|\%(\%(no\>\)\?\<histlexwords\>\)\|\%(\%(no\>\)\?\<hist_lex_words\>\)\|\%(\%(no\>\)\?\<histnofunctions\>\)\|\%(\%(no\>\)\?\<hist_no_functions\>\)\|\%(\%(no\>\)\?\<histnostore\>\)\|\%(\%(no\>\)\?\<hist_no_store\>\)\|\%(\%(no\>\)\?\<histreduceblanks\>\)\|\%(\%(no\>\)\?\<hist_reduce_blanks\>\)\|\%(\%(no\>\)\?\<histsavebycopy\>\)\|\%(\%(no\>\)\?\<hist_save_by_copy\>\)\|\%(\%(no\>\)\?\<histsavenodups\>\)\|\%(\%(no\>\)\?\<hist_save_no_dups\>\)\|\%(\%(no\>\)\?\<histsubstpattern\>\)\|\%(\%(no\>\)\?\<hist_subst_pattern\>\)\|\%(\%(no\>\)\?\<histverify\>\)\|\%(\%(no\>\)\?\<hist_verify\>\)\|\%(\%(no\>\)\?\<hup\>\)\|\%(\%(no\>\)\?\<ignorebraces\>\)\|\%(\%(no\>\)\?\<ignore_braces\>\)\|\%(\%(no\>\)\?\<ignoreclosebraces\>\)\|\%(\%(no\>\)\?\<ignore_close_braces\>\)\|\%(\%(no\>\)\?\<ignoreeof\>\)\|\%(\%(no\>\)\?\<ignore_eof\>\)\|\%(\%(no\>\)\?\<incappendhistory\>\)\|\%(\%(no\>\)\?\<inc_append_history\>\)\|\%(\%(no\>\)\?\<incappendhistorytime\>\)\|\%(\%(no\>\)\?\<inc_append_history_time\>\)\|\%(\%(no\>\)\?\<interactive\>\)\|\%(\%(no\>\)\?\<interactivecomments\>\)\|\%(\%(no\>\)\?\<interactive_comments\>\)\|\%(\%(no\>\)\?\<ksharrays\>\)\|\%(\%(no\>\)\?\<ksh_arrays\>\)\|\%(\%(no\>\)\?\<kshautoload\>\)\|\%(\%(no\>\)\?\<ksh_autoload\>\)\|\%(\%(no\>\)\?\<kshglob\>\)\|\%(\%(no\>\)\?\<ksh_glob\>\)\|\%(\%(no\>\)\?\<kshoptionprint\>\)\|\%(\%(no\>\)\?\<ksh_option_print\>\)\|\%(\%(no\>\)\?\<kshtypeset\>\)\|\%(\%(no\>\)\?\<ksh_typeset\>\)\|\%(\%(no\>\)\?\<kshzerosubscript\>\)\|\%(\%(no\>\)\?\<ksh_zero_subscript\>\)\|\%(\%(no\>\)\?\<listambiguous\>\)\|\%(\%(no\>\)\?\<list_ambiguous\>\)\|\%(\%(no\>\)\?\<listbeep\>\)\|\%(\%(no\>\)\?\<list_beep\>\)\|\%(\%(no\>\)\?\<listpacked\>\)\|\%(\%(no\>\)\?\<list_packed\>\)\|\%(\%(no\>\)\?\<listrowsfirst\>\)\|\%(\%(no\>\)\?\<list_rows_first\>\)\|\%(\%(no\>\)\?\<listtypes\>\)\|\%(\%(no\>\)\?\<list_types\>\)\|\%(\%(no\>\)\?\<localloops\>\)\|\%(\%(no\>\)\?\<local_loops\>\)\|\%(\%(no\>\)\?\<localoptions\>\)\|\%(\%(no\>\)\?\<local_options\>\)\|\%(\%(no\>\)\?\<localpatterns\>\)\|\%(\%(no\>\)\?\<local_patterns\>\)\|\%(\%(no\>\)\?\<localtraps\>\)\|\%(\%(no\>\)\?\<local_traps\>\)\|\%(\%(no\>\)\?\<log\>\)\|\%(\%(no\>\)\?\<login\>\)\|\%(\%(no\>\)\?\<longlistjobs\>\)\|\%(\%(no\>\)\?\<long_list_jobs\>\)\|\%(\%(no\>\)\?\<magicequalsubst\>\)\|\%(\%(no\>\)\?\<magic_equal_subst\>\)\|\%(\%(no\>\)\?\<mailwarn\>\)\|\%(\%(no\>\)\?\<mail_warn\>\)\|\%(\%(no\>\)\?\<mail_warning\>\)\|\%(\%(no\>\)\?\<mark_dirs\>\)\|\%(\%(no\>\)\?\<mailwarning\>\)\|\%(\%(no\>\)\?\<markdirs\>\)\|\%(\%(no\>\)\?\<menucomplete\>\)\|\%(\%(no\>\)\?\<menu_complete\>\)\|\%(\%(no\>\)\?\<monitor\>\)\|\%(\%(no\>\)\?\<multibyte\>\)\|\%(\%(no\>\)\?\<multi_byte\>\)\|\%(\%(no\>\)\?\<multifuncdef\>\)\|\%(\%(no\>\)\?\<multi_func_def\>\)\|\%(\%(no\>\)\?\<multios\>\)\|\%(\%(no\>\)\?\<multi_os\>\)\|\%(\%(no\>\)\?\<nomatch\>\)\|\%(\%(no\>\)\?\<no_match\>\)\|\%(\%(no\>\)\?\<notify\>\)\|\%(\%(no\>\)\?\<nullglob\>\)\|\%(\%(no\>\)\?\<null_glob\>\)\|\%(\%(no\>\)\?\<numericglobsort\>\)\|\%(\%(no\>\)\?\<numeric_glob_sort\>\)\|\%(\%(no\>\)\?\<octalzeroes\>\)\|\%(\%(no\>\)\?\<octal_zeroes\>\)\|\%(\%(no\>\)\?\<onecmd\>\)\|\%(\%(no\>\)\?\<one_cmd\>\)\|\%(\%(no\>\)\?\<overstrike\>\)\|\%(\%(no\>\)\?\<over_strike\>\)\|\%(\%(no\>\)\?\<pathdirs\>\)\|\%(\%(no\>\)\?\<path_dirs\>\)\|\%(\%(no\>\)\?\<pathscript\>\)\|\%(\%(no\>\)\?\<path_script\>\)\|\%(\%(no\>\)\?\<physical\>\)\|\%(\%(no\>\)\?\<pipefail\>\)\|\%(\%(no\>\)\?\<pipe_fail\>\)\|\%(\%(no\>\)\?\<posixaliases\>\)\|\%(\%(no\>\)\?\<posix_aliases\>\)\|\%(\%(no\>\)\?\<posixargzero\>\)\|\%(\%(no\>\)\?\<posix_arg_zero\>\)\|\%(\%(no\>\)\?\<posix_argzero\>\)\|\%(\%(no\>\)\?\<posixbuiltins\>\)\|\%(\%(no\>\)\?\<posix_builtins\>\)\|\%(\%(no\>\)\?\<posixcd\>\)\|\%(\%(no\>\)\?\<posix_cd\>\)\|\%(\%(no\>\)\?\<posixidentifiers\>\)\|\%(\%(no\>\)\?\<posix_identifiers\>\)\|\%(\%(no\>\)\?\<posixjobs\>\)\|\%(\%(no\>\)\?\<posix_jobs\>\)\|\%(\%(no\>\)\?\<posixstrings\>\)\|\%(\%(no\>\)\?\<posix_strings\>\)\|\%(\%(no\>\)\?\<posixtraps\>\)\|\%(\%(no\>\)\?\<posix_traps\>\)\|\%(\%(no\>\)\?\<printeightbit\>\)\|\%(\%(no\>\)\?\<print_eight_bit\>\)\|\%(\%(no\>\)\?\<printexitvalue\>\)\|\%(\%(no\>\)\?\<print_exit_value\>\)\|\%(\%(no\>\)\?\<privileged\>\)\|\%(\%(no\>\)\?\<promptbang\>\)\|\%(\%(no\>\)\?\<prompt_bang\>\)\|\%(\%(no\>\)\?\<promptcr\>\)\|\%(\%(no\>\)\?\<prompt_cr\>\)\|\%(\%(no\>\)\?\<promptpercent\>\)\|\%(\%(no\>\)\?\<prompt_percent\>\)\|\%(\%(no\>\)\?\<promptsp\>\)\|\%(\%(no\>\)\?\<prompt_sp\>\)\|\%(\%(no\>\)\?\<promptsubst\>\)\|\%(\%(no\>\)\?\<prompt_subst\>\)\|\%(\%(no\>\)\?\<promptvars\>\)\|\%(\%(no\>\)\?\<prompt_vars\>\)\|\%(\%(no\>\)\?\<pushdignoredups\>\)\|\%(\%(no\>\)\?\<pushd_ignore_dups\>\)\|\%(\%(no\>\)\?\<pushdminus\>\)\|\%(\%(no\>\)\?\<pushd_minus\>\)\|\%(\%(no\>\)\?\<pushdsilent\>\)\|\%(\%(no\>\)\?\<pushd_silent\>\)\|\%(\%(no\>\)\?\<pushdtohome\>\)\|\%(\%(no\>\)\?\<pushd_to_home\>\)\|\%(\%(no\>\)\?\<rcexpandparam\>\)\|\%(\%(no\>\)\?\<rc_expandparam\>\)\|\%(\%(no\>\)\?\<rc_expand_param\>\)\|\%(\%(no\>\)\?\<rcquotes\>\)\|\%(\%(no\>\)\?\<rc_quotes\>\)\|\%(\%(no\>\)\?\<rcs\>\)\|\%(\%(no\>\)\?\<recexact\>\)\|\%(\%(no\>\)\?\<rec_exact\>\)\|\%(\%(no\>\)\?\<rematchpcre\>\)\|\%(\%(no\>\)\?\<re_match_pcre\>\)\|\%(\%(no\>\)\?\<rematch_pcre\>\)\|\%(\%(no\>\)\?\<restricted\>\)\|\%(\%(no\>\)\?\<rmstarsilent\>\)\|\%(\%(no\>\)\?\<rm_star_silent\>\)\|\%(\%(no\>\)\?\<rmstarwait\>\)\|\%(\%(no\>\)\?\<rm_star_wait\>\)\|\%(\%(no\>\)\?\<sharehistory\>\)\|\%(\%(no\>\)\?\<share_history\>\)\|\%(\%(no\>\)\?\<shfileexpansion\>\)\|\%(\%(no\>\)\?\<sh_file_expansion\>\)\|\%(\%(no\>\)\?\<shglob\>\)\|\%(\%(no\>\)\?\<sh_glob\>\)\|\%(\%(no\>\)\?\<shinstdin\>\)\|\%(\%(no\>\)\?\<shin_stdin\>\)\|\%(\%(no\>\)\?\<shnullcmd\>\)\|\%(\%(no\>\)\?\<sh_nullcmd\>\)\|\%(\%(no\>\)\?\<shoptionletters\>\)\|\%(\%(no\>\)\?\<sh_option_letters\>\)\|\%(\%(no\>\)\?\<shortloops\>\)\|\%(\%(no\>\)\?\<short_loops\>\)\|\%(\%(no\>\)\?\<shwordsplit\>\)\|\%(\%(no\>\)\?\<sh_word_split\>\)\|\%(\%(no\>\)\?\<singlecommand\>\)\|\%(\%(no\>\)\?\<single_command\>\)\|\%(\%(no\>\)\?\<singlelinezle\>\)\|\%(\%(no\>\)\?\<single_line_zle\>\)\|\%(\%(no\>\)\?\<sourcetrace\>\)\|\%(\%(no\>\)\?\<source_trace\>\)\|\%(\%(no\>\)\?\<stdin\>\)\|\%(\%(no\>\)\?\<sunkeyboardhack\>\)\|\%(\%(no\>\)\?\<sun_keyboard_hack\>\)\|\%(\%(no\>\)\?\<trackall\>\)\|\%(\%(no\>\)\?\<track_all\>\)\|\%(\%(no\>\)\?\<transientrprompt\>\)\|\%(\%(no\>\)\?\<transient_rprompt\>\)\|\%(\%(no\>\)\?\<trapsasync\>\)\|\%(\%(no\>\)\?\<traps_async\>\)\|\%(\%(no\>\)\?\<typesetsilent\>\)\|\%(\%(no\>\)\?\<type_set_silent\>\)\|\%(\%(no\>\)\?\<typeset_silent\>\)\|\%(\%(no\>\)\?\<unset\>\)\|\%(\%(no\>\)\?\<verbose\>\)\|\%(\%(no\>\)\?\<vi\>\)\|\%(\%(no\>\)\?\<warncreateglobal\>\)\|\%(\%(no\>\)\?\<warn_create_global\>\)\|\%(\%(no\>\)\?\<xtrace\>\)\|\%(\%(no\>\)\?\<zle\>\)/ nextgroup=zshOption skipwhite contained

syn keyword zshTypes            float integer local typeset declare private

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
                                \ start='\$(' skip='\\)' end=')' contains=TOP fold
syn region  zshParentheses      transparent start='(' skip='\\)' end=')' fold
syn region  zshGlob             start='(#' end=')'
syn region  zshMathSubst        matchgroup=zshSubstDelim transparent
                                \ start='\$((' skip='\\)' end='))'
                                \ contains=zshParentheses,@zshSubst,zshNumber,
                                \ @zshDerefs,zshString keepend fold
syn region  zshBrackets         contained transparent start='{' skip='\\}'
                                \ end='}' fold
syn region  zshBrackets         transparent start='{' skip='\\}'
                                \ end='}' contains=TOP fold
syn region  zshSubst            matchgroup=zshSubstDelim start='\${' skip='\\}'
                                \ end='}' contains=@zshSubst,zshBrackets,zshQuoted,zshString fold
syn region  zshOldSubst         matchgroup=zshSubstDelim start=+`+ skip=+\\`+
                                \ end=+`+ contains=TOP,zshOldSubst fold

syn sync    minlines=50 maxlines=90
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
hi def link zshShortDeref       zshDereferencing
hi def link zshLongDeref        zshDereferencing
hi def link zshDeref            zshDereferencing
hi def link zshDollarVar        zshDereferencing
hi def link zshCommands         Keyword
hi def link zshOptStart         Keyword
hi def link zshOption           Constant
hi def link zshTypes            Type
hi def link zshSwitches         Special
hi def link zshNumber           Number
hi def link zshSubst            PreProc
hi def link zshMathSubst        zshSubst
hi def link zshOldSubst         zshSubst
hi def link zshSubstDelim       zshSubst
hi def link zshGlob             zshSubst

let b:current_syntax = "zsh"

let &cpo = s:cpo_save
unlet s:cpo_save
