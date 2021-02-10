"-- AUTOCLOSE --
"autoclose and position cursor after
inoremap '<tab> ''<left>
inoremap `<tab> ``<left>
inoremap "<tab> ""<left>
inoremap (<tab> ()<left>
inoremap [<tab> []<left>
inoremap {<tab> {}<left>
"autoclose with ; and position cursor after
inoremap ';<tab> '';<left><left>
inoremap `;<tab> ``;<left><left>
inoremap ";<tab> "";<left><left>
inoremap (;<tab> ();<left><left>
inoremap [;<tab> [];<left><left>
inoremap {;<tab> {};<left><left>
"autoclose with , and position cursor after
inoremap ',<tab> '',<left><left>
inoremap `,<tab> ``,<left><left>
inoremap ",<tab> "",<left><left>
inoremap (,<tab> (),<left><left>
inoremap [,<tab> [],<left><left>
inoremap {,<tab> {},<left><left>
"autoclose 2 lines below and position cursor in the middle
inoremap '<CR> '<CR>'<ESC>O
inoremap `<CR> `<CR>`<ESC>O
inoremap "<CR> "<CR>"<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap {<CR> {<CR>}<ESC>O
"autoclose 2 lines below adding ; and position cursor in the middle
inoremap ';<CR> '<CR>';<ESC>O
inoremap `;<CR> `<CR>`;<ESC>O
inoremap ";<CR> "<CR>";<ESC>O
inoremap (;<CR> (<CR>);<ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
"autoclose 2 lines below adding , and position cursor in the middle
inoremap ',<CR> '<CR>',<ESC>O
inoremap `,<CR> `<CR>`,<ESC>O
inoremap ",<CR> "<CR>",<ESC>O
inoremap (,<CR> (<CR>),<ESC>O
inoremap [,<CR> [<CR>],<ESC>O
inoremap {,<CR> {<CR>},<ESC>O


