# MUL Thesis Template — v1.3 (2023)

Demotes embedded-publication ToC entries to declutter the table of contents, and adds an optional custom "My Papers" bibliography chapter.

## Compiling

```
make pdf
```

Same `latexmk -bibtex -pdf` workflow as v1.2 (the `clean` target now removes `thesis.bbl` explicitly).

## What's new vs v1.2

- `\newPublicationLogo`/`\newPublication` ToC entries changed from chapter-level to **section-level** (`\addcontentsline{toc}{section}{...}`), so individual "Publication N" entries no longer clutter the top-level ToC
- `\newChapter` now calls `\thispagestyle{fancy}` after the heading
- New optional workflow: `chap2_my_papers.tex` + `my_refs.bbl` — a hand-curated "My Papers" chapter built by compiling with only the cited papers, saving the generated `.bbl`, and converting its `thebibliography` into an `enumerate` list (see comments in `chap2_my_papers.tex`)

> As with v1.2, `mul-thesis.cls`'s `\ProvidesClass` string is unchanged (`2012/04/12 v1.1`) — versioning is tracked by folder name / README only.

---
Current version. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `thesis-v1.3`.
