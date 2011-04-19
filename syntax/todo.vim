syntax region todoTodo start=/^.*TODO/ end=/$/
hi def todoTodoDefinition guifg=Green
hi link todoTodo todoTodoDefinition

syntax region todoFIXME start=/^.*FIXME/ end=/$/
hi def todoFixmeDefinition gui=italic guifg=Orange
hi link todoFIXME todoFixmeDefinition
