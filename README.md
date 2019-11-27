# MUL LaTeX templates

A collection of LaTeX templates to be used for our presentations, posters, thesis, official letters etc.

## Usage

LaTeX source codes can be compiled using provided `makefile`. These make use of `latexmk` utility.

*   `make pdf`  
    creates `pdf` by preparing all figures (recurses `make` into the subfolder `figs` and `graphics`) and compiles LaTeX code

*   `make clean`  
    cleans unnecessary intermediate files

By default, the figures are expected to be in folder `figs` while graphics (logos, corporate identity, etc.) in `graphics`.

Don't forget to modify the name of your main document in the `makefile`!

### Clean unused figures

A provided utility `select-used-fig` selects from a given subfolder only those files which are really used in the present document. This is useful if you prepare your _new_ document using an _old_ document as a template, hence ending up with many unnecessary (and often irrelevant) figures. The used figures are taken from the LaTeX `log` file.

*   `select-used-figs`  
    lists available `log` files in the present directory

*   `select-used-figs <file.log>`  
    selects unused figures subfolder `figs` based on `<file.log>` and copies them to `figs-unused`

*   `select-used-figs <file.log> <subfolder>`  
    selects unused figures subfolder `<subfolder>` based on `<file.log>` and copies them to `<subfolder>-unused`

Why not to delete the files directly? Because each of us has to make the final decision what (and if) to delete. The utility helps you _to select_ the unused figures (but maybe you want to keep certain source data etc.)



## poster_MUL

*   v1.0-2019 (current)  
    pdfLaTeX using `tikz`

*   v0.1-pre2019  
    LaTeX + `dvips` + `ps2pdf` using `pstricks`

