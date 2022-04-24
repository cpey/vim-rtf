so $VIMRUNTIME/syntax/help.vim

" Syntax 
highlight rtfHiRed        ctermfg=204 guifg=#ff0000
highlight rtfHiRedBold    ctermfg=204 guifg=#ff0000 cterm=bold gui=bold
highlight rtfHiGreen      ctermfg=070 guifg=#ff0000
highlight rtfHiGreenBold  ctermfg=070 guifg=#ff0000 cterm=bold gui=bold
highlight rtfHiOrange     ctermfg=208 guifg=#ff0000
highlight rtfHiOrangeBold ctermfg=208 guifg=#ff0000 cterm=bold gui=bold
highlight rtfHiBlue       ctermfg=110 guifg=#ff0000
highlight rtfHiBlueBold   ctermfg=110 guifg=#ff0000 cterm=bold gui=bold
highlight rtfHighlight    ctermfg=142 guifg=#ff0000
highlight rtfHiBold       cterm=bold gui=bold
highlight rtfHiUnderline  cterm=underline gui=underline

" Different syntax highlighting within regions of a file
" Source: https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ keepend
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

call TextEnableCodeSnip('c', '```', '```', 'SpecialComment')
call TextEnableCodeSnip('cpp', '```cpp', '```', 'SpecialComment')
call TextEnableCodeSnip('diff', '```diff', '```', 'SpecialComment')
call TextEnableCodeSnip('python', '```pseudo', '```', 'SpecialComment')
call TextEnableCodeSnip('python', '```python', '```', 'SpecialComment')
call TextEnableCodeSnip('java', '```java', '```', 'SpecialComment')
call TextEnableCodeSnip('xml', '```xml', '```', 'SpecialComment')
call TextEnableCodeSnip('sh', '```sh', '```', 'SpecialComment')
call TextEnableCodeSnip('bash', '```bash', '```', 'SpecialComment')
call TextEnableCodeSnip('zsh', '```zsh', '```', 'SpecialComment')
call TextEnableCodeSnip('asm', '```asm', '```', 'SpecialComment')
call TextEnableCodeSnip('json', '```json', '```', 'SpecialComment')
call TextEnableCodeSnip('txt', '```figure', '```', 'SpecialComment')
call TextEnableCodeSnip('txt', '```txt', '```', 'SpecialComment')
call TextEnableCodeSnip('c', '^----------------*$', '^----------------* ', 'SpecialComment')
call TextEnableCodeSnip('c', '^----------------*$', '^----------------*', 'SpecialComment')
call TextEnableCodeSnip('c', '^----------------* [_\./a-zA-Z0-9][ _\./a-zA-Z0-9\-]*--------*$', '^----------------*', 'SpecialComment')

" Note regex plus symbol needs scaping in vim. See http://vimregex.com/.
" The latest rule has precedence

" Single line commands
syn match rtfHiBlue      "`[^`]\+`"
syn match rtfHiOrange    "`[^`;]\+`"
syn match rtfHiBlue      "` [^`]\+ `"
syn match rtfHighlight   "\*[a-zA-Z0-9\"“]* [^\*]*[a-zA-Z0-9\(\)\"”]\*"
syn match rtfHighlight   "\*[a-zA-Z0-9].*-.*[a-zA-Z0-9]\*"
syn match rtfHighlight   "\*[a-zA-Z0-9].*\*[,)]"
syn match rtfHiUnderline "^\*\+ [a-zA-Z0-9\'.: ->^/\[\]]*[\._a-zA-Z0-9\(\)?<>]\+$"
syn match rtfHiUnderline "^\*\+ [_a-zA-Z0-9\'.: ->^/\[\]]*[\._a-zA-Z0-9\(\)?]\+_ $"
syn match rtfHiUnderline "^\*\+ [_a-zA-Z0-9\'.: ->^/\[\]]*[\._a-zA-Z0-9\(\)?]\+ _$"
syn match rtfHiUnderline " _[a-zA-Z0-9 ]\+[ a-zA-Z0-9:\(\)]*_ $"
syn match rtfHiUnderline "^_[a-zA-Z0-9 ]\+[ a-zA-Z0-9:\(\)]*_$"
syn match rtfHiBold      "--\[ [a-zA-Z0-9\':\s-].*\s\+"
syn match rtfHiBold      "----\[ [a-zA-Z0-9\'.:\s-].*\s\+"

" Coloring lines using positive lookbehind
syn match rtfHiRed   "\(^!:\s\)\@<=.*$"
syn match rtfHiGreen "\(^+:\s\)\@<=.*$"

" Coloring lines using positive lookahead
" Match between "`"
syn match rtfHiRed          "`[^`]\+`\(.*<:r`\)\@="
syn match rtfHiGreen        "`[^`]\+`\(.*<:g`\)\@="
syn match rtfHiBlue         "`[^`]\+`\(.*<:b`\)\@="
syn match rtfHiOrange       "`[^`]\+`\(.*<:o`\)\@="
syn match rtfHiUnderline    "`[^`]\+`\(.*<:u`\)\@="
syn match rtfHiRedBold      "`[^`]\+`\(.*<:rb`\)\@="
syn match rtfHiGreenBold    "`[^`]\+`\(.*<:gb`\)\@="
syn match rtfHiBlueBold     "`[^`]\+`\(.*<:bb`\)\@="
syn match rtfHiOrangeBold   "`[^`]\+`\(.*<:ob`\)\@="

" whole line selectors
syn match rtfHiRed          "^.*\(\s*<:r$\)\@="
syn match rtfHiGreen        "^.*\(\s*<:g$\)\@="
syn match rtfHiBlue         "^.*\(\s*<:b$\)\@="
syn match rtfHiOrange       "^.*\(\s*<:o$\)\@="
syn match rtfHiBold         "^.*\(\s*<:wb$\)\@="
syn match rtfHiRedBold      "^.*\(\s*<:rb$\)\@="
syn match rtfHiGreenBold    "^.*\(\s*<:gb$\)\@="
syn match rtfHiBlueBold     "^.*\(\s*<:bb$\)\@="
syn match rtfHiOrangeBold   "^.*\(\s*<:ob$\)\@="
syn match rtfHiUnderline    "^.*\(\s*<:u$\)\@="

" Select number of words from the start
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{1}\(.*<:1g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{2}\(.*<:2g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{3}\(.*<:3g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{4}\(.*<:4g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{5}\(.*<:5g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{6}\(.*<:6g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{7}\(.*<:7g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{8}\(.*<:8g$\)\@="
syn match rtfHiGreen    "^\s*\([^ ]\+\s\+\)\{9}\(.*<:9g$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{1}\(.*<:1b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{2}\(.*<:2b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{3}\(.*<:3b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{4}\(.*<:4b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{5}\(.*<:5b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{6}\(.*<:6b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{7}\(.*<:7b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{8}\(.*<:8b$\)\@="
syn match rtfHiBlue     "^\s*\([^ ]\+\s\+\)\{9}\(.*<:9b$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{1}\(.*<:1o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{2}\(.*<:2o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{3}\(.*<:3o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{4}\(.*<:4o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{5}\(.*<:5o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{6}\(.*<:6o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{7}\(.*<:7o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{8}\(.*<:8o$\)\@="
syn match rtfHiOrange   "^\s*\([^ ]\+\s\+\)\{9}\(.*<:9o$\)\@="

" Select number of words from the end
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{1}\(\s*<:-1b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{2}\(\s*<:-2b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{3}\(\s*<:-3b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{4}\(\s*<:-4b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{5}\(\s*<:-5b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{6}\(\s*<:-6b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{7}\(\s*<:-7b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{8}\(\s*<:-8b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{9}\(\s*<:-9b$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{1}\(\s*<:-1o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{2}\(\s*<:-2o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{3}\(\s*<:-3o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{4}\(\s*<:-4o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{5}\(\s*<:-5o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{6}\(\s*<:-6o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{7}\(\s*<:-7o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{8}\(\s*<:-8o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\+\)\{1,}\)\@<=\([^ ]\+\s\)\{9}\(\s*<:-9o$\)\@="

" Select specific word forwards
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:1b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:2b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:3b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:4b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:5b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{6}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:6b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{7}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:7b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{8}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:8b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{9}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:9b.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:1o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:2o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:3o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:4o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:5o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{6}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:6o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{7}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:7o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{8}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:8o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{9}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{-}\s*<:9o.$\)\@="

" Select specific word backwards
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{1}\s*<:-1b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{2}\s*<:-2b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{3}\s*<:-3b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{4}\s*<:-4b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{5}\s*<:-5b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{6}\s*<:-6b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{7}\s*<:-7b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{8}\s*<:-8b.$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{9}\s*<:-9b.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{1}\s*<:-1o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{2}\s*<:-2o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{3}\s*<:-3o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{4}\s*<:-4o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{5}\s*<:-5o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{6}\s*<:-6o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{7}\s*<:-7o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{8}\s*<:-8o.$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{1}\(\([^ ]\+\s\)\{9}\s*<:-9o.$\)\@="

" Select number of words in from position till end forward
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:1b-$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:2b-$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:3b-$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:4b-$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:5b-$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{6}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:6b-$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:1o-$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:2o-$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:3o-$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:4o-$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:5o-$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{6}\)\@<=\([^ ]\+\s\)\{1,}\(\s*<:6o-$\)\@="

" Select number of words in from position till end backward
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{1}\s*<:-1b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{2}\s*<:-2b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{3}\s*<:-3b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{4}\s*<:-4b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{5}\s*<:-5b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{6}\s*<:-6b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{7}\s*<:-7b-$\)\@="
syn match rtfHiBlue     "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{8}\s*<:-8b-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{1}\s*<:-1o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{2}\s*<:-2o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{3}\s*<:-3o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{4}\s*<:-4o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{5}\s*<:-5o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{6}\s*<:-6o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{7}\s*<:-7o-$\)\@="
syn match rtfHiOrange   "\([^ ]\+\s\)\{1,}\(\([^ ]\+\s\)\{8}\s*<:-8o-$\)\@="

" Select words in range
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{2}\(.*<:12b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{3}\(.*<:13b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{4}\(.*<:14b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{5}\(.*<:15b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{3}\(.*<:23b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{4}\(.*<:24b$\)\@="
syn match rtfHiBlue     "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{5}\(.*<:25b$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{2}\(.*<:12o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{3}\(.*<:13o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{4}\(.*<:14o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{5}\(.*<:15o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{6}\(.*<:16o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{7}\(.*<:17o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{8}\(.*<:18o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{1}\)\@<=\([^ ]\+\s\)\{9}\(.*<:19o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{3}\(.*<:23o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{4}\(.*<:24o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{5}\(.*<:25o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{6}\(.*<:26o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{7}\(.*<:27o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{8}\(.*<:28o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{2}\)\@<=\([^ ]\+\s\)\{9}\(.*<:29o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{2}\(.*<:32o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{3}\(.*<:33o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{4}\(.*<:34o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{5}\(.*<:35o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{6}\(.*<:36o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{7}\(.*<:37o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{8}\(.*<:38o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{3}\)\@<=\([^ ]\+\s\)\{9}\(.*<:39o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{5}\(.*<:45o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{6}\(.*<:46o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{7}\(.*<:47o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{8}\(.*<:48o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{4}\)\@<=\([^ ]\+\s\)\{9}\(.*<:49o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{2}\(.*<:52o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{3}\(.*<:53o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{4}\(.*<:54o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{5}\(.*<:55o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{6}\(.*<:56o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{7}\(.*<:57o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{8}\(.*<:58o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{5}\)\@<=\([^ ]\+\s\)\{9}\(.*<:59o$\)\@="

" Select words in range backwards
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{2}\(\(\([^ ]\+\s\)\{1}\)\s*<:-12o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{3}\(\(\([^ ]\+\s\)\{1}\)\s*<:-13o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{4}\(\(\([^ ]\+\s\)\{1}\)\s*<:-14o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{5}\(\(\([^ ]\+\s\)\{1}\)\s*<:-15o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{6}\(\(\([^ ]\+\s\)\{1}\)\s*<:-16o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{7}\(\(\([^ ]\+\s\)\{1}\)\s*<:-17o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{8}\(\(\([^ ]\+\s\)\{1}\)\s*<:-18o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{9}\(\(\([^ ]\+\s\)\{1}\)\s*<:-19o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{3}\(\(\([^ ]\+\s\)\{2}\)\s*<:-23o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{4}\(\(\([^ ]\+\s\)\{2}\)\s*<:-24o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{5}\(\(\([^ ]\+\s\)\{2}\)\s*<:-25o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{6}\(\(\([^ ]\+\s\)\{2}\)\s*<:-26o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{7}\(\(\([^ ]\+\s\)\{2}\)\s*<:-27o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{8}\(\(\([^ ]\+\s\)\{2}\)\s*<:-28o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{9}\(\(\([^ ]\+\s\)\{2}\)\s*<:-29o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{4}\(\(\([^ ]\+\s\)\{3}\)\s*<:-34o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{5}\(\(\([^ ]\+\s\)\{3}\)\s*<:-35o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{6}\(\(\([^ ]\+\s\)\{3}\)\s*<:-36o$\)\@="
syn match rtfHiOrange   "\(^\s*\([^ ]\+\s\)\{-}\)\@<=\([^ ]\+\s\)\{7}\(\(\([^ ]\+\s\)\{3}\)\s*<:-37o$\)\@="

