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
| `talk.tex` | talk (conference) | `fullFootings`, `slideTotalNumber`, `\conference{}` shown on the title page and in the footer |
| `lecture.tex` | lecture | `lectureFootings`, `showResults`, `\lecture{}`: table of contents at each section, lecture name in the footer |

Both include `functionality_demo.tex` (via `\input{functionality_demo}`), a set of slides demonstrating the functionality of the class. Remove that line (and the file, together with `figs/demo_*.tex`) when writing your own slides.

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

The slogan can be removed from the title page and footer with `\renewcommand{\MULsloganText}{}`.

### Title Slide
- `lightTitle`
  Light background, turquoise title, grey claim (default).
- `darkTitle`
  Dark background (see `\setDarkBackground`), white logo and text, claim in Light-Green, as the dark title slide of the MUL PowerPoint master. Note that additions by `\additionsToTitlePage` (e.g. partner logos) need to be readable on the dark background.

### Fonts
- `classicFont`
  Latin Modern Sans (beamer default) for text, and for letters, digits, and operator names (`\sin`, `\mathrm{}`) in formulas (default).
- `brandFont`
  Host Grotesk (MUL brand font) for text, and for letters, digits, and operator names in formulas. Fallbacks if the bundled font files in `graphics/` are missing: installed Host Grotesk, Calibri, Carlito, Latin Modern Sans.

Note: the MUL style guide prescribes Host Grotesk for body text. This class nevertheless uses Latin Modern Sans by default, as a deliberate choice for the appearance of (scientific) slides; use `brandFont` to follow the style guide.

In formulas, Greek letters and other symbols are always taken from Computer Modern. Frame titles, the title, and the slogan are always set in Funnel Display (see `\funneldisplay`).

### Extra Functional Options
- `showResults`
  Enables the `\showResults{}` block (default).
- `hideResults`
  Hides the `\showResults{}` block.

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
Adds a closing slide (between frames) in the dark style of the MUL PowerPoint master: dark background with white logo, the text (default: *Danke für Ihre Aufmerksamkeit!* / *Thank you for your attention!*, depending on the localization), the e-mail address set by `\email{}`, and a white footer band with the claim. E.g. `\finalframe[Questions?]`.

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
- Uses *Funnel Display* for headings if available, and *Host Grotesk* for text with the option `brandFont`; both are bundled in `graphics/` (SIL Open Font License 1.1).
- Includes MUL logos and uses a 16:9 aspect ratio layout.

---

## Author & Contact

**David Holec**
david.holec@unileoben.ac.at

---
Current version. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `talk-v3.03-2026`.
