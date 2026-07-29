# MUL Letter Template — v0.1 (2012–2018)

Earliest letter template. No `.cls` file — the letterhead is hand-typed directly into a plain `article` document. Compiles via **LaTeX → dvips → ps2pdf** (`graphicx` is loaded with the `dvips` driver).

## Compiling

```
make pdf
```

## Structure

- `letter.tex` — the entire letter (letterhead, body, signature) is written inline; there are no reusable macros
- `logo_MU.eps` / `logo_MU.jpg` — Department of Physical Metallurgy and Materials Testing era logo

## Notes

This is a single fixed letterhead for one user (David Holec), not a general-purpose template — reusing it means hand-editing the `.tex` body directly. Header logo is placed via a raw `picture` environment; footer (sender name/address/phone/fax/email) and recipient block are all hardcoded.

---
Superseded by `v1.0-2019`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `letter-v0.1-2012-2018`.
