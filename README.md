nextfiles.vim
=============

Vim script to open related files by command, or by keymap(i.e. \n or any)

How it works
------------

* When initialized, set related files
* In vim window, when <leader>n is pressed

  * Get the current file name
  * Get the related files
  * Browse the related files and open in current, splitted, or vertically splitted window

Installation
------------

* Download the following files into ~/.vim/plugin directory 
  * nextfiles.vim
  * singular_expressions.txt
  * plural_expressions.txt

* To your ~/.vimrc, add a keyboard map to call NextFiles() function

<pre>
    imap &lt;Leader>n &lt;ESC>:call NextFiles()&lt;CR>
    nmap &lt;Leader>n &lt;ESC>:call NextFiles()&l6;CR>
</pre>

* For Rails developers, there is pre-defined mapping like the following. You may want to change this. If so, you can re-define this in your .vimrc

<pre>
    let g:nextFilesMap["Ruby On Rails"] = {
      \ "Ruby On Rails" : {
        \ "Controller" : { "expression" : "app/controllers/(.*)_controller.rb$", "transform" : "pluralize" },
        \ "Funtional Test" : { "expression" : "test/functional/(.*)_controller_test.rb$", "transform" : "pluralize" },
        \ "View" : { "expression" : "app/view/(.*)/", "transform" : "pluralize" },
        \ "Model" : { "expression" : "app/models/(.*).rb$", "transform" : "singularize" },
        \ "Unit Test" : { "expression" : "test/unit/(.*)_test.rb$", "transform" : "singularize" }
      \ }
    \ }
</pre>
