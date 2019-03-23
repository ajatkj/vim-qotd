" =============================================================================
" Filename: qotd.vim
" Author: Ankit Jain <ajatkj@yahoo.co.in>
" Desc: Returns Quote Of The Day
" Last Change: 2018/12/05
" Desc: Generate quote of the day randomly
" Dependency: helper.vim
" Returns: string - quote of the day. spaces in case of errors
" TODO: quote based on categories ex. funny, love, sad, motivational etc.
" =============================================================================
"
function! qotd#getquoteoftheday(...)
   let spaces=' '
   let command=0
   let s:tinyquote='funny tiny quote'
   let s:smallquote='funny small window quote'
   if a:0 == 1
      if a:1 == 0 " function called from QOTD command
         let command=1
      endif
   endif
   " load and check if helper#randomize function exists, else return
   if !exists('*helper#randomize')
      return spaces
   endif
   " if g:qotd_quoteoftheday variable is not set, default to yes
   if !exists('g:qotd_quoteoftheday')
      let g:qotd_quoteoftheday=1
   endif
   try
      let allquotes=g:qotd#quotes#allquotes
   catch
      return spaces
   endtry
   " if quote of the day is disabled
   if g:qotd_quoteoftheday == 0
      return spaces
   endif
   let width=winwidth(0)
   if command == 0
      " tiny quote
      if width <= 65
         return s:tinyquote
      " small quote
      elseif width > 65 && width <= 100
         return s:smallquote
      endif
   endif
   " if quote already loaded for this window, use the existing quote
   if exists('g:quote') && command == 0
      return g:quote
   else
      let maxq=len(allquotes)
      let quoteno=helper#randomize(maxq)
      let s:quote=(allquotes[quoteno : quoteno])[0]
      if command == 0 
         let g:quote = s:quote
         return g:quote
      else
         " return new qotd everytime for QOTD command
         echo s:quote
      endif
   endif
endfunction
