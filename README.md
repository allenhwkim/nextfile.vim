nextfile.vim
===============

Vim script to open next file with `\n`, <leader>n
You can switch between a class and the class test, and a model and model test, etc

You also can set next file more than two files. In example,

    foo.js --> foo_test.js --> foo_controller.js 
     ^                                  |
     |                                  v
    foo_helper.js <-- foo_controller_test.js
 

How it works
------------

* When initialized, set related file patterns by file type
  Please refer to the installation instruction

* In vim window, when <leader>n is pressed
    * Get the current file name
    * Get the related file
    * If the current file is modified,
        * open it in a split window
    * If not modified,
        * open it in the current window

Installation
------------

* downlaod nextfile.vim and save it into ~/.vim/plugin
* Add next file mapping to your .vimrc
  This will allow you to switch between files
  AddNextFile function accepts four parameters. 
  The first two are file matching patterns and last two are 
  examples to verify the file matching patterns.
    1. current file matching pattern
    2. next file matching file using backreference
    3. example of current file path
    4. example of next file path
    
  For NodeJS developers, add the following into ~/.vimrc
  This will allow you to switch between a class and the test related

    <pre>
    autocmd FileType javascript call AddJsNextFiles()
    function! AddJsNextFiles()
      let g:nextFiles = {}
      call AddNextFile("\\(\/.*\\)\/lib\/\\(.*\\).js", "\\1\/test\/unit\/\\2_test.js", 
           \ "/home/me/myproject/lib/foo.js", "/home/me/myproject/test/unit/foo_test.js")
      call AddNextFile("\\(\/.*\\)\/test\/unit\/\\(.*\\)_test.js", "\\1\/lib\/\\2.js",
           \ "/home/me/myproject/test/unit/foo_test.js", "/home/me/myproject/lib/foo.js")
    endfunction
    </pre>

  For Rails developers, add the following into ~/.vimrc
  This will allow you to switch between a model and test, and a controller and test
  
    <pre>
    autocmd FileType ruby,erb call AddRubyNextFiles()
    function! AddRubyNextFiles()
    let g:nextFiles = {}
    call AddNextFile("\\(\/.*\\)\/app\/models\/\\(.*\\).rb", "\\1\/test\/unit\/\\2_test.rb",
        \ "/home/me/myproject/app/models/foo.rb", "/home/me/myproject/test/unit/foo_test.rb")
    call AddNextFile("\\(\/.*\\)\/test\/unit\/\\(.*\\)_test.rb", "\\1\/app\/models\/\\2.rb", 
        \ "/home/me/myproject/test/unit/foo_test.rb", "/home/me/myproject/app/models/foo.rb")
    call AddNextFile("\\(\/.*\\)\/app\/controllers\/\\(.*\\).rb", "\\1\/test\/functional\/\\2_test.rb",
        \ "/home/me/myproject/app/controllers/foos_controller.rb", "/home/me/myproject/test/functional/foos_controller_test.rb")
    call AddNextFile("\\(\/.*\\)\/test\/functional\/\\(.*\\)_test.rb", "\\1\/app\/controllers\/\\2.rb",
        \ "/home/me/myproject/test/functional/foos_controller_test.rb", "/home/me/myproject/app/controllers/foos_controller.rb")
    endfunction
    </pre>
