# MUL LaTeX templates

A collection of LaTeX templates to be used for our presentations, posters, thesis, official letters etc.

## Philosophy

LaTeX source codes can be compiled using provided `makefile`. These make use of `latexmk` utility. Usage:

`make pdf` | creates `pdf` by preparing all figures (recurses `make` into the subfolder `figs` and `graphics`) and compiles LaTeX code
`make clean` | cleans unnecessary intermediate files

