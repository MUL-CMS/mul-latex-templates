# MUL Poster Template

A LaTeX class for creating scientific posters in the Montanuniversität Leoben (MUL) corporate design. Requires **XeLaTeX** or **LuaLaTeX**.

Two layout modes are provided:

| Mode | File | Description |
| --- | --- | --- |
| **GRID** | `poster_grid.tex` | Manual coordinate-based placement using `\GridBox` |
| **FLOW** | `poster_flow.tex` | Automatic vertical column balancing using `\FlowBox` |

---

## Quick Start

```bash
lualatex poster_flow.tex
# or
lualatex poster_grid.tex
```

I STRONGLY encourage checking the QR code for its intended functionality and replace it.

---

## Global Setup

These three commands must appear before `\begin{document}`:

### `\Colors{<mode>}`

Sets the color palette.

| Value | Description |
| --- | --- |
| `Digital` | RGB colors including TechGreen (default) |
| `Print` | CMYK colors; TechGreen is substituted |

```latex
\Colors{Digital}
```

### `\FontMode{<mode>}`

Selects the typography set.

| Value | Description |
| --- | --- |
| `Regular` | Calibri for all text; Times-like math; Funnel Display for claim only |
| `Experimental` | Host Grotesk body text; Funnel Display headings; Host Grotesk math italics |

```latex
\FontMode{Regular}
```

### `\Language{<lang>}`

Sets the poster language. Affects the MUL logo variant and the footer claim text.

| Value | Claim text |
| --- | --- |
| `EN` | Move mountains |
| `DE` | Versetz' Berge |

```latex
\Language{EN}
```

---

## Header Region

All header commands are placed after `\begin{document}\null` and before `\BuildHeader`.

### `\Title{<text>}`

Sets the poster title (max 2 lines recommended). Use `\par` for manual line breaks.

```latex
\Title{My Poster Title\par A Second Line if Needed}
```

### `\HeaderImage{<path>}{<width>}{<height>}`

Places an optional image or logo in the top-right corner of the header ribbon. Comment out or omit entirely if not needed.

```latex
\HeaderImage{graphics/my_logo.png}{\TopRightImageWidth}{\TopRightImageHeight}
```

The predefined lengths `\TopRightImageWidth` and `\TopRightImageHeight` provide sensible defaults. You may also specify explicit dimensions:

```latex
\HeaderImage{graphics/my_logo.png}{60mm}{55mm}
```

### `\Authors{<text>}`

Sets the author line. Use `\textsuperscript{}` for affiliation markers.

```latex
\Authors{A. Smith\textsuperscript{1}, B. Jones\textsuperscript{2}}
```

- Passing an empty argument (`\Authors{}`) renders a slim white banner with no text.
- Omitting the command entirely removes the author section.

### `\Affiliations{<text>}`

Sets affiliation lines. Use `\\` to separate entries.

```latex
\Affiliations{%
    \textsuperscript{1}University of Example, City, Country\\
    \textsuperscript{2}Institute of Research, Town, Country
}
```

### `\Intro{<text>}`

Adds an optional turquoise intro ribbon below the author block (max 2–3 lines recommended). Use `\par` for line breaks.

```latex
\Intro{%
    This poster presents our findings on the effects of temperature
    on composite materials under cyclic loading.
}
```

- Passing an empty argument (`\Intro{}`) renders a slim turquoise banner.
- Omitting the command removes the intro ribbon entirely.

### `\BuildHeader`

Required. Measures and draws the complete top region (header, authors, intro). Call this once, after all header commands.

```latex
\BuildHeader
```

---

## Poster Body

All content goes inside the `PosterBody` environment:

```latex
\begin{PosterBody}
    % content here
\end{PosterBody}
```

---

## GRID Layout

Use `\GridBox` for manual coordinate-based placement.

### `\GridBox{<x>}{<y>}{<width>}{<height>}{<content>}`

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
\GridBox{0}{0}{6}{10}{
    \vGap
    \Header{Introduction}
    \vGap
    \Para{Lorem ipsum dolor sit amet...}
}

% Two-column box starting at column 3
\GridBox{14}{0}{13}{10}{
    \vGap
    \Header{Results}
    \vGap
    \begin{minipage}[t]{\ColumnWidth}
        \Para{Left column text...}
    \end{minipage}%
    \hspace{\ColumnGap}%
    \begin{minipage}[t]{\ColumnWidth}
        \Para{Right column text...}
    \end{minipage}
}
```

Fractional coordinates are allowed:

```latex
\GridBox{0}{10.5}{6}{5.5}{...}
```

### `\ShowGrid`

Enables a visual grid overlay showing cell coordinates. Place after `\BuildHeader`. Comment out for final export.

```latex
\BuildHeader
\ShowGrid
```

### `\FooterGridBox{<x>}{<y>}{<width>}{<height>}{<content>}`

Works like `\GridBox` but uses a separate Y-coordinate system anchored to the footer area. `y = 0` starts at the top of the footer content region.

```latex
\FooterGridBox{0}{0}{27}{1}{
    \Rule
}

\FooterGridBox{0}{1}{13}{4.1}{
    {\HeadingStyle References\par}
    \vspace{5mm}
    \References{
        \textbf{[1].} Author, "Title." \emph{Journal}, 2024.\par
        \textbf{[2].} Author, "Title." \emph{Journal}, 2023.
    }
}
```

---

## FLOW Layout

Use `\FlowBox` for automatic placement across columns.

### `\FlowBox{<span>}{<content>}`

Automatically selects the column with the most available vertical space.

| Parameter | Description |
| --- | --- |
| `span` | Number of columns to span (1–4) |
| `content` | Arbitrary LaTeX content |

```latex
% Auto-placed single-column box
\FlowBox{1}{
    \vGap
    \Header{Introduction}
    \vGap
    \Para{Lorem ipsum dolor sit amet...}
}

% Auto-placed two-column box
\FlowBox{2}{
    \vGap
    \Header{Results}
    \vGap
    \begin{minipage}[t]{\ColumnWidth}
        \Para{Left column...}
    \end{minipage}%
    \hspace{\ColumnGap}%
    \begin{minipage}[t]{\ColumnWidth}
        \Para{Right column...}
    \end{minipage}
}
```

### `\FlowBox{<span>}[<start column>]{<content>}`

Forces placement to start at a specific column (1–4).

```latex
% Two-column box forced to start at column 3
\FlowBox{2}[3]{
    \vGap
    \Image[][graphics/results_plot.png]
}
```

> Note: The footer area in FLOW posters still uses `\FooterGridBox` for precise placement.

---

## Content Commands

These commands work inside both `\GridBox` and `\FlowBox`.

### `\Header{<text>}`

Renders a section heading in turquoise.

```latex
\Header{Methods and Materials}
```

### `\Para{<text>}`

Renders a justified body-text paragraph.

```latex
\Para{Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
sed diam nonumy eirmod tempor invidunt ut labore et dolore magna.}
```

### `\Image`, `\Image[<span>]`, `\Image[<span>][<path>]`, `\Image[<span>][<path>][<height>]`

Inserts an image with flexible width/height control.

| Form | Width | File | Height |
| --- | --- | --- | --- |
| `\Image` | `\linewidth` | placeholder | auto |
| `\Image[2]` | 2-column span | placeholder | auto |
| `\Image[][my_fig.png]` | `\linewidth` | `my_fig.png` | auto |
| `\Image[2][my_fig.png]` | 2-column span | `my_fig.png` | auto |
| `\Image[][my_fig.png][80mm]` | `\linewidth` | `my_fig.png` | 80 mm (forced) |

File paths are resolved in this order:

1. Exact path as given
2. `graphics/<path>`
3. Falls back to `graphics/placeholder_image.png`

```latex
\Image                                  % placeholder, full width
\Image[][graphics/my_chart.pdf]         % custom image, auto aspect ratio
\Image[2][results.png]                  % two-column width, auto height
\Image[][photo.jpg][100mm]              % forced height (may distort)
```

### `\Highlight{<text>}` / `\Highlight[<span>]{<text>}`

Renders text inside a turquoise (30% opacity) highlight box.

```latex
\Highlight{Key finding: composite strength increased by 40\%.}
\Highlight[2]{This highlight spans two poster columns.}
```

### `\Rule` / `\Rule[<span>]`

Draws a horizontal turquoise rule (4 pt thick).

```latex
\Rule          % full width of current box
\Rule[2]       % spans two poster columns
```

Stacking multiple rules of different widths creates a decorative separator:

```latex
\Rule[1]
\vspace{4pt}
\Rule[2]
\vspace{4pt}
\Rule[3]
\vspace{4pt}
\Rule[4]
```

### `\References{<text>}`

Renders text in the small reference style (14 pt).

```latex
\References{
    \textbf{[1].} Smith, A. "Paper Title." \emph{Journal}, 2024.\par
    \textbf{[2].} Jones, B. "Another Paper." \emph{Conf. Proc.}, 2023.
}
```

### `\vGap`

Inserts a vertical gap of `\VGap` (15 mm). Use between content blocks for consistent spacing.

```latex
\vGap
\Header{Section Title}
\vGap
\Para{Content...}
```

---

## Footer Ribbon

### `\BuildBottomRibbon`

Required. Draws the decorative turquoise footer ribbon with the MUL claim text. Place after `\end{PosterBody}`.

```latex
\end{PosterBody}
\BuildBottomRibbon
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
| `\ColumnWidth` | 120 mm | Width of one poster column |
| `\ColumnGap` | 20 mm | Gap between adjacent columns |
| `\GridWidth` | 540 mm | Total body width (4 columns + 3 gaps) |
| `\VGap` | 15 mm | Standard vertical spacing |
| `\MarginLeft` | 27 mm | Left page margin |
| `\MarginRight` | 27 mm | Right page margin |
| `\GridUnitX` | 20 mm | Horizontal grid cell size |
| `\GridUnitY` | 15 mm | Vertical grid cell size |

---

## Available Style Commands

For manual formatting when needed:

| Command | Size | Usage |
| --- | --- | --- |
| `\TitleStyle` | 60 pt | White, display font, bold |
| `\HeadingStyle` | 36 pt | Turquoise, display font |
| `\IntroStyle` | 30 pt | White, text font |
| `\AuthorStyle` | 30 pt | Black, text font, bold |
| `\AffiliationStyle` | 20 pt | Black, text font |
| `\BodyStyle` | 24 pt | Black, text font |
| `\Text` | 24 pt | Alias for `\BodyStyle` |
| `\ReferenceStyle` | 14 pt | Black, text font, small |
| `\ClaimStyle` | 36 pt | Claim font |

---

## Minimal Example (FLOW)

```latex
\documentclass{MUL_poster}

\Colors{Digital}
\FontMode{Regular}
\Language{EN}

\begin{document}
\null

\Title{My Research Poster}
\Authors{A. Researcher\textsuperscript{1}}
\Affiliations{\textsuperscript{1}Montanuniversität Leoben, Austria}
\BuildHeader

\begin{PosterBody}
    \FlowBox{1}{
        \vGap
        \Header{Introduction}
        \vGap
        \Para{This is the introduction to my research.}
    }

    \FlowBox{1}{
        \vGap
        \Header{Methods}
        \vGap
        \Image[][graphics/my_figure.png]
    }

    \FlowBox{2}{
        \vGap
        \Header{Results}
        \vGap
        \Highlight{Key result: 42\% improvement observed.}
    }
\end{PosterBody}

\BuildBottomRibbon
\end{document}
```

---

## File Structure

```text
project/
├── MUL_poster.cls
├── poster_flow.tex
├── poster_grid.tex
├── graphics/
│   ├── logos/
│   │   ├── logo_rgb_EN_white_v1.pdf
│   │   ├── logo_rgb_DE_white_v1.pdf
│   │   └── ...
│   ├── placeholder_image.png
│   ├── qrcode.pdf
│   └── (your images)
├── fonts/
│   ├── Host_Grotesk/
│   │   └── HostGrotesk-*.ttf
│   └── Funnel_Display/
│       └── FunnelDisplay-*.ttf
└── README.md
```

Fonts are resolved with a fallback chain: local project fonts → system-installed fonts → Calibri → Carlito. The template will compile even without the brand fonts installed.
