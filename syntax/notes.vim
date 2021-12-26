"     What: notes.vim
" Language: notes
"   Author: Magnus Woldrich <m@japh.se>
"     Date: 2021-11-05

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn match  notesdone        /DONE/
syn match  notesinprogress  /INPROGRESS/
syn match  notesnotes        /notes/
syn match  notessomewhat    /SOMEWHAT/
syn match  notesnote        /NOTE/
syn match  notesremember    /REMEMBER/
syn match  notesdate        /\(Mon\|Tue\|Wed\|Thu\|Fri\|Sat\|Sun\)\s\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) \d\{2}/
syn match  notestime        /\d\{2}:\d\{2}:\d\{2} .\{3,} \d\{4}/
syn region done            start=/\*\*DONE/ end=/\*\*/
syn region inprogress      start=/\*\*INPROGRESS/ end=/\*\*/
syn region mattnotes       start=/\*\*notes/ end=/\*\*/
syn region majorpoint      start=/==>/ end=/<==/me=s-3 contains=ALL
syn match  minorpoint      /--/
syn match  minipoint       /---/
syn match  notesbullet      /·/
syntax match notesURL       /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
syn region notesmodified    start=/Modified:/ end=/$/


" dim finished tasks
" %3>l  = match after 3rd line
"syn match notesLevel1 /\v\s*·?\s*\zs.*\zeDONE/ contains=notesdone
"hi notesLevel1 ctermfg=238 cterm=italicbold

syn match notesLevel2 /%3>l.*\zeNOTE/ contains=notesnote
hi notesLevel2  cterm=bold


sy region dash1 matchgroup=dash1 start=/\---/ end=/\v\n/ contains=dash2 keepend
sy region dash2 matchgroup=dash2 start=/\---/ end=/\v\n/ contains=dash3 keepend
sy region dash3 matchgroup=dash3 start=/\---/ end=/\v\n/ contains=dash1 contained keepend

syn match notesKlar          /KLAR:/
syn match notesversionnumber /\v[|]\s*\zs\d+[.]\d+[.]\d+([.]\d+)?/

syn match notesComment 	 			 		 /\v^\s*\zs#.*\ze/ contains=notesCommentArendeID,notesCommentArendeBeskr,notesKlar,notesversionnumber
syn match notesCommentArendeID 		 /\v^#\s+\zs[0-9]+\ze/ contained
syn match notesPerlModule   	 	  /\v([a-z]+::)/
syn match notesShellCmd        	  /\v^(#\s+)?\$\s+\zs.+/
syn match notesUC							 	  /\v([A-Z]){2,} /

syn region String                  start=/\v["']/  skip=+\\"+  end=/\v["']/ contained
syn match  notesStringStartEnd     /['"`]/ contains=String

hi notesKlar ctermfg=070 cterm=bold
hi notesversionnumber ctermfg=220
hi notesStringStartEnd cterm=bold ctermfg=166
hi dash1 ctermfg=240
hi dash2 ctermfg=244
hi dash3 ctermfg=248

hi notesremember ctermfg=197 ctermbg=53 cterm=boldunderlinereverse


if !exists("did_notes_syntax_inits")
  let did_notes_syntax_inits = 1

  hi link notesdone tDone
    hi link done tDone
    hi default tDone ctermfg=34 cterm=bold

  hi link notessomewhat tSomewhat
    hi link somewhat tSomewhat
    hi default tSomewhat ctermfg=208

  hi link notesinprogress tProgress
    hi link inprogress tProgress
    hi default tProgress ctermfg=226

  hi link notesnotes tnotes
    hi link mattnotes tnotes
    hi default tnotes ctermfg=160 ctermbg=233 cterm=bold

  hi link majorpoint tMajor
    hi default tMajor ctermfg=197 cterm=bold

  hi link notesnote tnotesnote
    hi default tnotesnote ctermfg=197 cterm=bold

  hi link minorpoint tMinor
   hi default tMinor ctermfg=29 cterm=bold

  hi link minipoint tMini
    hi default tMini ctermfg=154 cterm=bold

  hi link notesdate tDate
  hi link notesmodified tDate
  hi default tDate ctermfg=245 ctermbg=233 cterm=bold

  hi link notestime tTime
  hi link notesmodified tTime
  hi default tTime ctermfg=238 cterm=bold

  hi Normal ctermfg=255

  hi notesURL ctermfg=39 cterm=none

  hi notesbullet          ctermfg=160 cterm=bold
	hi notesUC 		          ctermfg=37  cterm=bold
  hi notesCommentBlock    ctermfg=240 cterm=italic
  hi notesCommentTitle    ctermfg=208 cterm=bolditalic
  hi link notesComment    Comment
	hi link notesNumber     Number
	hi notesCommentArendeID cterm=bold ctermfg=197
	hi notesShellCmd        ctermfg=112 cterm=bolditalic
endif

hi Normal ctermfg=252
let b:current_syntax="notes"
