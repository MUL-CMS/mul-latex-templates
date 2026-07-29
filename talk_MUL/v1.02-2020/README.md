# MUL Talk Template — v1.02 (2020)

pdfLaTeX, `beamerDMS.cls`, structure with `figs` and `graphics` (Department of Materials Science design). 16:10 aspect ratio.

## Compiling

```
make pdf
```

## What changed vs v1.01

- Adds `\RequirePackage{tikz}`
- New `overdraw` environment and `\framegrid` command — draw arbitrarily over the whole slide (including over the table of contents):

```latex
\begin{overdraw}
    \framegrid
    \node[red, very thick, fill=red!50!white] (2,2) rectangle (3,3);
\end{overdraw}
```

> Note: `beamerDMS.cls`'s internal `\ProvidesClass` string is still unchanged (reads `v1.00`).

---
Superseded by `v2.00-2024`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `talk-v1.02-2020`.
