# letter_MUL Changelog

Each version below is frozen and available as a git tag (`letter-v<version>`); only the current version's files are kept in the working tree (flat, directly in `letter_MUL/`). Archived versions' own `README.md` can be read by checking out their tag, e.g. `git show letter-v1.0-2019:letter_MUL/README.md`.

## [v2.0-2025](README.md) (current)

pdfLaTeX. Major update based on the 2025 university rebranding. Credits: David Holec and Dominik Gehringer.

- Vector PDF logos (`logo-mul.pdf`, `logo-dms.pdf`, `logo-footer.pdf`) replace raster `.jpg`/`.png` logos
- New class-option system: address style, page-numbering style, header-every-page vs. first-page-only, folding guide marks (`tikz`)
- `\reciever` typo fixed to `\receiver`; new `\placeInDate` command
- Footer redesigned around a logo graphic + page number instead of a text tagline
- `mul-turquoise` color renamed to `mul-green` (same hex value)

## v1.1-2020 (tag `letter-v1.1-2020`)

pdfLaTeX (Department of Materials Science design).

- New `\mulDate`/overridable `\date{...}` (previously always `\today`)
- Updated institute logo asset

## v1.0-2019 (tag `letter-v1.0-2019`)

pdfLaTeX (Department of Materials Science design). Credits: Dominik Gehringer.

- First reusable letter class (`mul-letter.cls`), replacing the hand-typed v0.1 document
- `\head`, `\department`, `\address`, `\mail`, `\web`, `\reciever`, `\showdate`, `\subject` commands introduced

## v0.1-2012-2018 (tag `letter-v0.1-2012-2018`)

LaTeX + `dvips` + `ps2pdf` (Department of Physical Metallurgy and Materials Testing design).

- Original letter document; no reusable class, letterhead hand-typed directly into `letter.tex`
