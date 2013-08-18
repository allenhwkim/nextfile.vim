" nextfile.vim - open next file with <leader>\n
" Maintainer:  Allen Kim <bighostkim@gmail.com>
" License: MIT license
" Version:      0.1
"
" Install in ~/.vim/plugin/nextfile.vim
"
" TODO: add help
" TODO: example for file types (ruby, js)

" 
" Do not load this plugin if is has already been loaded.
"
if exists("g:loadedNextFile")
  finish
endif
let g:loadedNextFile = 0.1 " version number
let g:nextFiles = {}

"
" map keyboard
"
imap <Leader>n <ESC>:call OpenNextFile()<CR>
nmap <Leader>n <ESC>:call OpenNextFile()<CR>

" Function : OpenNextFile (PUBLIC)
" Purpose  : Opens the corresponding file by checking the current file path 
"            E.g. foo.c -> foo_test.c
" Args     : none
" Returns  : none
" Description : 
"  . Get the current file name
"  . Get the related file
"  . If the current file is saved,
"       .1 open it in the current window
"     If not,
"       .2 open it in a split window
function! OpenNextFile() 
  let currentFile = expand("%:p")
  let nextFile = GetNextFile(currentFile)
  let isModified = getbufvar(1, "&mod")
  if (nextFile != "")
    let command = isModified ? ":split " : ":e "
    silent! execute command.nextFile
  else
    echo "Could not open next file because no pattern is found."
  endif
endfunction

" ------------------------------------------------------------------------------
" Function : AddNextFile (PUBLIC)
" Purpose  : Add file regular expression for an next file
"            E.g. /(\/path)\/lib\/(.*).c -> /\/\1\/test\/\2_test.c
"            E.g. /(\/path)\/test\/(.*)_test.c -> /\/\1\/lib\/\2.c
" Args     : Curent file matching regular expression
"            Next file regular expression
" Returns  : none
function! AddNextFile(currentFileRegex, nextFileRegex, currentFileExample, nextFileExample)
  let result = substitute(a:currentFileExample, a:currentFileRegex, a:nextFileRegex, "g")
  if (result == a:nextFileExample) " check if the expressin matches to example
    let g:nextFiles[a:currentFileRegex] = a:nextFileRegex 
  else
    echoerr "AddNextFile expectation not met with examples. Expected ".a:nextFileExample." but was ".result
  end
endfunction

" ------------------------------------------------------------------------------
" Function : GetNextFile (PRIVATE)
" Purpose  : Get a file to open from the current file
" Args     : Current file name
" Returns  : File to open
function! GetNextFile(currentFilePath)
  let nextFile = ""
  for [regex, nextFileRegex] in items(g:nextFiles)
    let idx = match(a:currentFilePath, regex)
    if (idx >= 0)
      let nextFile = substitute(a:currentFilePath, regex, nextFileRegex, "g")
      break
    end
  endfor
  return nextFile
endfunction

