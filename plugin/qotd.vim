" =============================================================================
" Filename: plugin/qotd.vim
" Author: Ankit Jain <ajatkj@yahoo.co.in>
" Desc: Returns Quote Of The Day
" Last Change: 2018/12/05
" Dependency: none
" Changes:
" =============================================================================
if exists('g:loaded_qotd') || v:version < 702
   finish
endif

let g:loaded_qotd = 1

try
   call helper#init()
catch
   echom '"qotd.vim" helper.vim required, not loading qotd'
   call feedkeys(" ")
   finish
endtry

let s:save_cpo = &cpo
set cpo&vim

command! QOTD :call qotd#getquoteoftheday(0)

let &cpo = s:save_cpo
unlet s:save_cpo

