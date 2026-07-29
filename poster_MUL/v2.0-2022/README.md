# MUL Poster Template — v2.0 (2022)

pdfLaTeX/TikZ poster class with a redesigned header/box layout. Credits: David Holec and Lukas Löfler.

## Compiling

```
make pdf
```

The `makefile` calls `latexmk -bibtex -pdf` (same build path as v1.0).

## Structure

- `poster.tex` — main document (renamed from `dh_poster.tex`)
- `mul_poster.cls` — poster class
- `figs/` — result figures + author photo
- `graphics/` — institute/university logos

## What changed vs v1.0

- `\posterBox{...}` — title bar redesigned from a rotated vertical bar to a **horizontal** title bar spanning the top of the box.
- `\authorPhoto{path}{extraInfo}` — now takes a second argument for a caption under the photo (e.g. name + date range), vs. v1.0's single-argument form.
- New footer banner: `\DMSsloganText` ("WHERE RESEARCH MEETS FUTURE") printed in grey below the poster.

---
Superseded by `v3.0-2026`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `poster-v2.0-2022`.
