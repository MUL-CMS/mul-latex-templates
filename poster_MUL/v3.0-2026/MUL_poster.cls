\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MUL_poster}[2026/05/01 MUL scientific poster class]

% ============================================================
% Command renaming summary (old → new)
% ============================================================
% SETUP:        \Colors        → \colors
%               \FontMode      → \fontmode
%               \Language       → \lang            (\language is a TeX primitive)
%
% HEADER:       \Title         → \title
%               \Authors       → \authors
%               \Affiliations  → \affiliations
%               \Intro         → \intro
%               \HeaderImage   → \headerimage
%               \BuildHeader   → \buildheader
%
% BODY/LAYOUT:  PosterBody     → posterbody       (environment)
%               \GridBox       → \gridbox
%               \FlowBox       → \flowbox
%               \FooterGridBox → \footergridbox
%               \ShowGrid      → \showgrid
%               \BuildBottomRibbon → \buildfooter
%
% CONTENT:      \Section       → \sect             (\section is LaTeX kernel)
%               \Para          → \para
%               \Image         → \img
%               \Highlight     → \highlight
%               \Rule          → \prule            (\rule is a LaTeX primitive)
%               \References    → \references
%               \vGap          → \vgap
%
% STYLES:       \TitleStyle       → \titlestyle
%               \HeadingStyle     → \headingstyle
%               \IntroStyle       → \introstyle
%               \AuthorStyle      → \authorstyle
%               \AffiliationStyle → \affiliationstyle
%               \BodyStyle        → \bodystyle
%               \Text             → \bodyfont       (\text is amsmath)
%               \ReferenceStyle   → \refstyle
%               \ClaimStyle       → \claimstyle
%
% FONT ALIASES: \TextFont          → \txtfont
%               \TextLightFont     → \txtlightfont
%               \TextMediumFont    → \txtmediumfont
%               \TextSemiBoldFont  → \txtsemiboldfont
%               \TextExtraBoldFont → \txtextraboldfont
%               \DisplayFont       → \dispfont
%               \DisplayLightFont  → \displightfont
%               \DisplayMediumFont → \dispmediumfont
%               \DisplaySemiBoldFont → \dispsemiboldfont
%               \DisplayExtraBoldFont→ \dispextraboldfont
%               \ClaimFont         → \claimfont
%               \TitleWeight       → \titleweight
%               \HeadingWeight     → \headingweight
%               \AuthorWeight      → \authorweight
%               \ClaimWeight       → \claimweight
%
% LENGTHS:      \MarginLeft          → \marginleft
%               \MarginRight         → \marginright
%               \ColumnWidth         → \colwidth
%               \ColumnGap           → \colgap
%               \GridWidth           → \gridwidth
%               \VGap                → \vgaplen
%               \GridUnitX           → \gridunitx
%               \GridUnitY           → \gridunity
%               \TopRightImageWidth  → \headerimgwidth
%               \TopRightImageHeight → \headerimgheight
% ============================================================

% ============================================================
% 0. Engine guard
% ============================================================
\LoadClass{article}

\RequirePackage{iftex}
\ifPDFTeX
    \ClassError{MUL_poster}{XeLaTeX or LuaLaTeX required}{}
\fi

% ============================================================
% 1. Required packages
% ============================================================
\RequirePackage{geometry}
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{calc}
\RequirePackage{unicode-math}
\RequirePackage{ragged2e}
\usetikzlibrary{calc}
\graphicspath{{./}{graphics/}}

\makeatletter

% ============================================================
% 2. Page geometry & global dimensions
% ============================================================

% ------------------------------------------------------------
% 2.1 Page size
% ------------------------------------------------------------
\geometry{
    paperwidth=594mm,
    paperheight=841mm,
    margin=0pt
}

% ------------------------------------------------------------
% 2.2 Layout dimensions (derived from PowerPoint template)
% ------------------------------------------------------------
\newlength{\marginleft}          \setlength{\marginleft}{27mm}
\newlength{\marginright}         \setlength{\marginright}{27mm}
\newlength{\HeaderBandHeight}    \setlength{\HeaderBandHeight}{101.5mm}
\newlength{\FooterBandHeight}    \setlength{\FooterBandHeight}{19mm}

\newlength{\colwidth}            \setlength{\colwidth}{120mm}
\newlength{\colgap}              \setlength{\colgap}{20mm}
\newlength{\gridwidth}           \setlength{\gridwidth}{4\colwidth+3\colgap}

\newlength{\PrimaryLogoWidth}    \setlength{\PrimaryLogoWidth}{80.8mm}
\newlength{\PrimaryLogoHeight}   \setlength{\PrimaryLogoHeight}{0.923\PrimaryLogoWidth}% ratio 880.5/954.0 {74.57mm}

\newlength{\headerimgheight}     \setlength{\headerimgheight}{\PrimaryLogoHeight}
\newlength{\headerimgwidth}      \setlength{\headerimgwidth}{0.75\headerimgheight}

\newlength{\vgaplen}             \setlength{\vgaplen}{15mm}
\newcommand{\vgap}{\vspace*{\vgaplen}}

\newlength{\HighlightInset}      \setlength{\HighlightInset}{4mm}

\newlength{\TitleLeftX}          \setlength{\TitleLeftX}{\marginleft+\PrimaryLogoWidth+15mm}
\newlength{\TitleWidth}          \setlength{\TitleWidth}{\paperwidth-\TitleLeftX-\marginright}

% ============================================================
% 3. Color system
% ============================================================

% ------------------------------------------------------------
% 3.1 Color definitions (Digital RGB + Print CMYK)
% ------------------------------------------------------------

% Digital variants: RGB / HEX-oriented values from the brandbook.
\definecolor{digital_Turquoise}{RGB}{0,114,125} % HEX: #00727d
\definecolor{digital_GraphiteBlack}{RGB}{28,38,41}
\definecolor{digital_White}{RGB}{255,255,255}
\definecolor{digital_LightGreen}{RGB}{136,205,211}
\definecolor{digital_TechGreen}{RGB}{0,255,255}
\definecolor{digital_Violet}{RGB}{149,75,151}
\definecolor{digital_Orange}{RGB}{237,106,91}
\definecolor{digital_Blue}{RGB}{88,165,219}
\definecolor{digital_BTLight}{RGB}{14,76,83}
\definecolor{digital_BTDark}{RGB}{21,57,62}
\definecolor{digital_TGLight}{RGB}{68,160,168}
\definecolor{digital_TGDark}{RGB}{34,137,147}
\definecolor{digital_GWLight}{RGB}{225,242,244}
\definecolor{digital_GWDark}{RGB}{195,230,233}

% Print variants: CMYK-oriented values as listed in the brandbook.
\definecolor{print_Turquoise}{cmyk}{1.00,0.40,0.50,0.00} % HEX: #00727d
\definecolor{print_GraphiteBlack}{cmyk}{0.80,0.60,0.55,0.75}
\definecolor{print_White}{cmyk}{0.00,0.00,0.00,0.00}
\definecolor{print_LightGreen}{cmyk}{0.50,0.00,0.20,0.00}
\definecolor{print_TechGreen}{cmyk}{0.50,0.00,0.20,0.00}% No officially defined CMYK TechGreen; use LightGreen as fallback for now.
\definecolor{print_Violet}{cmyk}{0.50,0.80,0.00,0.00}
\definecolor{print_Orange}{cmyk}{0.00,0.70,0.60,0.00}
\definecolor{print_Blue}{cmyk}{0.65,0.22,0.00,0.00}
\definecolor{print_BTLight}{cmyk}{0.90,0.50,0.52,0.37}
\definecolor{print_BTDark}{cmyk}{0.85,0.55,0.54,0.56}
\definecolor{print_TGLight}{cmyk}{0.75,0.20,0.35,0.00}
\definecolor{print_TGDark}{cmyk}{0.87,0.30,0.42,0.00}
\definecolor{print_GWLight}{cmyk}{0.13,0.00,0.05,0.00}
\definecolor{print_GWDark}{cmyk}{0.25,0.00,0.10,0.00}
% ------------------------------------------------------------
% 3.2 Color mode switch
% ------------------------------------------------------------
\newcommand{\MUL@setDigitalColors}{%
    \colorlet{Turquoise}{digital_Turquoise}%
    \colorlet{GraphiteBlack}{digital_GraphiteBlack}%
    \colorlet{White}{digital_White}%
    \colorlet{LightGreen}{digital_LightGreen}%
    \colorlet{TechGreen}{digital_TechGreen}%
    \colorlet{Violet}{digital_Violet}%
    \colorlet{Orange}{digital_Orange}%
    \colorlet{Blue}{digital_Blue}%
    \colorlet{BTLight}{digital_BTLight}%
    \colorlet{BTDark}{digital_BTDark}%
    \colorlet{TGLight}{digital_TGLight}%
    \colorlet{TGDark}{digital_TGDark}%
    \colorlet{GWLight}{digital_GWLight}%
    \colorlet{GWDark}{digital_GWDark}%
}

\newcommand{\MUL@setPrintColors}{%
    \colorlet{Turquoise}{print_Turquoise}%
    \colorlet{GraphiteBlack}{print_GraphiteBlack}%
    \colorlet{White}{print_White}%
    \colorlet{LightGreen}{print_LightGreen}%
    \colorlet{TechGreen}{print_TechGreen}%
    \colorlet{Violet}{print_Violet}%
    \colorlet{Orange}{print_Orange}%
    \colorlet{Blue}{print_Blue}%
    \colorlet{BTLight}{print_BTLight}%
    \colorlet{BTDark}{print_BTDark}%
    \colorlet{TGLight}{print_TGLight}%
    \colorlet{TGDark}{print_TGDark}%
    \colorlet{GWLight}{print_GWLight}%
    \colorlet{GWDark}{print_GWDark}%
}

\newcommand{\colors}[1]{%
    \ifcsname MUL@set#1Colors\endcsname
        \csname MUL@set#1Colors\endcsname
    \else
        \ClassError{MUL_poster}{Unknown color mode '#1'}{Use 'Print' or 'Digital'.}%
    \fi
}

\colors{Digital}% default, unless an override is applied in the main poster file.

% ============================================================
% 4. Font system
% ============================================================

% ------------------------------------------------------------
% 4.1 Base font families (with fallback chains)
% ------------------------------------------------------------

% --- Host Grotesk (brand body font, Experimental mode) ---
\IfFileExists{fonts/Host_Grotesk/HostGrotesk-Regular.ttf}{%
    \newfontfamily\MUL@HostFont[
        Path=fonts/Host_Grotesk/,
        Extension=.ttf,
        UprightFont=*-Regular,
        ItalicFont=*-Italic,
        BoldFont=*-Bold,
        BoldItalicFont=*-BoldItalic
    ]{HostGrotesk}%
    \newfontfamily\MUL@HostLightFont[Path=fonts/Host_Grotesk/,Extension=.ttf]{HostGrotesk-Light}%
    \newfontfamily\MUL@HostMediumFont[Path=fonts/Host_Grotesk/,Extension=.ttf]{HostGrotesk-Medium}%
    \newfontfamily\MUL@HostSemiBoldFont[Path=fonts/Host_Grotesk/,Extension=.ttf]{HostGrotesk-SemiBold}%
    \newfontfamily\MUL@HostExtraBoldFont[Path=fonts/Host_Grotesk/,Extension=.ttf]{HostGrotesk-ExtraBold}%
}{%
    \IfFontExistsTF{Host Grotesk}{%
        \newfontfamily\MUL@HostFont{Host Grotesk}%
        \newfontfamily\MUL@HostLightFont{Host Grotesk}%
        \newfontfamily\MUL@HostMediumFont{Host Grotesk}%
        \newfontfamily\MUL@HostSemiBoldFont{Host Grotesk}%
        \newfontfamily\MUL@HostExtraBoldFont{Host Grotesk}%
    }{%
        \IfFontExistsTF{Calibri}{%
            \newfontfamily\MUL@HostFont{Calibri}%
            \newfontfamily\MUL@HostLightFont{Calibri}%
            \newfontfamily\MUL@HostMediumFont{Calibri}%
            \newfontfamily\MUL@HostSemiBoldFont{Calibri}%
            \newfontfamily\MUL@HostExtraBoldFont{Calibri}%
        }{%
            \newfontfamily\MUL@HostFont{Carlito}%
            \newfontfamily\MUL@HostLightFont{Carlito}%
            \newfontfamily\MUL@HostMediumFont{Carlito}%
            \newfontfamily\MUL@HostSemiBoldFont{Carlito}%
            \newfontfamily\MUL@HostExtraBoldFont{Carlito}%
        }%
    }%
}

% --- Calibri (Regular mode) ---
\IfFontExistsTF{Calibri}{%
    \newfontfamily\MUL@CalibriFont{Calibri}%
}{%
    \newfontfamily\MUL@CalibriFont{Carlito}%
}

% --- Funnel Display (brand display font + claim) ---
\IfFileExists{fonts/Funnel_Display/FunnelDisplay-Regular.ttf}{%
    \newfontfamily\MUL@FunnelFont[
        Path=fonts/Funnel_Display/,
        Extension=.ttf,
        UprightFont=*-Regular,
        BoldFont=*-Bold
    ]{FunnelDisplay}%
    \newfontfamily\MUL@FunnelBoldFont[Path=fonts/Funnel_Display/,Extension=.ttf]{FunnelDisplay-Bold}%
    \newfontfamily\MUL@FunnelLightFont[Path=fonts/Funnel_Display/,Extension=.ttf]{FunnelDisplay-Light}%
    \newfontfamily\MUL@FunnelMediumFont[Path=fonts/Funnel_Display/,Extension=.ttf]{FunnelDisplay-Medium}%
    \newfontfamily\MUL@FunnelSemiBoldFont[Path=fonts/Funnel_Display/,Extension=.ttf]{FunnelDisplay-SemiBold}%
    \newfontfamily\MUL@FunnelExtraBoldFont[Path=fonts/Funnel_Display/,Extension=.ttf]{FunnelDisplay-ExtraBold}%
}{%
    \IfFontExistsTF{Funnel Display}{%
        \newfontfamily\MUL@FunnelFont{Funnel Display}%
        \newfontfamily\MUL@FunnelBoldFont{Funnel Display}%
        \newfontfamily\MUL@FunnelLightFont{Funnel Display}%
        \newfontfamily\MUL@FunnelMediumFont{Funnel Display}%
        \newfontfamily\MUL@FunnelSemiBoldFont{Funnel Display}%
        \newfontfamily\MUL@FunnelExtraBoldFont{Funnel Display}%
    }{%
        \IfFontExistsTF{Calibri}{%
            \newfontfamily\MUL@FunnelFont{Calibri}%
            \newfontfamily\MUL@FunnelBoldFont{Calibri}%
            \newfontfamily\MUL@FunnelLightFont{Calibri}%
            \newfontfamily\MUL@FunnelMediumFont{Calibri}%
            \newfontfamily\MUL@FunnelSemiBoldFont{Calibri}%
            \newfontfamily\MUL@FunnelExtraBoldFont{Calibri}%
        }{%
            \newfontfamily\MUL@FunnelFont{Carlito}%
            \newfontfamily\MUL@FunnelBoldFont{Carlito}%
            \newfontfamily\MUL@FunnelLightFont{Carlito}%
            \newfontfamily\MUL@FunnelMediumFont{Carlito}%
            \newfontfamily\MUL@FunnelSemiBoldFont{Carlito}%
            \newfontfamily\MUL@FunnelExtraBoldFont{Carlito}%
        }%
    }%
}

% ------------------------------------------------------------
% 4.2 Public font aliases (switched by \fontmode)
% ------------------------------------------------------------
\newcommand{\txtfont}{\MUL@HostFont}
\newcommand{\txtlightfont}{\MUL@HostLightFont}
\newcommand{\txtmediumfont}{\MUL@HostMediumFont}
\newcommand{\txtsemiboldfont}{\MUL@HostSemiBoldFont}
\newcommand{\txtextraboldfont}{\MUL@HostExtraBoldFont}

\newcommand{\dispfont}{\MUL@FunnelFont}
\newcommand{\displightfont}{\MUL@FunnelLightFont}
\newcommand{\dispmediumfont}{\MUL@FunnelMediumFont}
\newcommand{\dispsemiboldfont}{\MUL@FunnelSemiBoldFont}
\newcommand{\dispextraboldfont}{\MUL@FunnelExtraBoldFont}
\newcommand{\claimfont}{\MUL@FunnelBoldFont}

\newcommand{\titleweight}{\bfseries}
\newcommand{\headingweight}{\mdseries}
\newcommand{\authorweight}{\bfseries}
\newcommand{\claimweight}{\bfseries}

% ------------------------------------------------------------
% 4.3 Math font helpers
% ------------------------------------------------------------
\newcommand{\MUL@setRegularMath}{%
    \IfFontExistsTF{TeX Gyre Termes Math}{%
        \setmathfont{TeX Gyre Termes Math}%
    }{%
        \setmathfont{Latin Modern Math}%
    }%
    \IfFontExistsTF{Times New Roman}{%
        \setmathfont[range=it/{latin,Latin,greek,Greek}]{Times New Roman Italic}%
        \setmathrm{Times New Roman}%
    }{}%
}

\newcommand{\MUL@setExperimentalMath}{%
    \setmathfont{Latin Modern Math}%
    \IfFileExists{fonts/Host_Grotesk/HostGrotesk-Italic.ttf}{%
        \setmathfont[
            Path=fonts/Host_Grotesk/,
            Extension=.ttf,
            range=it/{latin,Latin,greek,Greek}
        ]{HostGrotesk-Italic}%
    }{%
        \IfFontExistsTF{Host Grotesk}{%
            \setmathfont[range=it/{latin,Latin,greek,Greek}]{Host Grotesk Italic}%
        }{}%
    }%
}

% ------------------------------------------------------------
% 4.4 Font mode switch
% ------------------------------------------------------------
%   \fontmode{Regular}      — Calibri everywhere, Times math and symbols
%   \fontmode{Experimental} — Host Grotesk body, Funnel Display headings
% ------------------------------------------------------------
\newcommand{\MUL@setRegularFonts}{%
    \renewcommand{\txtfont}{\MUL@CalibriFont}%
    \renewcommand{\txtlightfont}{\MUL@CalibriFont}%
    \renewcommand{\txtmediumfont}{\MUL@CalibriFont}%
    \renewcommand{\txtsemiboldfont}{\MUL@CalibriFont}%
    \renewcommand{\txtextraboldfont}{\MUL@CalibriFont}%
    \renewcommand{\dispfont}{\MUL@CalibriFont}%
    \renewcommand{\displightfont}{\MUL@CalibriFont}%
    \renewcommand{\dispmediumfont}{\MUL@CalibriFont}%
    \renewcommand{\dispsemiboldfont}{\MUL@CalibriFont}%
    \renewcommand{\dispextraboldfont}{\MUL@CalibriFont}%
    \renewcommand{\claimfont}{\MUL@FunnelBoldFont}%
    \renewcommand{\titleweight}{\bfseries}%
    \renewcommand{\headingweight}{\mdseries}%
    \renewcommand{\authorweight}{\bfseries}%
    \renewcommand{\claimweight}{\mdseries}%
    \MUL@setRegularMath
}

\newcommand{\MUL@setExperimentalFonts}{%
    \renewcommand{\txtfont}{\MUL@HostFont}%
    \renewcommand{\txtlightfont}{\MUL@HostLightFont}%
    \renewcommand{\txtmediumfont}{\MUL@HostMediumFont}%
    \renewcommand{\txtsemiboldfont}{\MUL@HostSemiBoldFont}%
    \renewcommand{\txtextraboldfont}{\MUL@HostExtraBoldFont}%
    \renewcommand{\dispfont}{\MUL@FunnelFont}%
    \renewcommand{\displightfont}{\MUL@FunnelLightFont}%
    \renewcommand{\dispmediumfont}{\MUL@FunnelMediumFont}%
    \renewcommand{\dispsemiboldfont}{\MUL@FunnelSemiBoldFont}%
    \renewcommand{\dispextraboldfont}{\MUL@FunnelExtraBoldFont}%
    \renewcommand{\claimfont}{\MUL@FunnelBoldFont}%
    \renewcommand{\titleweight}{\bfseries}%
    \renewcommand{\headingweight}{\mdseries}%
    \renewcommand{\authorweight}{\bfseries}%
    \renewcommand{\claimweight}{\mdseries}%
    \MUL@setExperimentalMath
}

\newcommand{\fontmode}[1]{%
    \ifcsname MUL@set#1Fonts\endcsname
        \csname MUL@set#1Fonts\endcsname
    \else
        \ClassError{MUL_poster}{Unknown font mode '#1'}{Use 'Regular' or 'Experimental'.}%
    \fi
}

\fontmode{Regular}% default

% ============================================================
% 5. Typography styles & text helpers
% ============================================================

% ------------------------------------------------------------
% 5.1 Named styles
% ------------------------------------------------------------
\newcommand{\titlestyle}{\dispfont\titleweight\color{White}\fontsize{60pt}{66pt}\selectfont}
\newcommand{\headingstyle}{\dispfont\headingweight\color{Turquoise}\fontsize{36pt}{43.2pt}\selectfont}
\newcommand{\introstyle}{\txtfont\color{White}\fontsize{30pt}{36pt}\selectfont}
\newcommand{\authorstyle}{\txtfont\authorweight\color{black}\fontsize{30pt}{36pt}\selectfont}
\newcommand{\affiliationstyle}{\txtfont\mdseries\color{black}\fontsize{20pt}{24pt}\selectfont}
\newcommand{\bodystyle}{\txtfont\color{black}\fontsize{24pt}{28.8pt}\selectfont}
\newcommand{\bodyfont}{\txtfont\color{black}\fontsize{24pt}{28.8pt}\selectfont}
\newcommand{\refstyle}{\txtfont\color{black}\noindent\fontsize{14pt}{16.8pt}\selectfont}
\newcommand{\claimstyle}{\claimfont\claimweight\noindent\fontsize{36pt}{28.8pt}\selectfont}

% ------------------------------------------------------------
% 5.2 Public text helpers
% ------------------------------------------------------------
\newcommand{\para}[1]{{\bodystyle\justifying\noindent #1\par}}
\newcommand{\references}[1]{{\refstyle\RaggedRight #1\par}}

% ============================================================
% 6. Logo & language system
% ============================================================

% ------------------------------------------------------------
% 6.1 Language selection
% ------------------------------------------------------------
\newcommand{\lang}[1]{\def\MUL@Language{#1}}
\providecommand{\MUL@Language}{EN}

% ------------------------------------------------------------
% 6.2 Logo command
% ------------------------------------------------------------
% Logos in graphics/logos/logo_rgb_<lang>_<color>_<variant>.pdf
% Usage: \logo[width=80mm]{white}{v1}
\newcommand{\logo}[3][]{\includegraphics[#1]{graphics/logos/logo_rgb_\MUL@Language_#2_#3.pdf}}

% ------------------------------------------------------------
% 6.3 Footer claim & department text (language-dependent)
% ------------------------------------------------------------
\def\MUL@Claim@EN{Move mountains}
\def\MUL@Claim@DE{Versetz' Berge}
\newcommand{\MUL@ClaimText}{\csname MUL@Claim@\MUL@Language\endcsname}

\newcommand{\MUL@FooterLeftText}{}% default empty; override in main file

% ------------------------------------------------------------
% 6.4 Language-aware QR code
% ------------------------------------------------------------
\def\MUL@qr@EN{graphics/qr/qrcode_EN.pdf}% default
\def\MUL@qr@DE{graphics/qr/qrcode_DE.pdf}% default

\newcommand{\qrset}[2]{%
    \def\MUL@qr@EN{#1}%
    \def\MUL@qr@DE{#2}%
}

\NewDocumentCommand{\qr}{ O{\linewidth} }{%
    \includegraphics[width=#1]{\csname MUL@qr@\MUL@Language\endcsname}%
}

% ============================================================
% 7. Header content commands
% ============================================================

% ------------------------------------------------------------
% 7.1 Title
% ------------------------------------------------------------
\def\MUL@titleText{}
\renewcommand{\title}[1]{\gdef\MUL@titleText{#1}}

% ------------------------------------------------------------
% 7.2 Authors & affiliations
% ------------------------------------------------------------
\def\MUL@authorText{}
\def\MUL@affiliationText{}
\newif\ifMUL@hasAuthors  \MUL@hasAuthorsfalse

\newcommand{\authors}[1]{%
    \global\MUL@hasAuthorstrue
    \gdef\MUL@authorText{#1}%
}
\newcommand{\affiliations}[1]{%
    \global\MUL@hasAuthorstrue
    \gdef\MUL@affiliationText{#1}%
}

% ------------------------------------------------------------
% 7.3 Intro ribbon
% ------------------------------------------------------------
\def\MUL@introText{}
\newif\ifMUL@hasIntro  \MUL@hasIntrofalse

\newcommand{\intro}[1]{%
    \global\MUL@hasIntrotrue
    \gdef\MUL@introText{#1}%
}

% ------------------------------------------------------------
% 7.4 Optional top-right header image
% ------------------------------------------------------------
\def\MUL@topRightImageFile{}
\newif\ifMUL@hasTopRightImage  \MUL@hasTopRightImagefalse

\newcommand{\headerimage}[3]{%
    \MUL@hasTopRightImagetrue
    \gdef\MUL@topRightImageFile{#1}%
    \setlength{\headerimgwidth}{#2}%
    \setlength{\headerimgheight}{#3}%
}

% ============================================================
% 8. Header measurement & drawing
% ============================================================

\newsavebox{\MUL@authorBox}
\newsavebox{\MUL@introBox}
\newlength{\AuthorHeight}   \setlength{\AuthorHeight}{0pt}
\newlength{\IntroHeight}    \setlength{\IntroHeight}{0pt}
\newlength{\AuthorPadding}  \setlength{\AuthorPadding}{7.6mm}
\newlength{\IntroPadding}   \setlength{\IntroPadding}{4.5mm}
\newlength{\AuthorGap}      \setlength{\AuthorGap}{1.25mm}
\newlength{\BodyTopY}       \setlength{\BodyTopY}{0pt}

% ------------------------------------------------------------
% 8.1 Measure top blocks
% ------------------------------------------------------------
\newcommand{\MUL@measureTopBlocks}{%
    % --- Author block ---
    \setlength{\AuthorHeight}{0pt}%
    \ifMUL@hasAuthors
        \sbox{\MUL@authorBox}{%
            \begin{minipage}{\gridwidth}
                \RaggedRight
                {\authorstyle\MUL@authorText\par}%
                \vspace{\AuthorGap}%
                {\affiliationstyle
                    \let\MUL@savedBreak\\%
                    \def\\{\MUL@savedBreak\strut\ignorespaces}%
                    \MUL@affiliationText
                }%
            \end{minipage}%
        }%
        \setlength{\AuthorHeight}{\ht\MUL@authorBox+\dp\MUL@authorBox}%
        \addtolength{\AuthorHeight}{2\AuthorPadding}%
    \fi
    % --- Intro block ---
    \setlength{\IntroHeight}{0pt}%
    \ifMUL@hasIntro
        \sbox{\MUL@introBox}{%
            \begin{minipage}{\gridwidth}
                \RaggedRight{\introstyle\MUL@introText\par}%
            \end{minipage}%
        }%
        \setlength{\IntroHeight}{\ht\MUL@introBox+\dp\MUL@introBox}%
        \addtolength{\IntroHeight}{2\IntroPadding}%
    \fi
    % --- Body top Y ---
    \setlength{\BodyTopY}{\paperheight-\HeaderBandHeight-\AuthorHeight-\IntroHeight}%
}

% ------------------------------------------------------------
% 8.2 Draw header
% ------------------------------------------------------------
\newcommand{\MUL@drawHeader}{%
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
        % Turquoise header ribbon
        \fill[Turquoise] (0,\paperheight-\HeaderBandHeight) rectangle (\paperwidth,\paperheight);
        % Top-left institutional logo
        \node at (\marginleft+0.5\PrimaryLogoWidth,\paperheight-0.5\HeaderBandHeight)
            {\logo[width=\PrimaryLogoWidth,height=\PrimaryLogoHeight]{white}{v1}};
        % Title
        \node[anchor=west, inner sep=0pt] at (\TitleLeftX,\paperheight-0.5\HeaderBandHeight)
            {\begin{minipage}[c][\HeaderBandHeight][c]{\TitleWidth}
                \RaggedRight\titlestyle\MUL@titleText
            \end{minipage}};
        % Optional top-right image
        \ifMUL@hasTopRightImage
            \node[anchor=east, inner sep=0pt] at (\paperwidth-\marginright,\paperheight-0.5\HeaderBandHeight)
                {\includegraphics[width=\headerimgwidth, height=\headerimgheight]{\MUL@topRightImageFile}};
        \fi
        % Author block
        \ifdim\AuthorHeight>0pt
            \node[anchor=north west] at (\marginleft,\paperheight-\HeaderBandHeight-\AuthorPadding)
                {\usebox{\MUL@authorBox}};
        \fi
        % Intro ribbon
        \ifdim\IntroHeight>0pt
            \fill[Turquoise] (0,\paperheight-\HeaderBandHeight-\AuthorHeight-\IntroHeight)
                rectangle
                (\paperwidth,\paperheight-\HeaderBandHeight-\AuthorHeight);
            \node[anchor=north west, inner sep=0pt] at (\marginleft,\paperheight-\HeaderBandHeight-\AuthorHeight-\IntroPadding)
                {\usebox{\MUL@introBox}};
        \fi
    \end{tikzpicture}
}

% ------------------------------------------------------------
% 8.3 Public build command
% ------------------------------------------------------------
\newcommand{\buildheader}{%
    \MUL@measureTopBlocks
    \MUL@drawHeader
}

% ============================================================
% 9. Grid system
% ============================================================

% ------------------------------------------------------------
% 9.1 Grid units & debug flag
% ------------------------------------------------------------
\newlength{\gridunitx}  \setlength{\gridunitx}{20mm}
\newlength{\gridunity}  \setlength{\gridunity}{\vgaplen}% 15mm

\newif\ifMUL@showGrid  \MUL@showGridfalse

% ------------------------------------------------------------
% 9.2 Grid overlay drawing
% ------------------------------------------------------------
\newcount\MUL@gridCol
\newcount\MUL@gridRow
\newdimen\MUL@gridX
\newdimen\MUL@gridY
\newdimen\MUL@gridBottomY
\newdimen\MUL@gridLabelY
\newdimen\MUL@gridLabelX

\newcommand{\MUL@drawGrid}{%
    \ifMUL@showGrid
        \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
            % Vertical extent
            \MUL@gridBottomY=\FooterBandHeight
            % X-axis label baseline
            \MUL@gridLabelY=\BodyTopY
            \advance\MUL@gridLabelY by -0.5\gridunity
            % --- Vertical grid lines + x labels ---
            \MUL@gridCol=0
            \MUL@gridX=\marginleft
            \loop
                \ifnum\MUL@gridCol<28
                    \ifodd\MUL@gridCol
                        \draw[color=black, opacity=0.2, line width=0.2pt]
                            (\MUL@gridX, \BodyTopY) -- (\MUL@gridX, \MUL@gridBottomY);
                    \else
                        \draw[color=red, opacity=0.2, line width=0.2pt]
                            (\MUL@gridX, \BodyTopY) -- (\MUL@gridX, \MUL@gridBottomY);
                    \fi
                    \node[anchor=center, fill=White] at (\MUL@gridX, \MUL@gridLabelY)
                        {{\txtfont\fontsize{14pt}{14pt}\selectfont\color{black}\the\MUL@gridCol}};
                    \advance\MUL@gridCol by 1
                    \advance\MUL@gridX by \gridunitx
                \repeat
            % --- Strong column-structure lines ---
            \foreach \x in {0,6,7,13,14,20,21,27} {%
                \draw[Turquoise, opacity=1.0, line width=1.0pt]
                    (\marginleft+\x\gridunitx, \BodyTopY) --
                    (\marginleft+\x\gridunitx, \MUL@gridBottomY);
            }
            % --- Horizontal grid lines + y labels ---
            \MUL@gridRow=0
            \MUL@gridY=\BodyTopY
            \MUL@gridLabelX=\marginleft
            \loop
                \ifdim\MUL@gridY>\MUL@gridBottomY
                    \ifodd\MUL@gridRow
                        \draw[color=black, opacity=0.2, line width=0.2pt]
                            (\marginleft, \MUL@gridY) --
                            (\marginleft+\gridwidth, \MUL@gridY);
                    \else
                        \draw[color=red, opacity=0.2, line width=0.2pt]
                            (\marginleft, \MUL@gridY) --
                            (\marginleft+\gridwidth, \MUL@gridY);
                    \fi
                    \node[anchor=east] at (\MUL@gridLabelX-1mm, \MUL@gridY)
                        {{\txtfont\fontsize{14pt}{14pt}\selectfont\color{black}\the\MUL@gridRow}};
                    \node[anchor=west] at (\MUL@gridLabelX+\gridwidth+1mm, \MUL@gridY)
                        {{\txtfont\fontsize{14pt}{14pt}\selectfont\color{black}\the\MUL@gridRow}};
                    \advance\MUL@gridRow by 1
                    \advance\MUL@gridY by -\gridunity
                \repeat
        \end{tikzpicture}
    \fi
}

\newcommand{\showgrid}{%
    \global\MUL@showGridtrue
    \MUL@drawGrid
}

% ------------------------------------------------------------
% 9.3 gridbox placement command
% ------------------------------------------------------------
% Usage: \gridbox{x}{y}{width}{height}{<content>}
% Coordinates in grid units from top-left of body area.

\newdimen\MUL@gridBoxX
\newdimen\MUL@gridBoxY
\newdimen\MUL@gridBoxW
\newdimen\MUL@gridBoxH
\newdimen\MUL@gridBoxRight
\newdimen\MUL@gridBoxBottom

\NewDocumentCommand{\gridbox}{ m m m m +m }{%
    \begingroup
    % ----------------------------------------------------------
    % Compute physical position (fractional-safe)
    % ----------------------------------------------------------
    % Left edge: marginleft + x * gridunitx
    \setlength{\MUL@gridBoxX}{%
        \dimexpr
        \marginleft + (#1\gridunitx)
        \relax
    }
    % Top edge: BodyTopY - y * gridunity
    \setlength{\MUL@gridBoxY}{%
        \dimexpr
        \BodyTopY - (#2\gridunity)
        \relax
    }
    % Width: w * gridunitx
    \setlength{\MUL@gridBoxW}{%
        \dimexpr
        #3\gridunitx
        \relax
    }
    % Height: h * gridunity
    \setlength{\MUL@gridBoxH}{%
        \dimexpr
        #4\gridunity
        \relax
    }
    % Right and bottom edges (for outline)
    \setlength{\MUL@gridBoxRight}{%
        \dimexpr
        \MUL@gridBoxX + \MUL@gridBoxW
        \relax
    }
    \setlength{\MUL@gridBoxBottom}{%
        \dimexpr
        \MUL@gridBoxY - \MUL@gridBoxH
        \relax
    }
    % ----------------------------------------------------------
    % Place content
    % ----------------------------------------------------------
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
    \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (\MUL@gridBoxX, \MUL@gridBoxY) {%
        \begin{minipage}[t][\MUL@gridBoxH][t]{\MUL@gridBoxW}%
        #5%
        \end{minipage}%
    };
    % --------------------------------------------------------
    % gridbox outline, enabled by \showgrid
    % --------------------------------------------------------
    \ifMUL@showGrid
        \draw[color=black, opacity=1, line width=2pt]
        (\MUL@gridBoxX, \MUL@gridBoxY)
        rectangle
        (\MUL@gridBoxRight, \MUL@gridBoxBottom);
        \draw[color=yellow, opacity=1, line width=1pt, dashed]
        (\MUL@gridBoxX, \MUL@gridBoxY)
        rectangle
        (\MUL@gridBoxRight, \MUL@gridBoxBottom);
    \fi
    \end{tikzpicture}
    \endgroup
}

% ------------------------------------------------------------
% 9.4 Footer grid origin & footergridbox
% ------------------------------------------------------------
\newlength{\FooterGridTopOffset}  \setlength{\FooterGridTopOffset}{77mm}
\newlength{\FooterTopY}
\setlength{\FooterTopY}{\dimexpr\FooterBandHeight+\FooterGridTopOffset\relax}

% Usage: \footergridbox{x}{y}{width}{height}{<content>}

\newdimen\MUL@footerGridBoxX
\newdimen\MUL@footerGridBoxY
\newdimen\MUL@footerGridBoxW
\newdimen\MUL@footerGridBoxH
\newdimen\MUL@footerGridBoxRight
\newdimen\MUL@footerGridBoxBottom

\NewDocumentCommand{\footergridbox}{ m m m m +m }{%
    \begingroup
    % Keep footer-grid origin synchronized with the current offset.
    \setlength{\FooterTopY}{\dimexpr\FooterBandHeight+\FooterGridTopOffset\relax}%
    % ----------------------------------------------------------
    % Compute physical position
    % ----------------------------------------------------------
    % Left edge:
    %   marginleft + x * gridunitx
    \setlength{\MUL@footerGridBoxX}{%
        \dimexpr\marginleft + #1\gridunitx\relax
    }%
    % Top edge:
    %   FooterGridTopY - y * gridunity
    \setlength{\MUL@footerGridBoxY}{%
        \dimexpr\FooterTopY - #2\gridunity\relax
    }%
    % Width:
    %   w * gridunitx
    \setlength{\MUL@footerGridBoxW}{%
        \dimexpr#3\gridunitx\relax
    }%
    % Height:
    %   h * gridunity
    \setlength{\MUL@footerGridBoxH}{%
        \dimexpr#4\gridunity\relax
    }%
    % Right and bottom edges for optional outline.
    \setlength{\MUL@footerGridBoxRight}{%
        \dimexpr\MUL@footerGridBoxX+\MUL@footerGridBoxW\relax
    }%
    \setlength{\MUL@footerGridBoxBottom}{%
        \dimexpr\MUL@footerGridBoxY-\MUL@footerGridBoxH\relax
    }%
    % ----------------------------------------------------------
    % Place content
    % ----------------------------------------------------------
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
    \node[anchor=north west, inner sep=0pt, outer sep=0pt] at (\MUL@footerGridBoxX, \MUL@footerGridBoxY) {%
        \begin{minipage}[t][\MUL@footerGridBoxH][t]{\MUL@footerGridBoxW}%
        #5%
        \end{minipage}%
    };

    % --------------------------------------------------------
    % Optional outline, enabled by \showgrid
    % --------------------------------------------------------
    \ifMUL@showGrid
        \draw[color=black, opacity=1, line width=2pt]
        (\MUL@footerGridBoxX, \MUL@footerGridBoxY)
        rectangle
        (\MUL@footerGridBoxRight, \MUL@footerGridBoxBottom);
        \draw[color=yellow, opacity=1, line width=1pt, dashed]
        (\MUL@footerGridBoxX, \MUL@footerGridBoxY)
        rectangle
        (\MUL@footerGridBoxRight, \MUL@footerGridBoxBottom);
    \fi
    \end{tikzpicture}
    \endgroup
}

% ============================================================
% 10. Flow system
% ============================================================

% ------------------------------------------------------------
% 10.1 Flow cursor state & initialization
% ------------------------------------------------------------

\newcount\MUL@flowBestStart
\newcount\MUL@flowLoopCol
\newcount\MUL@flowLoopRemaining

\newdimen\MUL@flowY@one
\newdimen\MUL@flowY@two
\newdimen\MUL@flowY@three
\newdimen\MUL@flowY@four

\newdimen\MUL@flowBestY
\newdimen\MUL@flowCandidateY
\newdimen\MUL@flowPlacementY
\newdimen\MUL@flowBoxHeight
\newdimen\MUL@flowNewY

\newcommand{\MUL@flowInit}{%
    \global\MUL@flowY@one=\BodyTopY
    \global\MUL@flowY@two=\BodyTopY
    \global\MUL@flowY@three=\BodyTopY
    \global\MUL@flowY@four=\BodyTopY
}

\newcommand{\MUL@getFlowY}[1]{%
    \ifcase#1\relax
        \or \MUL@flowY@one
        \or \MUL@flowY@two
        \or \MUL@flowY@three
        \or \MUL@flowY@four
    \fi
}

\newcommand{\MUL@setFlowY}[2]{%
    \ifcase#1\relax
        \or \global\MUL@flowY@one=#2\relax
        \or \global\MUL@flowY@two=#2\relax
        \or \global\MUL@flowY@three=#2\relax
        \or \global\MUL@flowY@four=#2\relax
    \fi
}

\newcommand{\MUL@computeFlowCandidateY}[2]{%
    \MUL@flowLoopCol=#1\relax
    \MUL@flowLoopRemaining=#2\relax

    \MUL@flowCandidateY=\MUL@getFlowY{\the\MUL@flowLoopCol}\relax

    \advance\MUL@flowLoopRemaining by -1\relax

    \loop
        \ifnum\MUL@flowLoopRemaining>0\relax
            \advance\MUL@flowLoopCol by 1\relax

            \ifdim\MUL@getFlowY{\the\MUL@flowLoopCol}<\MUL@flowCandidateY
                \MUL@flowCandidateY=\MUL@getFlowY{\the\MUL@flowLoopCol}\relax
            \fi

            \advance\MUL@flowLoopRemaining by -1\relax
        \repeat
}

\newcommand{\MUL@considerFlowStart}[2]{%
    \MUL@computeFlowCandidateY{#1}{#2}%
    \ifdim\MUL@flowCandidateY>\MUL@flowBestY
        \MUL@flowBestY=\MUL@flowCandidateY
        \MUL@flowBestStart=#1\relax
    \fi
}

% ------------------------------------------------------------
% 10.2 Flow placement logic
% ------------------------------------------------------------

\newcommand{\MUL@selectFlowStart}[1]{%
    \MUL@flowBestStart=1\relax
    \MUL@computeFlowCandidateY{1}{#1}%
    \MUL@flowBestY=\MUL@flowCandidateY
    \ifnum#1<4\relax
        \MUL@considerFlowStart{2}{#1}%
    \fi
    \ifnum#1<3\relax
        \MUL@considerFlowStart{3}{#1}%
    \fi
    \ifnum#1<2\relax
        \MUL@considerFlowStart{4}{#1}%
    \fi
}

\NewDocumentCommand{\MUL@FlowPlace}{ m m m }{%
    \begingroup
    \MUL@computeBlock{#1}{#2}{0}%
    \sbox{\MUL@tempBox}{%
        \begin{minipage}[t]{\MUL@blockWidth}%
        #3%
        \end{minipage}%
    }%
    \MUL@computeFlowCandidateY{#1}{#2}%
    \MUL@flowPlacementY=\MUL@flowCandidateY
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
    \node[anchor=north west, inner sep=0pt] at (\MUL@blockX,\MUL@flowPlacementY)
    {\usebox{\MUL@tempBox}};
    \end{tikzpicture}
    \MUL@flowBoxHeight=\ht\MUL@tempBox
    \advance\MUL@flowBoxHeight by \dp\MUL@tempBox
    \MUL@flowNewY=\MUL@flowPlacementY
    \advance\MUL@flowNewY by -\MUL@flowBoxHeight
    \MUL@flowLoopCol=#1\relax
    \MUL@flowLoopRemaining=#2\relax
    \loop
        \ifnum\MUL@flowLoopRemaining>0\relax
            \MUL@setFlowY{\the\MUL@flowLoopCol}{\MUL@flowNewY}%
            \advance\MUL@flowLoopCol by 1\relax
            \advance\MUL@flowLoopRemaining by -1\relax
        \repeat
    \endgroup
}

% ------------------------------------------------------------
% 10.3 Public flowbox command
% ------------------------------------------------------------
\newcount\MUL@startIndex
\newcount\MUL@spanIndex

\NewDocumentCommand{\flowbox}{ m o m }{%
    \IfNoValueTF{#2}{%
        \MUL@selectFlowStart{#1}%
        \MUL@FlowPlace{\the\MUL@flowBestStart}{#1}{#3}%
    }{%
        \MUL@FlowPlace{#2}{#1}{#3}%
    }%
}

% ============================================================
% 11. posterbody environment
% ============================================================

\newenvironment{posterbody}{}{}

% Wrap with flow initialization when flow system is active
\let\MUL@origposterbody\posterbody
\let\endMUL@origposterbody\endposterbody

\renewenvironment{posterbody}{%
    \MUL@origposterbody
    \MUL@flowInit
}{%
    \endMUL@origposterbody
}

% ============================================================
% 12. Content helpers: sect, highlight, prule, img
% ============================================================

% ------------------------------------------------------------
% 12.1 Section header
% ------------------------------------------------------------
\newcommand{\sect}[1]{%
    \par\noindent
    \begin{minipage}[t]{\linewidth}
        \headingstyle #1
    \end{minipage}\par
}

% ------------------------------------------------------------
% 12.2 Helper-width computation (shared by img, highlight, prule)
% ------------------------------------------------------------
%   span 1 -> \colwidth
%   span 2 -> 2\colwidth + 1\colgap
%   span N -> N\colwidth + (N-1)\colgap
\newlength{\MUL@blockX}
\newlength{\MUL@blockY}
\newlength{\MUL@blockWidth}
\newlength{\ImageWidth}
\newlength{\RuleWidth}
\newsavebox{\MUL@tempBox}

\newcommand{\MUL@computeBlock}[3]{%
    \MUL@startIndex=#1\relax
    \advance\MUL@startIndex by -1
    \setlength{\MUL@blockX}{\marginleft}%
    \addtolength{\MUL@blockX}{\MUL@startIndex\colwidth}%
    \addtolength{\MUL@blockX}{\MUL@startIndex\colgap}%
    \MUL@spanIndex=#2\relax
    \setlength{\MUL@blockWidth}{\MUL@spanIndex\colwidth}%
    \advance\MUL@spanIndex by -1
    \addtolength{\MUL@blockWidth}{\MUL@spanIndex\colgap}%
    \setlength{\MUL@blockY}{\BodyTopY}%
}

\newcommand{\MUL@computeHelperWidth}[2]{%
    \MUL@spanIndex=#1\relax
    \setlength{#2}{\MUL@spanIndex\colwidth}%
    \advance\MUL@spanIndex by -1\relax
    \ifnum\MUL@spanIndex>0
        \addtolength{#2}{\MUL@spanIndex\colgap}%
    \fi
}

% ------------------------------------------------------------
% 12.3 Highlight block
% ------------------------------------------------------------
\newlength{\HighlightWidth}

% Usage:
%   \highlight{<content>}
%   \highlight[<span>]{<content>}

\NewDocumentCommand{\highlight}{ o +m }{%
    \begingroup
    % Default: use the width of the surrounding box/minipage.
    \setlength{\HighlightWidth}{\linewidth}%
    % Optional override:
    % - no optional argument: keep \linewidth
    % - empty optional argument []: keep \linewidth
    % - non-empty optional argument [<span>]: use physical column width
    \IfNoValueF{#1}{%
        \if\relax\detokenize{#1}\relax
            % Empty optional argument: keep default \linewidth.
        \else
            \MUL@computeHelperWidth{#1}{\HighlightWidth}%
        \fi
    }%
    \par\noindent
    \begin{tikzpicture}
        \node[anchor=north west, inner sep=\HighlightInset, outer sep=0pt, fill=Turquoise, fill opacity=0.3, text opacity=1] {%
        \begin{minipage}[t]{\dimexpr\HighlightWidth-2\HighlightInset\relax}
            \bodystyle\noindent\justifying #2
        \end{minipage}%
        };
    \end{tikzpicture}%
    \par
    \endgroup
}

% ------------------------------------------------------------
% 12.4 Poster rule
% ------------------------------------------------------------

\NewDocumentCommand{\prule}{ o }{%
    \begingroup
    % Default: use the width of the surrounding box/minipage.
    \setlength{\RuleWidth}{\linewidth}%
    % Optional override:
    % - no optional argument: keep \linewidth
    % - empty optional argument []: keep \linewidth
    % - non-empty optional argument [<span>]: use physical column width
    \IfNoValueF{#1}{%
        \if\relax\detokenize{#1}\relax
            % Empty optional argument: keep default \linewidth.
        \else
            \MUL@computeHelperWidth{#1}{\RuleWidth}%
        \fi
    }%
    \par\noindent
    {\color{Turquoise}\rule{\RuleWidth}{4pt}}%
    \par
    \endgroup
}

% ------------------------------------------------------------
% 12.5 Image
% ------------------------------------------------------------
% Usage:
%   \img                          — placeholder at \linewidth
%   \img[<span>]                  — placeholder at column span width
%   \img[<span>][<path>]          — custom image, auto height
%   \img[<span>][<path>][<height>] — custom image, forced height
%
% File resolution: tries exact path, then graphics/<path>,
% then falls back to placeholder.
\NewDocumentCommand{\img}{ o o o }{%
    \begingroup
        % Width
        \setlength{\ImageWidth}{\linewidth}%
        \IfNoValueF{#1}{%
            \if\relax\detokenize{#1}\relax\else
                \MUL@computeHelperWidth{#1}{\ImageWidth}%
            \fi
        }%
        % File
        \def\MUL@imageFile{graphics/placeholder_image.pdf}%
        \IfNoValueF{#2}{%
            \if\relax\detokenize{#2}\relax\else
                \IfFileExists{#2}{%
                    \def\MUL@imageFile{#2}%
                }{%
                    \IfFileExists{graphics/#2}{%
                        \def\MUL@imageFile{graphics/#2}%
                    }{
                        % File not found: keep placeholder.
                        \def\MUL@imageFile{graphics/placeholder_image.pdf}%
                        }%
                }%
            \fi
        }%
        % ----------------------------------------------------------
        % Typeset image
        % ----------------------------------------------------------
        \par\noindent
        \IfNoValueTF{#3}{%
            % No height specified: preserve aspect ratio.
            \includegraphics[width=\ImageWidth]{\MUL@imageFile}%
        }{%
            \if\relax\detokenize{#3}\relax
            % Empty height argument: preserve aspect ratio.
            \includegraphics[width=\ImageWidth]{\MUL@imageFile}%
        \else
            % Explicit height: force width and height.
            \includegraphics[width=\ImageWidth,height=#3]{\MUL@imageFile}%
        \fi
        }%
        \par
    \endgroup
}

% ============================================================
% 13. Footer ribbon
% ============================================================

\newcommand{\buildfooter}{%
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
        \fill[Turquoise] (0,0) rectangle (\paperwidth,\FooterBandHeight);
        \fill[Turquoise] (0,0) -- (0,2\FooterBandHeight) -- (2\FooterBandHeight,0) -- cycle;
        \node[anchor=west] at (\marginleft,0.5\FooterBandHeight)
        {\begin{minipage}[c]{0.5\paperwidth-\marginleft}
            \raggedright\claimstyle
            \MUL@FooterLeftText
        \end{minipage}};
        \node[anchor=east, inner sep=0pt] at (\paperwidth-\marginright,0.5\FooterBandHeight)
        {\begin{minipage}[c]{0.5\paperwidth-\marginright}
            \raggedleft\claimstyle\color{TechGreen}\MUL@ClaimText
        \end{minipage}};
    \end{tikzpicture}
}

\makeatother
\endinput