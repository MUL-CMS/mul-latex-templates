# MUL Talk Template — v0.1 (2008–2012)

Earliest beamer template, `beamer-unileoben.cls` (Department of Physical Metallurgy and Materials Testing design). Compiles via **LaTeX → dvips → ps2pdf** (class passes `dvips, xcolor=pst` to `beamer`, i.e. PSTricks-based).

## Compiling

Manual `latex` → `dvips` → `ps2pdf` chain (no makefile in this version).

## Structure

- `lecture.tex` — main document
- `beamer-unileoben.cls` — beamer class
- `dh_*.sty` — two helper packages
- 3 loose `.eps` files (logo/heading/footing) — no `figs/` subfolder yet

## Key commands

- `\institute`, `\conference`, `\lecture`
- `showResults` boolean toggle (`\setboolean{showResults}{true}`)

No `\aff`, no `overdraw`/`\framegrid` yet (introduced much later, in v1.02-2020).

---
Superseded by `v0.21-2013`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `talk-v0.1-2008-2012`.
