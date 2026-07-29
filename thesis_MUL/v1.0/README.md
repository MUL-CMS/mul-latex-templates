# MUL Thesis Template — v1.0 (2012)

Baseline release of the MUL thesis class, `mul-thesis.cls` — a thin wrapper around **memoir** (not a fully custom class). No `makefile`; compiles manually.

## Compiling

```
pdflatex thesis.tex
bibtex thesis
pdflatex thesis.tex
pdflatex thesis.tex
```

(No `pdfpages` option is used, so the classic `latex`+`dvips`+`ps2pdf` route also works.)

## Structure

- `thesis.tex` — main document
- `title.tex`, `acknowledgements.tex`, `chap1_introduction.tex` — content chapters
- `mul-thesis.cls` — thesis class
- `aipnum4-1.bst` — bibliography style
- `figs/`

## Key features

- Custom `mul-madsen` chapter style (raggedleft big chapter titles), redefined `\section`/`\subsection`/`\subsubsection`
- `\newChapter{title}` helper
- `\tableofcontents` adds an unnumbered ToC entry for itself
- Class options: `pdfpages`, `oneside`/`twoside`, `colorlinks`/`BWlinks`, `lineno`

No support yet for embedding published papers as PDFs (added in v1.1).

---
Superseded by `v1.1`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `thesis-v1.0`.
