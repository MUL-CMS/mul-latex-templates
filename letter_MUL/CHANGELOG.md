# letter_MUL Changelog

Each version below is frozen and available as a git tag (`letter-v<version>`); only the current version's folder is kept in the working tree. See each version's own `README.md` (linked below) for usage details.

## [v2.0-2025](v2.0-2025/README.md) (current)

pdfLaTeX. Major update based on the 2025 university re-branding.

- Vector PDF logos (`logo-mul.pdf`, `logo-dms.pdf`, `logo-footer.pdf`) replace raster `.jpg`/`.png` logos
- New class-option system: address style, page-numbering style, header-every-page vs. first-page-only, folding guide marks (`tikz`)
- `\reciever` typo fixed to `\receiver`; new `\placeInDate` command
- Footer redesigned around a logo graphic + page number instead of a text tagline
- `mul-turquoise` color renamed to `mul-green` (same hex value)

## [v1.1-2020](v1.1-2020/README.md)

pdfLaTeX (Department of Materials Science design).

- New `\mulDate`/overridable `\date{...}` (previously always `\today`)
- Updated institute logo asset

## [v1.0-2019](v1.0-2019/README.md)

pdfLaTeX (Department of Materials Science design). Credits: Dominik Gehringer.

- First reusable letter class (`mul-letter.cls`), replacing the hand-typed v0.1 document
- `\head`, `\department`, `\address`, `\mail`, `\web`, `\reciever`, `\showdate`, `\subject` commands introduced

## [v0.1-2012-2018](v0.1-2012-2018/README.md)

LaTeX + `dvips` + `ps2pdf` (Department of Physical Metallurgy and Materials Testing design).

- Original letter document; no reusable class, letterhead hand-typed directly into `letter.tex`
