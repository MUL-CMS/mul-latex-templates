# `mul-beamer` — A Beamer Class for Montanuniversität Leoben Presentations

This is a custom `beamer` class designed for academic and professional presentations at **Montanuniversität Leoben (MUL)** and the Department of Materials Science (DMS). It provides a clean 16:9 layout with university branding, flexible slide footings, and sidebar support.

## Features

- **MUL branding** with logo, slogan, and color scheme.
- **Flexible footline settings**, including author/title, conference info, and slide numbers.
- **Sidebar layout** for table of contents navigation (optional).
- **Support for lectures and conferences**, with automated ToC slides.
- **Localization** in English or German.
- **Optional results block**.
- **Custom title page layout** with image and optional additions.

---

## Getting Started

Two starting points are provided; copy the whole `talk_MUL` folder (e.g. upload it to Overleaf) and start from one of them:

| File | Mode | Settings |
| --- | --- | --- |
| `talk.tex` | talk (conference) | `fullFootings`, `slideTotalNumber`, `hideSidebar`, `ENlocalization` with `DElogo` and `DEslogan`, `\conference{}` shown on the title page and in the footer; closing slide (`\finalframe`) and a backup slide (`\lastslide`) |
| `lecture.tex` | lecture | `lectureFootings`, `showResults`, `darkTitle`, `\lecture{}`: table of contents at each section, lecture name in the footer |

Both include `demo_functionality.tex` (via `\input{demo_functionality}`), a set of slides demonstrating the functionality of the class, and, as backup slides at the end, `demo_documentation.tex` (via `\input{demo_documentation}`), a detailed documentation of all class options and commands. Remove these lines (and the files, together with `figs/demo_*.tex`) when writing your own slides.

Folders: `figs/` for your figures, `graphics/` for logos, backgrounds, and QR codes, `fonts/` for the bundled fonts (Funnel Display, Host Grotesk).

Compile with XeLaTeX or LuaLaTeX: `make` builds both documents (set `MAIN` in the `makefile` to your own file name), or run `latexmk -xelatex talk.tex`. On Overleaf, select *Menu → Compiler → XeLaTeX*.

---

## Class Options

### Sidebar Layout
- `showSidebar`
  Show the sidebar with the table of contents (default).
- `hideSidebar`
  Hide the sidebar.

### Footing Layout
- `emptyFootings`
  Minimal footline showing slide number only.
- `defaultFootings`
  Shows slogan, author | organisational unit (optional argument of `\institute`), and slide number (default).
- `fullFootings`
  Shows author/title, conference/date, slogan, and slide number.
- `lectureFootings`
  Shows slogan, lecture name (as set by `\lecture{}`), and slide number only. Unlike `fullFootings`, the lecture name is not replaced by section names.

### Slide Numbering
- `slideSingleNumber`
  Show only the current slide number (default).
- `slideTotalNumber`
  Show "current / total" slide numbers.

### Table of Contents Behavior
- `showothersubsections`
  Show all sections and subsections in the sidebar (default).
- `hideothersubsections`
  Hide inactive subsections from the table of contents in the sidebar.

### Localization
- `DElocalization`
  German labels and slogans (default).
- `ENlocalization`
  English labels and slogans.

Languages can be mixed with the following options, which override the localization for the title logo or the claim only (independent of their order in `\documentclass`):
- `DElogo`, `ENlogo`
  German or English MUL logo on the title page and the dark slides.
- `DEslogan`, `ENslogan`
  German (*Versetz’ Berge*) or English (*Move mountains*) claim.

E.g. `\documentclass[ENlocalization, DElogo, DEslogan]{mul-beamer}` gives English texts with the German logo and claim (as in `talk.tex`). Individual elements can also be set by `\setTitleLogo`, `\setSlogan`, `\setThanksText`, and `\setAgendaTitle`; `\setSlogan{}` removes the claim from the title page and footer.

### Title Slide
- `lightTitle`
  Light background, turquoise title, grey claim (default).
- `darkTitle`
  Dark background (see `\setDarkBackground`), white logo and text, claim in Light-Green, as the dark title slide of the MUL PowerPoint master. Note that additions by `\additionsToTitlePage` (e.g. partner logos) need to be readable on the dark background.

### Fonts
- `classicFont`
  Latin Modern Sans (beamer default) for text, and for letters, digits, and operator names (`\sin`, `\mathrm{}`) in formulas (default).
- `brandFont`
  Host Grotesk (MUL brand font) for text, and for letters, digits, and operator names in formulas. Fallbacks if the bundled font files in `fonts/Host_Grotesk/` are missing: installed Host Grotesk, Calibri, Carlito, Latin Modern Sans.

Note: the MUL style guide prescribes Host Grotesk for body text. This class nevertheless uses Latin Modern Sans by default, as a deliberate choice for the appearance of (scientific) slides; use `brandFont` to follow the style guide.

In formulas, Greek letters and other symbols are always taken from Computer Modern. Frame titles, the title, and the slogan are always set in Funnel Display (see `\funneldisplay`).

### Extra Functional Options
- `showResults`
  Enables the `\showResults{}` block (default).
- `hideResults`
  Hides the `\showResults{}` block.

`showResults`/`hideResults` are independent of the beamer mode: in the presentation as well as with beamer's options `trans` or `handout` (one page per frame, without overlays), only these two options decide. For exercise handouts without results, use e.g. `\documentclass[trans, hideResults]{mul-beamer}`.

### Default Class Setup

```latex
\documentclass[
  beamer,
  slideSingleNumber,
  showothersubsections,
  showSidebar,
  DElocalization,
  defaultFootings,
  showResults,
  classicFont,
  lightTitle
]{mul-beamer}
```

---

## Custom Commands & Environments

### `\institute[<institute for footings>]{<institute>}`
Set author affiliations. The optional argument overrides the organizational unit shown in footings (`defaultFootings`). Without it, the full `<institute>` is printed in the footer, so always give the optional argument if the affiliations span more than one line (e.g. several affiliations with `\aff{}`).

### `\email{<e-mail address>}`
E-mail address printed (as a link) on the title slide; omitted if not set.

### `\aff{<affiliation>}`
Used after author names to indicate institutional affiliation with a superscript number.

Example:

```latex
\author{Alice Smith\aff{1} \and Bob Jones\aff{2}}
\institute{%
  \aff{1}Department of Materials Science, MUL\\
  \aff{2}Department of Environmental Engineering, MUL
}
```

### `\conference{<conference name>}`
Sets the conference name, printed on the title slide and in footings when using the `fullFootings` option.

### `\lecture{<lecture name>}`
Switches to lecture mode: prints the table of contents at the beginning of each section (lecture overview), and with `fullFootings` shows the current section (and subsection) in the footer. The lecture name itself is shown in the footer only with `lectureFootings`.

This replaces beamer's own `\lecture` command, which remains available as `\lectureBeamer` (see below).

### `\lectureBeamer[<short title>]{<title>}{<label>}`
Beamer's original `\lecture` command, for keeping several lectures in one file. Each lecture starts with `\lectureBeamer` in the document; only the lecture(s) selected with `\includeonlylecture{<label>}` in the preamble (or the class option `lecture=<label>`) are compiled. Within a lecture, beamer's `\insertlecture` and `\insertshortlecture` return its title and short title. It is independent of the lecture mode set by `\lecture{}`; both can be used together. See the beamer manual for details.

Example:

```latex
\lecture{Name of the Course}% lecture mode, name in lectureFootings
\includeonlylecture{lecture2}% compile only the second lecture

\begin{document}
\lectureBeamer[Lecture 1]{Topic of the first lecture}{lecture1}
\begin{frame}{...}...\end{frame}

\lectureBeamer[Lecture 2]{Topic of the second lecture}{lecture2}
\begin{frame}{...}...\end{frame}
\end{document}
```

### `\additionsToTitlePage{<content>}`
Appends custom content (e.g., partner logos, funding agencies) to the title slide, typically defined inside a `tikzpicture` environment.

### `\literature{<literature>}`
Adds literature references to the slide and all following slides. Should be defined outside any `frame` environment.

Remove literature with:

```latex
\literature{}
```

### `\Alert{<content>}`
Complementary to Beamer's `\alert{}`, used to highlight less important content.

### `\funneldisplay`
Changes the font to *Funnel Display* if available.

### `\showResults{<content>}`
Conditionally shows or hides content depending on the `showResults` or `hideResults` class options.

### `\example`
Used instead of `\item` in `itemize` lists: an item marked with a stop sign and starting with *Example:*.

### `\setFrameLogo{<file>}`
Replaces the logo in the top-right corner of the frames, e.g. `\setFrameLogo{graphics/logo-dms.pdf}`. In the preamble or between frames, it applies to all following frames; enclosed in a group `{\setFrameLogo{...} \begin{frame}...\end{frame}}`, it applies to the enclosed frames only.

### `\agendaframe[<title>]`
Adds a slide (between frames) with the table of contents (sections only) in the *Agenda* layout of the MUL PowerPoint master: large title (default: *Inhalt* / *Outline*, depending on the localization), turquoise rule, and the list in the left half of the slide. The footer is kept, the sidebar is hidden on this slide. `\setAgendaTitle{<title>}` (in the preamble) changes the default title, e.g. `\setAgendaTitle{Agenda}`.

### `\personframe[<photo>]{<name>}{<role>}{<text>}`
Adds a slide (between frames) introducing a person, as in the *Zur Person* layout of the MUL PowerPoint master: the photo fills the left part of the slide (cropped to fit; a neutral placeholder if `<photo>` is omitted), name and role at the top right, and `<text>` below (may contain lists). The footer is kept, the sidebar is hidden on this slide.

Example:

```latex
\personframe[figs/photo.jpg]{Name Surname}{Function, Department}{%
  \begin{itemize}
    \item since 2020: current position
    \item research interests: \dots
  \end{itemize}}
```

### `\finalframe[<text>]`
Adds a closing slide (between frames) in the dark style of the MUL PowerPoint master: dark background with white logo, and
- the text (default: *Danke für Ihre Aufmerksamkeit!* / *Thank you for your attention!*, depending on the localization; `\finalframe[Questions?]` for another text, `\setThanksText{<text>}` in the preamble for another default),
- for talks (not in lecture mode) the title and the authors (without affiliations),
- the e-mail address (`\email{}`) and the website (`\website{}`),
- the QR code set by `\setQRcode` (if any),
- a white footer band with the claim and the author line (short author | organisational unit, as in `defaultFootings`).

### `\website[<url>]{<text>}`
Website shown (as a link) on the closing slide; default `unileoben.ac.at`. `<url>` defaults to `https://<text>`, e.g. `\website{www.unileoben.ac.at}` or `\website[https://www.unileoben.ac.at/...]{Group website}`; `\website{}` removes it.

### `\setQRcode[<caption>]{<image file>}`
QR code on the closing slide (bottom right, on a white background), with an optional caption above, e.g. `\setQRcode[Paper]{graphics/qr/paper.png}`. The QR code can link e.g. to the group website or to a published paper.

Creating QR codes: use a generator of **static** QR codes (the link is encoded directly, no redirection service), e.g. <https://www.tu-chemnitz.de/urz/apps/qrcode/index.html.en>: enter the link in the field *Text*, *Create QR Code*, and download it as PNG (directly usable) or SVG (put it into `graphics/`; `make` converts it to PDF using Inkscape). Keep dark modules on a light background. QR codes in the MUL design (with the signet) can be requested from the MUL graphics department (style guide, p. 41). The demo QR code `graphics/qr/qrcode_unileoben.png` links to <https://www.unileoben.ac.at>.

### `\setTitleLogo{<logo>}{<white logo>}`
Replaces the logo on the title page (`<logo>`) and on the dark slides (`<white logo>`), e.g. `\setTitleLogo{graphics/logo-mul}{graphics/logo-mul-white}` for the German logo; see also the options `DElogo`/`ENlogo`.

### `\setSlogan{<text>}`
Replaces the claim on the title page, in the footer, and on the closing slide; `\setSlogan{}` removes it. See also the options `DEslogan`/`ENslogan`.

### `\setThanksText{<text>}`
Replaces the default text of `\finalframe`.

### `\setDarkBackground{<file>}`
Background image of the dark slides (`\finalframe`, title slide with `darkTitle`). Two are provided: `graphics/background_dark_cms.jpg` (default, matching the CMS title page) and `graphics/background_dark.jpg` (from the official PowerPoint master).

### `\lastslide`
Placed between frames, it sets the total number of slides (`slideTotalNumber`) to the number of the preceding frame, so that following (e.g. backup) slides are not counted.

### Environment: `overdraw`
Allows layered drawing over slide content, implemented using TikZ.

Example:

```latex
\begin{overdraw}
  \only<1>{First overlay}
  \only<2>{Second overlay}
\end{overdraw}
```

### `\framegrid`
Draws a visual grid on the slide for precise placement during development (usually turned off for final presentations).

---

## Colors

The colors of the MUL style guide (Brandbook 2026, digital/RGB values) are defined with the same names as in the poster template:

| Group | Names |
| --- | --- |
| primary | `digital_Turquoise`, `digital_GraphiteBlack`, `digital_White`, `digital_LightGreen`, `digital_TechGreen` (digital only) |
| combination | `digital_BTLight`, `digital_BTDark`, `digital_TGLight`, `digital_TGDark`, `digital_GWLight`, `digital_GWDark` (always together with a primary color) |
| secondary | `digital_Violet`, `digital_Orange`, `digital_Blue` (reserved for the study areas) |

The names of earlier versions remain available: `MULgreen` (= `digital_Turquoise`), `MULturquoise` (= `digital_TechGreen`), `MULaddress` (= `digital_GraphiteBlack`). For figures, `plotblue`, `plotgreen`, `plotorange`, `plotred`, `plotpurple`, and `plotbrown` are defined in addition.

---

## Deviations from the Style Guide

The class follows the MUL style guide (Brandbook 2026) and the official PowerPoint master in colors, logos, claim, and the layout of title, frame titles, and footer, with these deliberate deviations for scientific presentations:

- **Text font:** Latin Modern Sans by default instead of Host Grotesk (option `brandFont` follows the guide).
- **Claim on the title slide:** discreet grey instead of turquoise (color `MULsloganTitleColor`, e.g. `\colorlet{MULsloganTitleColor}{digital_Turquoise}`).
- **Alerts:** `\alert{}` and alert blocks are red, which is not part of the brand palette, as the strongest signal for warnings.
- **Font sizes:** text is smaller relative to the slide than in the PowerPoint master, as beamer slides are typically denser.
- **Sidebar:** the optional table-of-contents sidebar is not part of the master (Department of Materials Science design).

---

## Technical Notes

- Requires **XeLaTeX** or **LuaLaTeX** (due to `fontspec` usage).
- Uses *Funnel Display* for headings if available, and *Host Grotesk* for text with the option `brandFont`; both are bundled in `fonts/` (SIL Open Font License 1.1).
- Includes MUL logos and uses a 16:9 aspect ratio layout.

---

## Author & Contact

**David Holec**
david.holec@unileoben.ac.at

---
Current version. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `talk-v3.03-2026`.
