" Do NOT initiate LSC when doing short-lived diffs.
if &diff
    finish
endif

let g:lsc_server_commands = {
 \  'javascript': {
 \    'command': 'typescript-language-server --stdio',
 \    'log_level': -1,
 \    'suppress_stderr': v:true,
 \  },
 \  'javascriptreact': {
 \    'command': 'typescript-language-server --stdio',
 \    'log_level': -1,
 \    'suppress_stderr': v:true,
 \  }
 \}
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': v:true,
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}

let g:lsc_enable_autocomplete    = v:true
let g:lsc_enable_diagnostics     = v:false
let g:lsc_reference_highlights   = v:false
let g:lsc_enable_snippet_support = v:true
