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




## talk_MUL

*   v2.10-2024 (current)
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - list of ToDos for next class update

*   v2.01-2024
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - update of `\framegrid` command

*   v2.00-2024
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - new format: 16/9
    - new options: `emptyFootings` and `fullFootings`
    - major clean up

*   v1.02-2020
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - new environment `overdraw`

*   v1.01-2019
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)

*   v1.00-2019
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)

*   v0.23-2016
    LaTeX + `dvips` + `ps2pdf` using `pstricks`  
    (Department of Physical Metallurgy and Materials Testing design)

*   v0.22-2013
    LaTeX + `dvips` + `ps2pdf` using `pstricks`  
    (Department of Physical Metallurgy and Materials Testing design)

*   v0.21-2013
    LaTeX + `dvips` + `ps2pdf` using `pstricks`  
    (Department of Physical Metallurgy and Materials Testing design)

*   v0.1-2008-2012
    LaTeX + `dvips` + `ps2pdf` using `pstricks`  
    (old Department of Physical Metallurgy and Materials Testing design)

### drawing on slides using the `\framegrid` command

To draw arbitrarily over the whole slide, one can use the `overdraw` environment. This allows you to paint even over the table of contents.

```
\begin{overdraw}
    \framegrid
    \node[red, very thick, fill=red!50!white] (2,2) rectangle (3,3);
\end{overdraw}
```
This will show a grid over the whole slide. Furthermore it will plot a red rectangle on the slide 

## poster_MUL

*   v2.0-2022 (current)
    updated design:
      - horizontal box titles
      - author photo (and dates for thesis posters)
      - "WHERE RESEARCH MEETS FUTURE" banner
      credits to: Lukas Löfler

*   v1.0-2019
    pdfLaTeX using `tikz`

*   v0.1-pre2019  
    LaTeX + `dvips` + `ps2pdf` using `pstricks`

## letter_MUL

*   v2.0-2020 (current)
    pdfLaTeX
    - major update based on re-branding in 2025

*   v1.0-2019
    pdfLaTeX
    (Department of Materials Science design)
    credits to: Dominik Gehringer

*   v0.1-2012-2018
    LaTeX + `dvips` + `ps2pdf`
    (Department of Physical Metallurgy and Materials Testing design)


## thesis_MUL

*   v1.3 (2023, current)
    pdfLaTeX
    - update of ToC
    
*   v1.2 (2022)
    pdfLaTeX
    - update of blobs to allow for more papers

*   v1.1
    pdfLaTeX
    - capable of including publications in pdf

*   v1.0  
    LaTeX + `dvips` + `ps2pdf`  _or_  pdfLaTeX
    basic template without pdfs

# Office templates
The templates are also available for the MS-Office suite. They're in the `office-templates` branch
