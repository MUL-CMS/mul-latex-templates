# MUL Poster Template — v0.1 (pre-2019)

The earliest version of the MUL poster class. Predates pdfLaTeX/TikZ support: gradients and curved text are done with **PSTricks**, so the document compiles via **LaTeX → dvips → ps2pdf**.

## Compiling

```
make pdf
```

The provided `makefile` runs the `latex` → `dvips` → `ps2pdf` chain (`.dvi` → `.ps` → `.pdf`).

## Structure

- `dh_poster.tex` — main document
- `mul_poster.cls` — poster class (PSTricks-based)
- `figs/` — author photo
- `graphics/` — institutional logos in EPS, each with its own `makefile`

## Key commands

- `\posterBox{width}(x,y){title}{content}` (and starred variant) — places a box on an absolute grid (`textpos`, `\TPGrid[15mm,125mm]{41}{60}`), with a rotated gradient title bar (IMWgreen → white) drawn via a raw `picture` environment.
- `\alert` / `\Alert` — red/green highlight colors.

Header and footer are hand-placed with hardcoded `\put` coordinates — there is no reusable header macro yet (that arrives in v1.0 with `\makeHeader`).

---
Superseded by `v1.0-2019`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `poster-v0.1-pre2019`.
