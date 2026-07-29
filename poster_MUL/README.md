# MUL Poster Template

A LaTeX class for creating scientific posters in the Montanuniversität Leoben (MUL) corporate design. Requires **XeLaTeX** or **LuaLaTeX**.

Two layout modes are provided:

| Mode | File | Description |
| --- | --- | --- |
| **GRID** | `poster_grid.tex` | Manual coordinate-based placement using `\gridbox` |
| **FLOW** | `poster_flow.tex` | Automatic vertical column balancing using `\flowbox` |

---

## Quick Start

```bash
lualatex poster_flow.tex
# or
lualatex poster_grid.tex
```

---

## Global Setup

These three (four) commands must appear before `\begin{document}`:

### `\colors{<mode>}`

Sets the color palette.

| Value | Description |
| --- | --- |
| `Digital` | RGB colors including TechGreen (default) |
| `Print` | CMYK colors; TechGreen is substituted |

```latex
\colors{Digital}
```

### `\fontmode{<mode>}`

Selects the typography set.

| Value | Description |
| --- | --- |
| `Regular` | Calibri for all text; Times-like math; Funnel Display for claim only |
| `Experimental` | Host Grotesk body text; Funnel Display headings; Host Grotesk math italics |

```latex
\fontmode{Regular}
```

### `\lang{<lang>}`

Sets the poster language. Affects the MUL logo variant and the footer claim text.

| Value | Claim text |
| --- | --- |
| `EN` | Move mountains |
| `DE` | Versetz' Berge |

```latex
\lang{EN}
```

### `\qrset{<EN path>}{<DE path>}`

Registers language-specific QR code files. The appropriate file is automatically selected based on the current `\lang` setting. Sensible defaults are provided, so this command is only needed when using custom QR code files.

```latex
% Default (already built in — no need to call explicitly):
\qrset{graphics/qr/qrcode_EN.pdf}{graphics/qr/qrcode_DE.pdf}
% Custom QR codes:
\qrset{graphics/qr/my_project_EN.pdf}{graphics/qr/my_project_DE.pdf}
```

---

## Header Region

All header commands are placed after `\begin{document}\null` and before `\buildheader`.

### `\title{<text>}`

Sets the poster title (max 2 lines recommended). Use `\par` for manual line breaks.

```latex
\title{My Poster Title\par A Second Line if Needed}
```

### `\headerimage{<path>}{<width>}{<height>}`

Places an optional image or logo in the top-right corner of the header ribbon. Comment out or omit entirely if not needed.

```latex
\headerimage{graphics/my_logo.png}{\headerimgwidth}{\headerimgheight}
```

The predefined lengths `\headerimgwidth` and `\headerimgheight` provide sensible defaults. You may also specify explicit dimensions:

```latex
\headerimage{graphics/my_logo.png}{60mm}{55mm}
```

### `\authors{<text>}`

Sets the author line. Use `\textsuperscript{}` for affiliation markers.

```latex
\authors{A. Smith\textsuperscript{1}, B. Jones\textsuperscript{2}}
```

- Passing an empty argument (`\authors{}`) renders a slim white banner with no text.
- Omitting the command entirely removes the author section.

### `\affiliations{<text>}`

Sets affiliation lines. Use `\\` to separate entries.

```latex
\affiliations{%
    \textsuperscript{1}University of Example, City, Country\\
    \textsuperscript{2}Institute of Research, Town, Country
}
```

### `\intro{<text>}`

Adds an optional turquoise intro ribbon below the author block (max 2–3 lines recommended). Use `\par` for line breaks.

```latex
\intro{%
    This poster presents our findings on the effects of temperature
    on composite materials under cyclic loading.
}
```

- Passing an empty argument (`\intro{}`) renders a slim turquoise banner.
- Omitting the command removes the intro ribbon entirely.

### `\buildheader`

Required. Measures and draws the complete top region (header, authors, intro). Call this once, after all header commands.

```latex
\buildheader
```

---

## Poster Body

All content goes inside the `posterbody` environment:

```latex
\begin{posterbody}
    % content here
\end{posterbody}
```

---

## GRID Layout

Use `\gridbox` for manual coordinate-based placement.

### `\gridbox{<x>}{<y>}{<width>}{<height>}{<content>}`

| Parameter | Description |
| --- | --- |
| `x` | Horizontal start (grid units, 0-based from left) |
| `y` | Vertical start (grid units, 0-based from top of body) |
| `width` | Width in grid cells |
| `height` | Height in grid cells |
| `content` | Arbitrary LaTeX content |

Grid geometry:

- Each cell is 20 mm wide × 15 mm tall.
- The poster body has 27 horizontal × variable vertical cells.
- Poster columns align to: `x = 0, 7, 14, 21`.
- Each column spans 6 cells; gaps are at cells 6–7, 13–14, 20–21.

| Span | Grid width |
| --- | --- |
| 1 column | 6 |
| 2 columns + gap | 13 |
| 3 columns + gaps | 20 |
| 4 columns + gaps | 27 |

```latex
% Single column box
\gridbox{0}{0}{6}{10}{
    \vgap
    \sect{Introduction}
    \vgap
    \para{Lorem ipsum dolor sit amet...}
}

% Two-column box starting at column 3
\gridbox{14}{0}{13}{10}{
    \vgap
    \sect{Results}
    \vgap
    \begin{minipage}[t]{\colwidth}
        \para{Left column text...}
    \end{minipage}%
    \hspace{\colgap}%
    \begin{minipage}[t]{\colwidth}
        \para{Right column text...}
    \end{minipage}
}
```

Fractional coordinates are allowed:

```latex
\gridbox{0}{10.5}{6}{5.5}{...}
```

### `\showgrid`

Enables a visual grid overlay showing cell coordinates. Place after `\buildheader`. Comment out for final export.

```latex
\buildheader
\showgrid
```

### `\footergridbox{<x>}{<y>}{<width>}{<height>}{<content>}`

Works like `\gridbox` but uses a separate Y-coordinate system anchored to the footer area. `y = 0` starts at the top of the footer content region.

```latex
\footergridbox{0}{0}{27}{1}{
    \prule
}

\footergridbox{0}{1}{13}{4.1}{
    {\headingstyle References\par}
    \vspace{5mm}
    \references{
        \textbf{[1].} Author, "Title." \emph{Journal}, 2024.\par
        \textbf{[2].} Author, "Title." \emph{Journal}, 2023.
    }
}
```

---

## FLOW Layout

Use `\flowbox` for automatic placement across columns.

### `\flowbox{<span>}{<content>}`

Automatically selects the column with the most available vertical space.

| Parameter | Description |
| --- | --- |
| `span` | Number of columns to span (1–4) |
| `content` | Arbitrary LaTeX content |

```latex
% Auto-placed single-column box
\flowbox{1}{
    \vgap
    \sect{Introduction}
    \vgap
    \para{Lorem ipsum dolor sit amet...}
}

% Auto-placed two-column box
\flowbox{2}{
    \vgap
    \sect{Results}
    \vgap
    \begin{minipage}[t]{\colwidth}
        \para{Left column...}
    \end{minipage}%
    \hspace{\colgap}%
    \begin{minipage}[t]{\colwidth}
        \para{Right column...}
    \end{minipage}
}
```

### `\flowbox{<span>}[<start column>]{<content>}`

Forces placement to start at a specific column (1–4).

```latex
% Two-column box forced to start at column 3
\flowbox{2}[3]{
    \vgap
    \img[][graphics/results_plot.png]
}
```

> Note: The footer area in FLOW posters still uses `\footergridbox` for precise placement.

---

## Content Commands

These commands work inside both `\gridbox` and `\flowbox`.

### `\sect{<text>}`

Renders a section heading in turquoise.

```latex
\sect{Methods and Materials}
```

### `\para{<text>}`

Renders a justified body-text paragraph.

```latex
\para{Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
sed diam nonumy eirmod tempor invidunt ut labore et dolore magna.}
```

### `\img`, `\img[<span>]`, `\img[<span>][<path>]`, `\img[<span>][<path>][<height>]`

Inserts an image with flexible width/height control.

| Form | Width | File | Height |
| --- | --- | --- | --- |
| `\img` | `\linewidth` | placeholder | auto |
| `\img[2]` | 2-column span | placeholder | auto |
| `\img[][my_fig.png]` | `\linewidth` | `my_fig.png` | auto |
| `\img[2][my_fig.png]` | 2-column span | `my_fig.png` | auto |
| `\img[][my_fig.png][80mm]` | `\linewidth` | `my_fig.png` | 80 mm (forced) |

File paths are resolved in this order:

1. Exact path as given
2. `graphics/<path>`
3. Falls back to `graphics/placeholder_image.pdf`

```latex
\img                                  % placeholder, full width
\img[][graphics/my_chart.pdf]         % custom image, auto aspect ratio
\img[2][results.png]                  % two-column width, auto height
\img[][photo.jpg][100mm]              % forced height (may distort)
```

### `\highlight{<text>}` / `\highlight[<span>]{<text>}`

Renders text inside a turquoise (30% opacity) highlight box.

```latex
\highlight{Key finding: composite strength increased by 40\%.}
\highlight[2]{This highlight spans two poster columns.}
```

### `\prule` / `\prule[<span>]`

Draws a horizontal turquoise rule (4 pt thick).

```latex
\prule          % full width of current box
\prule[2]       % spans two poster columns
```

Stacking multiple rules of different widths creates a decorative separator:

```latex
\prule[1]
\vspace{4pt}
\prule[2]
\vspace{4pt}
\prule[3]
\vspace{4pt}
\prule[4]
```

### `\references{<text>}`

Renders text in the small reference style (14 pt).

```latex
\references{
    \textbf{[1].} Smith, A. "Paper Title." \emph{Journal}, 2024.\par
    \textbf{[2].} Jones, B. "Another Paper." \emph{Conf. Proc.}, 2023.
}
```

### `\qr` / `\qr[<width>]`

Inserts the language-appropriate QR code image, as registered by `\qrset`. Defaults to `\linewidth` if no width is given.

```latex
\qr              % full width of current box
\qr[40mm]        % explicit width
```

The QR code file is selected automatically based on \lang{EN} or \lang{DE}. To use custom files, register them with \qrset in the preamble:

```latex
\qrset{graphics/qr/my_project_EN.pdf}{graphics/qr/my_project_DE.pdf}
```

### `\vgap`

Inserts a vertical gap of `\vgaplen` (15 mm). Use between content blocks for consistent spacing.

```latex
\vgap
\sect{Section Title}
\vgap
\para{Content...}
```

---

## Footer Ribbon

### `\buildfooter`

Required. Draws the decorative turquoise footer ribbon with the MUL claim text. Place after `\end{posterbody}`.

```latex
\end{posterbody}
\buildfooter
\end{document}
```

### Custom Department Text

Override `\MUL@FooterLeftText` to display a department name on the left side of the footer ribbon:

```latex
\makeatletter
\def\MUL@FooterLeft@EN{%
    \color{White}Materials %
    \color{LightGreen}Science%
}
\def\MUL@FooterLeft@DE{%
    \color{White}Material %
    \color{LightGreen}Wissenschaften%
}
\renewcommand{\MUL@FooterLeftText}{%
    \csname MUL@FooterLeft@\MUL@Language\endcsname
}
\makeatother
```

---

## Available Lengths

These lengths can be used directly in your content for precise layout:

| Length | Value | Description |
| --- | --- | --- |
| `\colwidth` | 120 mm | Width of one poster column |
| `\colgap` | 20 mm | Gap between adjacent columns |
| `\gridwidth` | 540 mm | Total body width (4 columns + 3 gaps) |
| `\vgaplen` | 15 mm | Standard vertical spacing |
| `\marginleft` | 27 mm | Left page margin |
| `\marginright` | 27 mm | Right page margin |
| `\gridunitx` | 20 mm | Horizontal grid cell size |
| `\gridunity` | 15 mm | Vertical grid cell size |

---

## Available Style Commands

For manual formatting when needed:

| Command | Size | Usage |
| --- | --- | --- |
| `\titlestyle` | 60 pt | White, display font, bold |
| `\headingstyle` | 36 pt | Turquoise, display font |
| `\introstyle` | 30 pt | White, text font |
| `\authorstyle` | 30 pt | Black, text font, bold |
| `\affiliationstyle` | 20 pt | Black, text font |
| `\bodystyle` | 24 pt | Black, text font |
| `\bodyfont` | 24 pt | Alias for `\bodystyle` |
| `\refstyle` | 14 pt | Black, text font, small |
| `\claimstyle` | 36 pt | Claim font |

---

## Minimal Example (FLOW)

```latex
\documentclass{MUL_poster}

\colors{Digital}
\fontmode{Regular}
\lang{EN}

\begin{document}
\null

\title{My Research Poster}
\authors{A. Researcher\textsuperscript{1}}
\affiliations{\textsuperscript{1}Montanuniversität Leoben, Austria}
\buildheader

\begin{posterbody}
    \flowbox{1}{
        \vgap
        \sect{Introduction}
        \vgap
        \para{This is the introduction to my research.}
    }

    \flowbox{1}{
        \vgap
        \sect{Methods}
        \vgap
        \img[][graphics/my_figure.png]
    }

    \flowbox{2}{
        \vgap
        \sect{Results}
        \vgap
        \highlight{Key result: 42\% improvement observed.}
    }
\end{posterbody}

\buildfooter
\end{document}
```

---

## File Structure

```text
project/
├── MUL_poster.cls
├── poster_flow.tex
├── poster_grid.tex
├── figs/
│   └── (your images)
├── graphics/
│   ├── logos/
│   │   ├── logo_rgb_EN_white_v1.pdf
│   │   ├── logo_rgb_DE_white_v1.pdf
│   │   ├── logo_readme.txt
│   │   └── ...
│   ├── qr/
│   │   ├── logo_qr.svg
│   │   ├── qrcode_DE.pdf
│   │   ├── qrcode_EN.pdf
│   │   ├── qrcode_test.pdf
│   ├── placeholder_image.pdf
├── fonts/
│   ├── Host_Grotesk/
│   │   └── HostGrotesk-*.ttf
│   └── Funnel_Display/
│       └── FunnelDisplay-*.ttf
└── README.md
```

Fonts are resolved with a fallback chain: local project fonts → system-installed fonts → Calibri → Carlito. The template will compile even without the brand fonts installed.

---

## Create your own QR code

The official MUL "Brandbook" (style guide) says that one can ask the university design team to provide custom QR codes. Or one could try to create ones own that looks very similar:

### Website used:
https://genqrcode.com/

### Text input:
Link to the website one wants to create the QR code for.

### Design:
Square shape > Diamond shape (third from last)
Inner eye shape > default (first)
Outer eye shape > default (first)

### Frame:
default (none)

### Logo:
The website accepts the provided graphics/qr/logo_qr.svg file.
DO tick the "remove background" option.

### Color:
Square color > #FFFFFF (white)
Background color > #00727D (MUL turquoise)
Inner eye color > #FFFFFF (white)
Outer eye color > #FFFFFF (white)

---
Current version. See [`CHANGELOG.md`](CHANGELOG.md) for the full version history. Frozen at tag `poster-v3.0-2026`.