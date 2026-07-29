# MUL Thesis Template — v1.2 (2022)

Fixes the "blob" tab layout so more than 8 embedded publications can be handled. First version with a `makefile`.

## Compiling

```
make pdf
```

Uses `latexmk -bibtex -pdf` (pdfLaTeX). The old dvips path is present in the makefile but commented out.

## What's new vs v1.1

- New `cntBlobPos` counter, incremented alongside the publication counter in `\newPublicationLogo`/`\newPublication` and reset to 1 once it reaches 9 — the blob tab's vertical position now cycles through 8 slots instead of drifting off the page after the 8th embedded publication.

> Note: `mul-thesis.cls`'s internal `\ProvidesClass` string is not bumped for this release — it still reads `2012/04/12 v1.1`. The folder/README version numbers are the source of truth, not the class file's own metadata.

---
Superseded by `v1.3`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `thesis-v1.2`.
