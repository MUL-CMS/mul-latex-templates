# thesis_MUL Changelog

Each version below is frozen and available as a git tag (`thesis-v<version>`); only the current version's folder is kept in the working tree. See each version's own `README.md` (linked below) for usage details.

The class (`mul-thesis.cls`) is a thin wrapper around `memoir` in all four versions. Note that its internal `\ProvidesClass` version string was frozen at `2012/04/12 v1.1` from v1.1 onward and was never updated for the v1.2/v1.3 releases — the folder name and this changelog are the source of truth for versioning, not the class file's own metadata.

## [v1.3](v1.3/README.md) (2023, current)

pdfLaTeX.

- ToC entries for embedded publications demoted from chapter- to section-level, for a cleaner table of contents
- New optional "My Papers" custom-bibliography chapter workflow (`chap2_my_papers.tex` + `my_refs.bbl`)

## [v1.2](v1.2/README.md) (2022)

pdfLaTeX.

- Fixed blob-tab layout (new `cntBlobPos` counter) so more than 8 embedded publications can be handled without their tabs running off the page
- First version with a `makefile`/`latexmk` build workflow

## [v1.1](v1.1/README.md)

pdfLaTeX (requires the `pdfpages` option).

- Capable of embedding published-paper PDFs, with `\blob`/`\lblob` tab markers in the page margin for navigation
- `\newPublicationLogo`/`\newPublication` commands to start a publication chapter

## [v1.0](v1.0/README.md)

LaTeX + `dvips` + `ps2pdf` _or_ pdfLaTeX.

- Basic MUL thesis skeleton, no support for embedding published papers
