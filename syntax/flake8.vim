if exists("b:current_syntax")
  finish
endif

syntax match flake8Number "\v<\d+>"
syntax match flake8File "\v^[^:]*\ze:"
syntax match flake8Location "\v:\zs\d+:\d+\ze:"
syntax match flake8Warning "\v\s\zsF\d{3,}\ze\s"
syntax match flake8Error "\v\s\zs[EW]\d{3,}\ze\s"
syntax match flake8Message "\v\s[EFW]\d{3,}\s\zs.*$"
syntax region flake8String matchgroup=Quote start="\v'" end="\v'"

highlight link flake8Number Number
highlight link flake8File Function
highlight link flake8Location Number
highlight link flake8Warning Operator
highlight link flake8Error Error
highlight link flake8Message Comment
highlight link flake8String String

let b:current_syntax = "flake8"
