# MUL Talk Template — v1.00 (2019)

First **pdfLaTeX** rewrite, with a renamed class `beamerDMS.cls` (from `beamer-unileoben.cls`) marking the start of the Department of Materials Science (DMS) branding era.

## Compiling

```
make pdf
```

`latexmk -pdf`.

## What changed vs v0.23

- Class renamed `beamerDMS.cls`
- EPS logos replaced with PDF logos (`logo_MUL_hor.pdf`, `logo_MUL_M.pdf`, `logo_MUL.pdf`), referenced directly from the working directory (not yet under `graphics/`)
- Class options: `showResults`/`hideResults`

No `overdraw`/`\framegrid` yet (introduced in v1.02-2020).

---
Superseded by `v1.01-2019`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `talk-v1.00-2019`.
