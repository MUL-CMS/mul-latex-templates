# MUL Talk Template — v0.23 (2016)

Same PSTricks/`dvips`/`ps2pdf` engine as v0.22 (Department of Physical Metallurgy and Materials Testing design). Last version of the `pstricks`-based lineage.

## Compiling

```
make pdf
```

First version with a `makefile` (`dvips`/`ps2pdf` targets).

## What changed vs v0.22

- Adds a `figs/` subfolder (first appearance)

> Note: `beamer-unileoben.cls`'s internal `\ProvidesClass` string was not bumped for this release — it still reads `2013/05/07 v0.22`.

---
Superseded by `v1.00-2019`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `talk-v0.23-2016`.
