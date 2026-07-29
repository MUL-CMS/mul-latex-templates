# MUL Letter Template — v1.0 (2019)

First reusable letter template, built around a new `mul-letter.cls`. Department of Materials Science (DMS) design. Credits: Dominik Gehringer.

## Compiling

```
make pdf
```

The `makefile` uses `latexmk -pdf` (pdfLaTeX); the old dvips/ps2pdf path is kept commented out as a legacy fallback.

## Structure

- `letter.tex` — example letter
- `mul-letter.cls` — letter class
- `mul-logo.jpg` — MUL logo (left header)
- `institute-logo.png` — institute/department logo (right header)

## Key commands

- `\head`, `\department`, `\address`, `\mail`, `\web` — sender info block under the MUL logo
- `\reciever` — recipient block (note the German-influenced spelling; fixed to `\receiver` in v2.0)
- `\showdate` — always prints `\today`, no override
- `\subject` — subject line
- Footer prints a large semi-transparent turquoise tagline ("WHERE RESEARCH MEETS THE FUTURE")

Colors: `mul-turquoise` (#006E6E), `mul-smoke` (#3C3C3C).

---
Superseded by `v1.1-2020`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `letter-v1.0-2019`.
