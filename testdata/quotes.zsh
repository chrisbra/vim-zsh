# Test quoting.

 'single'   'var: $var'   'subst: $(ls)'   'esc: \n \x01 \001'
 "double"   "var: $var"   "subst: $(ls)"   "esc: \n \x01 \001" # TODO: these last 2 are not highlighted
$'single'  $'var: $var'  $'subst: $(ls)'  $'esc: \n \x01 \001'
 `batick`   `var: $var`   `subst: $(ls)`   `esc: \n \x01 \001`

"'nest'" "`nest`"
'"nest"' '`nest`'

 "escape: \" \' \` \\ escape"
 'escape: \" \' \` \\ escape'  # TODO: maybe highlight \' as an error?
$'escape: \" \' \` \\ escape'
