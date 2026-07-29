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
  Author and short title centered (default).
- `fullFootings`
  Shows author/title, conference/date, slogan, and slide number.

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

### Extra Functional Options
- `showResults`
  Enables the `\showResults{}` block.
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
  defaultFootings
]{mul-beamer}
```

---

## Custom Commands & Environments

### `\institute[<institute for footings>]{<institute>}`
Set author affiliations. The optional argument overrides the organizational unit shown in footings.

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
Similar to `\conference`, but also prints the table of contents at the beginning of each section (lecture overview).

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

## Technical Notes

- Requires **XeLaTeX** or **LuaLaTeX** (due to `fontspec` usage).
- Uses *Funnel Display* font if available; otherwise defaults to sans-serif.
- Includes MUL logos and uses a 16:9 aspect ratio layout.

---

## Author & Contact

**David Holec**
david.holec@unileoben.ac.at

---
Superseded by `v3.01-2025`. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `talk-v3.00-2025`.
