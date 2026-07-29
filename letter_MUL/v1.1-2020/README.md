# MUL Letter Template — v1.1 (2020)

Minor update to v1.0: same `mul-letter.cls` API, plus a date-override mechanism and an updated institute logo.

## Compiling

```
make pdf
```

Same `latexmk -pdf` build as v1.0.

## What changed vs v1.0

- New `\mulDate` command; `\date{...}` is now overridable instead of always printing `\today`
- `institute-logo.png` replaced with a smaller/updated asset (the MUL logo itself is unchanged)
- Example `letter.tex` content changed to a real letter-of-recommendation template

All class commands (`\head`, `\department`, `\address`, `\mail`, `\web`, `\reciever`, `\showdate`, `\subject`) are unchanged from v1.0.

---
Superseded by `v2.0-2025`. See [`../CHANGELOG.md`](../CHANGELOG.md) for the full version history. Frozen at tag `letter-v1.1-2020`.
