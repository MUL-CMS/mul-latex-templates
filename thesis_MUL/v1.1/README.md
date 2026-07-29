# MUL Thesis Template — v1.1 (2012)

Adds the ability to embed published-paper PDFs inside the thesis. Still no `makefile` (manual pdfLaTeX workflow), but now effectively **requires pdfLaTeX** since `\documentclass[pdfpages,blob,twoside]{mul-thesis}` needs the `pdfpages` option.

## Compiling

```
pdflatex thesis.tex
bibtex thesis
pdflatex thesis.tex
pdflatex thesis.tex
```

## Structure

- `thesis.tex`, `title.tex`, `acknowledgements.tex`
- `chap0_abstract.tex`, `chap1_introduction.tex`, `chap4_paper.tex` — new chapter split
- `mul-thesis.cls`, `paper.pdf` — an example embedded publication

## What's new vs v1.0

- New `blob` class option
- `\newPublicationLogo{logo}{caption}` / `\newPublication{caption}` — start an unnumbered "Publication N" chapter (via `pdfpages`), with a ToC entry at chapter level and fancy running headers
- `\blob` / `\lblob` — draw a small colored rotated-text tab in the page margin/header so a reader can flip directly to a given embedded publication
- `\newChapter` gains a starred form: `\newChapter[*]{title}` for unnumbered chapters

---
Superseded by `v1.2`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `thesis-v1.1`.
