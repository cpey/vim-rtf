# vim-rtf

Vim format definition to add syntax coloring to my notes.

## Configuration

1. Copy file rtf.vim to ~/.vim/syntax/
2. Create an `.rtf` file and start coloring!

You can also add the text below at the last line of a `.txt` file (this is parsed only when the modelines option is set in .vimrc):

```
==================================================================================================
vim: ft=rtf tw=80 cc=99 et ts=8 sw=4 sts=4 fo=tcq2 isk=a-z,A-Z,48-57,_
```
## Examples

![Sections syntax](https://github.com/cpey/vim-rtf/blob/main/images/sections.jpg?raw=true)
![Code syntax highlighting](https://github.com/cpey/vim-rtf/blob/main/images/syntax-highlight.jpg?raw=true)
![Text coloring](https://github.com/cpey/vim-rtf/blob/main/images/coloring.jpg?raw=true)

