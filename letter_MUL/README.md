# MUL Letter Template — v3.0 (2026)

`mul-letter.cls` reproduces the official MUL letterhead (Word templates *Briefpapier allgemein*, one-page and multi-page, 2025 rebranding; in `design_resources/office/letter_MUL/v3.0-2025/`): logo and sender block, address field for window envelopes, date and contact person, claim on the first page, page numbers, and fold marks. The template contains no personal data: all sender fields are placeholders.

## Getting started

Copy the whole `letter_MUL` folder (e.g. upload it to Overleaf) and start from one of the examples:

| File | Settings |
| --- | --- |
| `letter.tex` | English (`ENlocalization`) with the German MUL logo (`DElogo`), Calibri, page numbers `2/3`, with a unit logo |
| `letter_de.tex` | German (`DElocalization`), Helvetica, page numbers `▪ 2 von 3 ▪` (`pageNumbersTemplate`) |

Compile with pdfLaTeX: `make` builds both examples (set `MAIN` in the `makefile` to your own file name), or run `latexmk -pdf letter.tex`. On Overleaf, the default compiler (pdfLaTeX) works. Two runs are needed for the positions of the page elements and the total page number; `latexmk` and Overleaf do this automatically.

Folder `graphics/`: MUL logo (`logo-mul.pdf`, `logo-mul-en.pdf`), claim (`claim-de.pdf`, `claim-en.pdf`), and an example logo of an organisational unit (`logo-dms.pdf`). The claim graphics are generated from `design_resources/office/letter_MUL/claim/` (XeLaTeX, Funnel Display); if they are missing, the claim is typeset in the text font.

## Class options

Defaults are marked with *.

- **Localization:** `ENlocalization`* / `DElocalization` — language (babel, hyphenation), MUL logo, claim (*Move mountains* / *Versetz’ Berge*), labels (Contact/Sachbearbeiter\*in, Phone/Tel., Mobile/Mobil, of/von, Enclosures/Beilagen), date format (`2 November 2026` / `02.11.2026`), and the placeholders of the sender block.
- **Logo and claim language:** `DElogo` / `ENlogo` and `DEclaim` / `ENclaim` set the language of the MUL logo and of the claim separately, overwriting the localization (independent of their order in `\documentclass`), e.g. `\documentclass[ENlocalization, DElogo]{mul-letter}` for an English letter with the German logo (as in `letter.tex`). `DEslogan` / `ENslogan` are aliases of `DEclaim` / `ENclaim`.
- **Font:** `calibri`* (12 pt, as the Word templates; set with Carlito, which is metrically compatible with Calibri) / `helvetica` (11 pt).
- **Page numbers** (from page 2 on; the first page carries the claim): `pageNumbersMofN`* / `pageNumbers` / `noPageNumbers`, in the style `pageNumbersClassic`* (as in v2.0: `2/3` or `2`, bottom right) or `pageNumbersTemplate` (as in the Word templates: `▪ 2 von 3 ▪` or `▪ 2 ▪`, 8 pt, centred).
- **Fold marks:** `foldMarks`* / `noFoldMarks` — marks at 105 mm and 210 mm (DIN 5008, form B) and the punch mark at 148.5 mm, on every page.
- **Header:** `headerOnlyFirstPage`* / `headerEveryPage` (logo and sender block on all pages; the text then starts lower on the following pages).
- **Sender block:** `normalAddress`* / `condensedAddress` (condensed Helvetica; no effect with `calibri`).

Other options are passed to the `article` class. The font size is set by the font option.

## Commands

Sender block (preamble or before the text; empty entries are omitted):

- `\department{<unit>}` — first line, bold (placeholder: *Organisational unit* / *Organisationseinheit*)
- `\sendername{<name>}` — second line (placeholder: *First name Last name* / *Vorname Nachname*)
- `\address{<address>}` — one line (default: Franz-Josef-Straße 18, 8700 Leoben, Austria; German: …, A-8700 Leoben)
- `\phone{<number>}`, `\mobile{<number>}`, `\mail{<e-mail>}` — empty by default
- `\web[<url>]{<text>}` — default `www.unileoben.ac.at`; `<url>` defaults to `<text>` (with `https://` added if missing); `\web{}` removes it
- `\unitlogo{<file>}` — logo of the organisational unit, top right (scaled to fit 42.6 × 16.1 mm); none by default. Put your own logo (PDF, PNG or JPG) in `graphics/`; `letter.tex` shows it with `graphics/logo-dms.pdf` (Department of Materials Science)
- `\setLogo{<file>}` — replaces the MUL logo; `\setSlogan{<text>}` replaces the claim (typeset in the text font), `\setSlogan{}` removes it

Address, date, contact person (first page, fixed positions):

- `\receiver[<note>]{<address>}` — address field for window envelopes (85 × 40 mm at 25 mm / 43.5 mm); the optional `<note>` (e.g. a dispatch note) is printed in the line above the address
- `\date{<date>}` — replaces today's date; `\date{}` removes the date
- `\placeInDate{<place>}` — place before the date (default: Leoben); `\placeInDate{}` removes it
- `\contact{<name>}` — contact person below the date (*Contact:* / *Sachbearbeiter\*in:*); empty by default

Letter body:

- `\subject{<subject>}` — subject line in Turquoise and small caps (simulated, as Carlito and Helvetica have none in pdfLaTeX: lowercase letters become capitals at 80 %); redefine `\subjectFont` to change it, e.g. `\renewcommand{\subjectFont}[1]{\textbf{#1}}`
- `\closing[<signature>]{<text>}` — closing (e.g. *Kind regards,* or *Glück auf!*), space for the signature (or `<signature>`, e.g. `\includegraphics[height=15mm]{signature}`), and the name set by `\signature{<name>}` (default: the sender's name)
- `\enclosures{<list>}` — *Enclosures* / *Beilagen* in bold, followed by the list (items separated by `\\`)

Layout settings (lengths and macros, for fine tuning): `\MULbodystart` (start of the text on the first page, default 107 mm), `\MULdatetop` (top of the date field, default 86 mm), `\subjectSkip`, `\MULlogoheight`, `\MULclaimheight`, `\MULfoldmarkA`, `\MULpunchmark`, `\MULfoldmarkB`. Colours: `MULsubject`, `MULclaim`, `MULpagenumber`, `MULfoldmark`, and the brand colours `digital_*` (same names as in `talk_MUL` and `poster_MUL`).

## Compatibility with v2.0

The v2.0 commands and options still work: `\head` (now the name line, no longer bold), `\showdate` (no effect; the date is always printed), `noPageNumbres`, `pageNumbres`, `pageNumbresMofN`, `foldmarkHalf`, `foldmarkThird` (both give the marks of the Word templates), and the colours `mul-green`, `mul-header`, `mul-text`. Visible changes: layout of the Word templates (fixed address and date fields, sender block order, claim with rule), Turquoise `#00727D` instead of `#006E6E`, black text, Calibri (Carlito) instead of Helvetica by default, no department logo by default.

## Deviations from the Word templates

- **Font:** Carlito instead of Calibri (metrically compatible; Calibri itself is not available in pdfLaTeX); option `helvetica` as an alternative.
- **Date field:** at 86 mm instead of 75.4 mm, below the address field.
- **Subject:** small caps.
- **Bottom margin:** 25 mm instead of 20 mm, so that the text stays clear of the claim on the first page.
- **Lower fold mark:** 210 mm (DIN 5008, form B) instead of ≈ 201 mm in the Word templates.
- **Page numbers:** style of v2.0 (`2/3` bottom right) by default; option `pageNumbersTemplate` follows the templates (in black instead of `#1A2528`).

---
Current version. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history.
