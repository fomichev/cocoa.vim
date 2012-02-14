" File: objc_cocoa_mappings.vim
" Author: Michael Sanders (msanders42 [at] gmail [dot] com)
" Description: Sets up mappings for cocoa.vim.
" Last Updated: December 26, 2009

" use custom man
nn <buffer> <silent> K :<c-u>call objc#man#ShowDoc()<cr>

" use xcodebuild as make program
setlocal makeprg=xcodebuild\ -sdk\ iphonesimulator5.0

" some Xcode binrings

nn <buffer> <d-b> :make<cr>
nn <buffer> <d-K> :make clean<cr>
