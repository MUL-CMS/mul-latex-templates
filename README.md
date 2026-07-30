# MUL LaTeX templates

An unofficial collection of LaTeX templates for presentations, posters, theses, official letters, etc., with MUL branding.


## Usage

LaTeX source code can be compiled using the provided `makefile`. These make use of the `latexmk` utility.

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

Why not delete the files directly? Because each of us has to make the final decision what (and if) to delete. The utility helps you _to select_ the unused figures (but maybe you want to keep certain source data, etc.)




## talk_MUL

Current version: **v3.02-2025**, XeLaTeX/LuaTeX using `tikz`, structure with `figs` and `graphics` (2025 MUL rebranding).

Older versions (v0.1-2008-2012 through v3.01-2025) have been archived: their folders were removed from the working tree and frozen as git tags (`talk-v<version>`, e.g. `git checkout talk-v1.02-2020`). See [`talk_MUL/CHANGELOG.md`](talk_MUL/CHANGELOG.md) for the full version history, and each tagged version's own `README.md` for usage details specific to that version.


## poster_MUL

Current version: **v3.0-2026**, XeLaTeX/LuaLaTeX, GRID/FLOW dual layout system (2025 MUL rebranding).

Older versions (v0.1-pre2019, v1.0-2019, v2.0-2022) have been archived: their folders were removed from the working tree and frozen as git tags (`poster-v<version>`, e.g. `git checkout poster-v2.0-2022`). See [`poster_MUL/CHANGELOG.md`](poster_MUL/CHANGELOG.md) for the full version history, and each tagged version's own `README.md` for usage details specific to that version.

## letter_MUL

Current version: **v2.0-2025**, pdfLaTeX, major update based on the 2025 rebranding.

Older versions (v0.1-2012-2018, v1.0-2019, v1.1-2020) have been archived: their folders were removed from the working tree and frozen as git tags (`letter-v<version>`, e.g. `git checkout letter-v1.0-2019`). See [`letter_MUL/CHANGELOG.md`](letter_MUL/CHANGELOG.md) for the full version history, and each tagged version's own `README.md` for usage details specific to that version.


## thesis_MUL

Current version: **v1.3** (2023), pdfLaTeX.

Older versions (v1.0, v1.1, v1.2) have been archived: their folders were removed from the working tree and frozen as git tags (`thesis-v<version>`, e.g. `git checkout thesis-v1.1`). See [`thesis_MUL/CHANGELOG.md`](thesis_MUL/CHANGELOG.md) for the full version history, and each tagged version's own `README.md` for usage details specific to that version.

# design_resources

A collection of supporting resources and documents for creating the templates; not needed for using the templates.
