# MUL Poster Template — v1.0 (2019)

First **pdfLaTeX**/TikZ-based rewrite of the poster class, replacing the PSTricks/dvips pipeline of v0.1.

## Compiling

```
make pdf
```

The `makefile` calls `latexmk -bibtex -pdf` directly — no dvi/ps intermediate step.

## Structure

- `dh_poster.tex` — main document
- `mul_poster.cls` — poster class (TikZ-based)
- `refs.bib` — references
- `figs/` — figures + author photo
- `graphics/` — DMS background/logo images, MUL logo (PDF)

## Key commands

- `\posterBox{width}(x,y){title}{content}` — reimplemented with TikZ: green→white gradient title bar, box positions given in column/box-separation units (`\dhNumCols`, `\dhBoxSep`, `\dhColumnWidth`) instead of v0.1's absolute `textpos` coordinates. Title text is rotated 90°.
- `\makeHeader` — new: assembles `\title`, `\author`, `\institute`, `\email`, `\authorPhoto{path}` into a single TikZ header block with a green-framed photo.
- `\alert` / `\Alert` — highlight colors, renamed to `MULgreen`.

---
Superseded by `v2.0-2022`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `poster-v1.0-2019`.
