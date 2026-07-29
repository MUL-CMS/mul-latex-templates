# MUL Letter Template — v2.0 (2025)

Major rewrite of `mul-letter.cls` for the 2025 university rebrand: vector PDF logos, a class-option system, and per-page header/footer control.

## Compiling

```
make pdf
```

`latexmk -pdf` (pdfLaTeX); a `lualatex` line is present in the `makefile` but commented out as an alternative.

## Structure

- `letter.tex` — example letter
- `mul-letter.cls` — letter class
- `logo-mul.pdf`, `logo-dms.pdf`, `logo-footer.pdf` — vector logos (replace the old raster `.jpg`/`.png` logos)

## Class options

- `condensedAddress` / `normalAddress`
- `noPageNumbres` / `pageNumbres` / `pageNumbresMofN` (page numbering, incl. "N of M" style)
- `headerEveryPage` / `headerOnlyFirstPage`
- `foldmarkHalf` / `foldmarkThird` — printed folding guide marks (via `tikz`)

## Key commands

- `\headleft`, `\headright` — header content
- `\footcenter`, `\footright`, `\footleft` — footer content, page number, fold marks
- `\receiver` — recipient block (spelling fixed from v1.x's `\reciever`)
- `\placeInDate` — prefixes the date with a city (default "Leoben, ")
- `\date{...}` override retained from v1.1

Colors: `mul-turquoise` renamed to `mul-green` (same hex, #006E6E); new `mul-header` (#000000) for headline text. Footer is now built from `logo-footer.pdf` instead of a text tagline.

---
Current version. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `letter-v2.0-2025`.
