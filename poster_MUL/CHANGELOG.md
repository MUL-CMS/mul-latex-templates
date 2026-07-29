# poster_MUL Changelog

Each version below is frozen and available as a git tag (`poster-v<version>`); only the current version's folder is kept in the working tree. See each version's own `README.md` (linked below, where available) for usage details.

## [v3.0-2026](v3.0-2026/README.md) (current)

XeLaTeX/LuaLaTeX, `graphics/`, `figs/`, `fonts/` structure (2025 MUL rebranding).

- New `GRID`/`FLOW` dual layout system (`\gridbox` for manual placement, `\flowbox` for automatic column balancing)
- `\colors{Digital|Print}`, `\fontmode{Regular|Experimental}`, `\lang{EN|DE}` global setup commands
- Bundled brand fonts (Host Grotesk, Funnel Display) with a fallback chain to system fonts
- QR code support (`\qrset`, `\qr`) with EN/DE variants
- Complete rewrite of header (`\buildheader`), footer (`\buildfooter`), and content commands (`\sect`, `\para`, `\img`, `\highlight`, `\prule`, `\references`)

## [v2.0-2022](v2.0-2022/README.md)

pdfLaTeX using `tikz`, structure with `figs` and `graphics` (Department of Materials Science design). Credits: David Holec and Lukas Löfler.

- Horizontal box titles (previously a rotated vertical bar)
- `\authorPhoto` gained a second argument for a caption (name + dates) under the photo
- New "WHERE RESEARCH MEETS FUTURE" footer banner (`\DMSsloganText`)

## [v1.0-2019](v1.0-2019/README.md)

pdfLaTeX using `tikz`, structure with `figs` and `graphics` (Department of Materials Science design). First rewrite away from PSTricks/dvips.

- New `\makeHeader` macro (title/author/institute/email/photo assembled automatically)
- `\posterBox` reimplemented in TikZ; box positions expressed in column/box-separation units instead of absolute coordinates
- Highlight colors renamed to `MULgreen`

## [v0.1-pre2019](v0.1-pre2019/README.md)

LaTeX + `dvips` + `ps2pdf` using `pstricks` (Department of Physical Metallurgy and Materials Testing design).

- Original poster class; `\posterBox` places boxes on an absolute `textpos` grid
- Header/footer hand-placed with hardcoded coordinates, no reusable header macro
