# letter_MUL Changelog

Each version below is frozen and available as a git tag (`letter-v<version>`); only the current version's files are kept in the working tree (flat, directly in `letter_MUL/`). Archived versions' own `README.md` can be read by checking out their tag, e.g. `git show letter-v1.0-2019:letter_MUL/README.md`.

## [v3.0-2026](README.md) (current)

pdfLaTeX. Layout of the official MUL letterhead (Word templates *Briefpapier allgemein*, 2025 rebranding).

- Fixed positions as in the Word templates: logo and sender block, address field for window envelopes, date and contact person (`\contact`), claim with rule on the first page, page numbers from page 2 on (`2/3` bottom right as in v2.0, or `▪ 2 von 3 ▪` centred as in the templates with `pageNumbersTemplate`), fold and punch marks (105/148.5/210 mm, on by default)
- New options: `calibri` (default; Carlito) / `helvetica`; `ENlocalization` (default) / `DElocalization` (logo, claim, labels, date format, babel language), with `DElogo`/`ENlogo` and `DEclaim`/`ENclaim` (aliases `DEslogan`/`ENslogan`) to set the language of the logo and the claim separately; `foldMarks`/`noFoldMarks`; page-number options spelled correctly (`noPageNumbers`, `pageNumbers`, `pageNumbersMofN`; old names kept), `pageNumbersClassic`/`pageNumbersTemplate`
- New commands: `\sendername`, `\phone`, `\mobile`, `\web[<url>]{<text>}` (links now work), `\unitlogo`, `\setLogo`, `\setSlogan`, `\contact`, `\closing`, `\signature`, `\enclosures`; `\receiver` with an optional note line
- Brand colours `digital_*` (Turquoise `#00727D` instead of `#006E6E`), black text, subject in Turquoise small caps
- Anonymised for Overleaf: placeholders instead of personal data, no department logo by default (`graphics/logo-dms.pdf` as an example for `\unitlogo` in `letter.tex`); English and German examples (`letter.tex`, `letter_de.tex`)
- Logos (German and English) from `talk_MUL`, in `graphics/`; claim graphics (Funnel Display) generated from `design_resources/office/letter_MUL/claim/`

## v2.0-2025 (tag `letter-v2.0-2025`)

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
