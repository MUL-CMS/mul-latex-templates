\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{MUL_poster}[2026/05/01 MUL scientific poster class]

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
\newlength{\MarginLeft}          \setlength{\MarginLeft}{27mm}
\newlength{\MarginRight}         \setlength{\MarginRight}{27mm}
\newlength{\HeaderBandHeight}    \setlength{\HeaderBandHeight}{101.5mm}
\newlength{\FooterBandHeight}    \setlength{\FooterBandHeight}{19mm}

\newlength{\ColumnWidth}         \setlength{\ColumnWidth}{120mm}
\newlength{\ColumnGap}           \setlength{\ColumnGap}{20mm}
\newlength{\GridWidth}           \setlength{\GridWidth}{4\ColumnWidth+3\ColumnGap}

\newlength{\PrimaryLogoWidth}    \setlength{\PrimaryLogoWidth}{80.8mm}
\newlength{\PrimaryLogoHeight}   \setlength{\PrimaryLogoHeight}{0.923\PrimaryLogoWidth}% ratio 880.5/954.0 {74.57mm}

\newlength{\TopRightImageHeight} \setlength{\TopRightImageHeight}{\PrimaryLogoHeight}
\newlength{\TopRightImageWidth}  \setlength{\TopRightImageWidth}{0.75\TopRightImageHeight}

\newlength{\VGap}                \setlength{\VGap}{15mm}
\newcommand{\vGap}{\vspace*{\VGap}}

\newlength{\HighlightInset}      \setlength{\HighlightInset}{4mm}

\newlength{\TitleLeftX}          \setlength{\TitleLeftX}{\MarginLeft+\PrimaryLogoWidth+15mm}
\newlength{\TitleWidth}          \setlength{\TitleWidth}{\paperwidth-\TitleLeftX-\MarginRight}

% ============================================================
% 3. Color system
% ============================================================

% ------------------------------------------------------------
% 3.1 Color definitions (Digital RGB + Print CMYK)
% ------------------------------------------------------------

% Digital variants: RGB / HEX-oriented values from the brandbook.
\definecolor{digital_Turquoise}{RGB}{0,114,125}
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
\definecolor{print_Turquoise}{cmyk}{1.00,0.40,0.50,0.00}
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

\newcommand{\Colors}[1]{%
    \ifcsname MUL@set#1Colors\endcsname
        \csname MUL@set#1Colors\endcsname
    \else
        \ClassError{MUL_poster}{Unknown color mode '#1'}{Use 'Print' or 'Digital'.}%
    \fi
}

\Colors{Digital}% default, unless an override is applied in the main poster file.

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
% 4.2 Public font aliases (switched by \FontMode)
% ------------------------------------------------------------
\newcommand{\TextFont}{\MUL@HostFont}
\newcommand{\TextLightFont}{\MUL@HostLightFont}
\newcommand{\TextMediumFont}{\MUL@HostMediumFont}
\newcommand{\TextSemiBoldFont}{\MUL@HostSemiBoldFont}
\newcommand{\TextExtraBoldFont}{\MUL@HostExtraBoldFont}

\newcommand{\DisplayFont}{\MUL@FunnelFont}
\newcommand{\DisplayLightFont}{\MUL@FunnelLightFont}
\newcommand{\DisplayMediumFont}{\MUL@FunnelMediumFont}
\newcommand{\DisplaySemiBoldFont}{\MUL@FunnelSemiBoldFont}
\newcommand{\DisplayExtraBoldFont}{\MUL@FunnelExtraBoldFont}
\newcommand{\ClaimFont}{\MUL@FunnelBoldFont}

\newcommand{\TitleWeight}{\bfseries}
\newcommand{\HeadingWeight}{\mdseries}
\newcommand{\AuthorWeight}{\bfseries}
\newcommand{\ClaimWeight}{\bfseries}

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
%   \FontMode{Regular}      — Calibri everywhere, Times math and symbols
%   \FontMode{Experimental} — Host Grotesk body, Funnel Display headings
% ------------------------------------------------------------
\newcommand{\MUL@setRegularFonts}{%
    \renewcommand{\TextFont}{\MUL@CalibriFont}%
    \renewcommand{\TextLightFont}{\MUL@CalibriFont}%
    \renewcommand{\TextMediumFont}{\MUL@CalibriFont}%
    \renewcommand{\TextSemiBoldFont}{\MUL@CalibriFont}%
    \renewcommand{\TextExtraBoldFont}{\MUL@CalibriFont}%
    \renewcommand{\DisplayFont}{\MUL@CalibriFont}%
    \renewcommand{\DisplayLightFont}{\MUL@CalibriFont}%
    \renewcommand{\DisplayMediumFont}{\MUL@CalibriFont}%
    \renewcommand{\DisplaySemiBoldFont}{\MUL@CalibriFont}%
    \renewcommand{\DisplayExtraBoldFont}{\MUL@CalibriFont}%
    \renewcommand{\ClaimFont}{\MUL@FunnelBoldFont}%
    \renewcommand{\TitleWeight}{\bfseries}%
    \renewcommand{\HeadingWeight}{\mdseries}%
    \renewcommand{\AuthorWeight}{\bfseries}%
    \renewcommand{\ClaimWeight}{\mdseries}%
    \MUL@setRegularMath
}

\newcommand{\MUL@setExperimentalFonts}{%
    \renewcommand{\TextFont}{\MUL@HostFont}%
    \renewcommand{\TextLightFont}{\MUL@HostLightFont}%
    \renewcommand{\TextMediumFont}{\MUL@HostMediumFont}%
    \renewcommand{\TextSemiBoldFont}{\MUL@HostSemiBoldFont}%
    \renewcommand{\TextExtraBoldFont}{\MUL@HostExtraBoldFont}%
    \renewcommand{\DisplayFont}{\MUL@FunnelFont}%
    \renewcommand{\DisplayLightFont}{\MUL@FunnelLightFont}%
    \renewcommand{\DisplayMediumFont}{\MUL@FunnelMediumFont}%
    \renewcommand{\DisplaySemiBoldFont}{\MUL@FunnelSemiBoldFont}%
    \renewcommand{\DisplayExtraBoldFont}{\MUL@FunnelExtraBoldFont}%
    \renewcommand{\ClaimFont}{\MUL@FunnelBoldFont}%
    \renewcommand{\TitleWeight}{\bfseries}%
    \renewcommand{\HeadingWeight}{\mdseries}%
    \renewcommand{\AuthorWeight}{\bfseries}%
    \renewcommand{\ClaimWeight}{\mdseries}%
    \MUL@setExperimentalMath
}

\newcommand{\FontMode}[1]{%
    \ifcsname MUL@set#1Fonts\endcsname
        \csname MUL@set#1Fonts\endcsname
    \else
        \ClassError{MUL_poster}{Unknown font mode '#1'}{Use 'Regular' or 'Experimental'.}%
    \fi
}

\FontMode{Regular}% default

% ============================================================
% 5. Typography styles & text helpers
% ============================================================

% ------------------------------------------------------------
% 5.1 Named styles
% ------------------------------------------------------------
\newcommand{\TitleStyle}{\DisplayFont\TitleWeight\color{White}\fontsize{60pt}{66pt}\selectfont}
\newcommand{\HeadingStyle}{\DisplayFont\HeadingWeight\color{Turquoise}\fontsize{36pt}{43.2pt}\selectfont}
\newcommand{\IntroStyle}{\TextFont\color{White}\fontsize{30pt}{36pt}\selectfont}
\newcommand{\AuthorStyle}{\TextFont\AuthorWeight\color{black}\fontsize{30pt}{36pt}\selectfont}
\newcommand{\AffiliationStyle}{\TextFont\mdseries\color{black}\fontsize{20pt}{24pt}\selectfont}
\newcommand{\BodyStyle}{\TextFont\color{black}\fontsize{24pt}{28.8pt}\selectfont}
\newcommand{\Text}{\TextFont\color{black}\fontsize{24pt}{28.8pt}\selectfont}
\newcommand{\ReferenceStyle}{\TextFont\color{black}\noindent\fontsize{14pt}{16.8pt}\selectfont}
\newcommand{\ClaimStyle}{\ClaimFont\ClaimWeight\noindent\fontsize{36pt}{28.8pt}\selectfont}

% ------------------------------------------------------------
% 5.2 Public text helpers
% ------------------------------------------------------------
\newcommand{\Para}[1]{{\BodyStyle\justifying\noindent #1\par}}
\newcommand{\References}[1]{{\ReferenceStyle\RaggedRight #1\par}}

% ============================================================
% 6. Logo & language system
% ============================================================

% ------------------------------------------------------------
% 6.1 Language selection
% ------------------------------------------------------------
\newcommand{\Language}[1]{\def\MUL@Language{#1}}
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

% ============================================================
% 7. Header content commands
% ============================================================

% ------------------------------------------------------------
% 7.1 Title
% ------------------------------------------------------------
\def\MUL@titleText{}
\newcommand{\Title}[1]{\gdef\MUL@titleText{#1}}

% ------------------------------------------------------------
% 7.2 Authors & affiliations
% ------------------------------------------------------------
\def\MUL@authorText{}
\def\MUL@affiliationText{}
\newif\ifMUL@hasAuthors  \MUL@hasAuthorsfalse

\newcommand{\Authors}[1]{%
    \global\MUL@hasAuthorstrue
    \gdef\MUL@authorText{#1}%
}
\newcommand{\Affiliations}[1]{%
    \global\MUL@hasAuthorstrue
    \gdef\MUL@affiliationText{#1}%
}

% ------------------------------------------------------------
% 7.3 Intro ribbon
% ------------------------------------------------------------
\def\MUL@introText{}
\newif\ifMUL@hasIntro  \MUL@hasIntrofalse

\newcommand{\Intro}[1]{%
    \global\MUL@hasIntrotrue
    \gdef\MUL@introText{#1}%
}

% ------------------------------------------------------------
% 7.4 Optional top-right header image
% ------------------------------------------------------------
\def\MUL@topRightImageFile{}
\newif\ifMUL@hasTopRightImage  \MUL@hasTopRightImagefalse

\newcommand{\HeaderImage}[3]{%
    \MUL@hasTopRightImagetrue
    \gdef\MUL@topRightImageFile{#1}%
    \setlength{\TopRightImageWidth}{#2}%
    \setlength{\TopRightImageHeight}{#3}%
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
            \begin{minipage}{\GridWidth}
                \RaggedRight
                {\AuthorStyle\MUL@authorText\par}%
                \vspace{\AuthorGap}%
                {\AffiliationStyle
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
            \begin{minipage}{\GridWidth}
                \RaggedRight{\IntroStyle\MUL@introText\par}%
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
        \node at (\MarginLeft+0.5\PrimaryLogoWidth,\paperheight-0.5\HeaderBandHeight)
            {\logo[width=\PrimaryLogoWidth,height=\PrimaryLogoHeight]{white}{v1}};
        % Title
        \node[anchor=west, inner sep=0pt] at (\TitleLeftX,\paperheight-0.5\HeaderBandHeight)
            {\begin{minipage}[c][\HeaderBandHeight][c]{\TitleWidth}
                \RaggedRight\TitleStyle\MUL@titleText
            \end{minipage}};
        % Optional top-right image
        \ifMUL@hasTopRightImage
            \node[anchor=east, inner sep=0pt] at (\paperwidth-\MarginRight,\paperheight-0.5\HeaderBandHeight)
                {\includegraphics[width=\TopRightImageWidth, height=\TopRightImageHeight]{\MUL@topRightImageFile}};
        \fi
        % Author block
        \ifdim\AuthorHeight>0pt
            \node[anchor=north west] at (\MarginLeft,\paperheight-\HeaderBandHeight-\AuthorPadding)
                {\usebox{\MUL@authorBox}};
        \fi
        % Intro ribbon
        \ifdim\IntroHeight>0pt
            \fill[Turquoise] (0,\paperheight-\HeaderBandHeight-\AuthorHeight-\IntroHeight)
                rectangle
                (\paperwidth,\paperheight-\HeaderBandHeight-\AuthorHeight);
            \node[anchor=north west, inner sep=0pt] at (\MarginLeft,\paperheight-\HeaderBandHeight-\AuthorHeight-\IntroPadding)
                {\usebox{\MUL@introBox}};
        \fi
    \end{tikzpicture}
}

% ------------------------------------------------------------
% 8.3 Public build command
% ------------------------------------------------------------
\newcommand{\BuildHeader}{%
    \MUL@measureTopBlocks
    \MUL@drawHeader
}

% ============================================================
% 9. Grid system
% ============================================================

% ------------------------------------------------------------
% 9.1 Grid units & debug flag
% ------------------------------------------------------------
\newlength{\GridUnitX}  \setlength{\GridUnitX}{20mm}
\newlength{\GridUnitY}  \setlength{\GridUnitY}{\VGap}% 15mm

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
            \advance\MUL@gridLabelY by -0.5\GridUnitY
            % --- Vertical grid lines + x labels ---
            \MUL@gridCol=0
            \MUL@gridX=\MarginLeft
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
                        {{\TextFont\fontsize{14pt}{14pt}\selectfont\color{black}\the\MUL@gridCol}};
                    \advance\MUL@gridCol by 1
                    \advance\MUL@gridX by \GridUnitX
                \repeat
            % --- Strong column-structure lines ---
            \foreach \x in {0,6,7,13,14,20,21,27} {%
                \draw[Turquoise, opacity=1.0, line width=1.0pt]
                    (\MarginLeft+\x\GridUnitX, \BodyTopY) --
                    (\MarginLeft+\x\GridUnitX, \MUL@gridBottomY);
            }
            % --- Horizontal grid lines + y labels ---
            \MUL@gridRow=0
            \MUL@gridY=\BodyTopY
            \MUL@gridLabelX=\MarginLeft
            \loop
                \ifdim\MUL@gridY>\MUL@gridBottomY
                    \ifodd\MUL@gridRow
                        \draw[color=black, opacity=0.2, line width=0.2pt]
                            (\MarginLeft, \MUL@gridY) --
                            (\MarginLeft+\GridWidth, \MUL@gridY);
                    \else
                        \draw[color=red, opacity=0.2, line width=0.2pt]
                            (\MarginLeft, \MUL@gridY) --
                            (\MarginLeft+\GridWidth, \MUL@gridY);
                    \fi
                    \node[anchor=east] at (\MUL@gridLabelX-1mm, \MUL@gridY)
                        {{\TextFont\fontsize{14pt}{14pt}\selectfont\color{black}\the\MUL@gridRow}};
                    \node[anchor=west] at (\MUL@gridLabelX+\GridWidth+1mm, \MUL@gridY)
                        {{\TextFont\fontsize{14pt}{14pt}\selectfont\color{black}\the\MUL@gridRow}};
                    \advance\MUL@gridRow by 1
                    \advance\MUL@gridY by -\GridUnitY
                \repeat
        \end{tikzpicture}
    \fi
}

\newcommand{\ShowGrid}{%
    \global\MUL@showGridtrue
    \MUL@drawGrid
}

% ------------------------------------------------------------
% 9.3 GridBox placement command
% ------------------------------------------------------------
% Usage: \GridBox{x}{y}{width}{height}{<content>}
% Coordinates in grid units from top-left of body area.

\newdimen\MUL@gridBoxX
\newdimen\MUL@gridBoxY
\newdimen\MUL@gridBoxW
\newdimen\MUL@gridBoxH
\newdimen\MUL@gridBoxRight
\newdimen\MUL@gridBoxBottom

\NewDocumentCommand{\GridBox}{ m m m m +m }{%
    \begingroup
    % ----------------------------------------------------------
    % Compute physical position (fractional-safe)
    % ----------------------------------------------------------
    % Left edge: MarginLeft + x * GridUnitX
    \setlength{\MUL@gridBoxX}{%
        \dimexpr
        \MarginLeft + (#1\GridUnitX)
        \relax
    }
    % Top edge: BodyTopY - y * GridUnitY
    \setlength{\MUL@gridBoxY}{%
        \dimexpr
        \BodyTopY - (#2\GridUnitY)
        \relax
    }
    % Width: w * GridUnitX
    \setlength{\MUL@gridBoxW}{%
        \dimexpr
        #3\GridUnitX
        \relax
    }
    % Height: h * GridUnitY
    \setlength{\MUL@gridBoxH}{%
        \dimexpr
        #4\GridUnitY
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
    % GridBox outline, enabled by \ShowGrid
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
% 9.4 Footer grid origin & FooterGridBox
% ------------------------------------------------------------
\newlength{\FooterGridTopOffset}  \setlength{\FooterGridTopOffset}{77mm}
\newlength{\FooterTopY}
\setlength{\FooterTopY}{\dimexpr\FooterBandHeight+\FooterGridTopOffset\relax}

% \newcommand{\SetFooterGridTopOffset}[1]{%
%     \setlength{\FooterGridTopOffset}{#1}%
%     \setlength{\FooterTopY}{\dimexpr\FooterBandHeight+\FooterGridTopOffset\relax}%
% }

% Usage: \FooterGridBox{x}{y}{width}{height}{<content>}

\newdimen\MUL@footerGridBoxX
\newdimen\MUL@footerGridBoxY
\newdimen\MUL@footerGridBoxW
\newdimen\MUL@footerGridBoxH
\newdimen\MUL@footerGridBoxRight
\newdimen\MUL@footerGridBoxBottom

\NewDocumentCommand{\FooterGridBox}{ m m m m +m }{%
    \begingroup
    % Keep footer-grid origin synchronized with the current offset.
    \setlength{\FooterTopY}{\dimexpr\FooterBandHeight+\FooterGridTopOffset\relax}%
    % ----------------------------------------------------------
    % Compute physical position
    % ----------------------------------------------------------
    % Left edge:
    %   MarginLeft + x * GridUnitX
    \setlength{\MUL@footerGridBoxX}{%
        \dimexpr\MarginLeft + #1\GridUnitX\relax
    }%
    % Top edge:
    %   FooterGridTopY - y * GridUnitY
    \setlength{\MUL@footerGridBoxY}{%
        \dimexpr\FooterTopY - #2\GridUnitY\relax
    }%
    % Width:
    %   w * GridUnitX
    \setlength{\MUL@footerGridBoxW}{%
        \dimexpr#3\GridUnitX\relax
    }%
    % Height:
    %   h * GridUnitY
    \setlength{\MUL@footerGridBoxH}{%
        \dimexpr#4\GridUnitY\relax
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
    % Optional GridBox outline, enabled by \ShowGrid
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
% (Insert \MUL@flowInit, cursor declarations here)

% ------------------------------------------------------------
% FLOW cursor storage
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
% (Insert \MUL@selectFlowStart, \MUL@FlowPlace here)

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
% 10.3 Public FlowBox command
% ------------------------------------------------------------
\newcount\MUL@startIndex
\newcount\MUL@spanIndex

\NewDocumentCommand{\FlowBox}{ m o m }{%
    \IfNoValueTF{#2}{%
        \MUL@selectFlowStart{#1}%
        \MUL@FlowPlace{\the\MUL@flowBestStart}{#1}{#3}%
    }{%
        \MUL@FlowPlace{#2}{#1}{#3}%
    }%
}

% ============================================================
% 11. PosterBody environment
% ============================================================

\newenvironment{PosterBody}{}{}

% Wrap with flow initialization when flow system is active
\let\MUL@origPosterBody\PosterBody
\let\endMUL@origPosterBody\endPosterBody

\renewenvironment{PosterBody}{%
    \MUL@origPosterBody
    \MUL@flowInit
}{%
    \endMUL@origPosterBody
}

% ============================================================
% 12. Content helpers: Header, Highlight, Rule, Image
% ============================================================

% ------------------------------------------------------------
% 12.1 Section header
% ------------------------------------------------------------
\newcommand{\Section}[1]{%
    \par\noindent
    \begin{minipage}[t]{\linewidth}
        \HeadingStyle #1
    \end{minipage}\par
}

% ------------------------------------------------------------
% 12.2 Helper-width computation (shared by Image, Highlight, Rule)
% ------------------------------------------------------------
%   span 1 -> \ColumnWidth
%   span 2 -> 2\ColumnWidth + 1\ColumnGap
%   span N -> N\ColumnWidth + (N-1)\ColumnGap
\newlength{\MUL@blockX}
\newlength{\MUL@blockY}
\newlength{\MUL@blockWidth}
\newlength{\ImageWidth}
\newlength{\RuleWidth}
\newsavebox{\MUL@tempBox}

\newcommand{\MUL@computeBlock}[3]{%
    \MUL@startIndex=#1\relax
    \advance\MUL@startIndex by -1
    \setlength{\MUL@blockX}{\MarginLeft}%
    \addtolength{\MUL@blockX}{\MUL@startIndex\ColumnWidth}%
    \addtolength{\MUL@blockX}{\MUL@startIndex\ColumnGap}%
    \MUL@spanIndex=#2\relax
    \setlength{\MUL@blockWidth}{\MUL@spanIndex\ColumnWidth}%
    \advance\MUL@spanIndex by -1
    \addtolength{\MUL@blockWidth}{\MUL@spanIndex\ColumnGap}%
    \setlength{\MUL@blockY}{\BodyTopY}%
}

\newcommand{\MUL@computeHelperWidth}[2]{%
    \MUL@spanIndex=#1\relax
    \setlength{#2}{\MUL@spanIndex\ColumnWidth}%
    \advance\MUL@spanIndex by -1\relax
    \ifnum\MUL@spanIndex>0
        \addtolength{#2}{\MUL@spanIndex\ColumnGap}%
    \fi
}

% ------------------------------------------------------------
% 12.3 Highlight block
% ------------------------------------------------------------
\newlength{\HighlightWidth}

% Usage:
%   \Highlight{<content>}
%   \Highlight[<span>]{<content>}

\NewDocumentCommand{\Highlight}{ o +m }{%
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
            \BodyStyle\noindent\justifying #2
        \end{minipage}%
        };
    \end{tikzpicture}%
    \par
    \endgroup
}

% ------------------------------------------------------------
% 12.4 Rule
% ------------------------------------------------------------

\NewDocumentCommand{\Rule}{ o }{%
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
%   \Image                          — placeholder at \linewidth
%   \Image[<span>]                  — placeholder at column span width
%   \Image[<span>][<path>]          — custom image, auto height
%   \Image[<span>][<path>][<height>] — custom image, forced height
%
% File resolution: tries exact path, then graphics/<path>,
% then falls back to placeholder.
\NewDocumentCommand{\Image}{ o o o }{%
    \begingroup
        % Width
        \setlength{\ImageWidth}{\linewidth}%
        \IfNoValueF{#1}{%
            \if\relax\detokenize{#1}\relax\else
                \MUL@computeHelperWidth{#1}{\ImageWidth}%
            \fi
        }%
        % File
        \def\MUL@imageFile{graphics/placeholder_image.png}%
        \IfNoValueF{#2}{%
            \if\relax\detokenize{#2}\relax\else
                \IfFileExists{#2}{%
                    \def\MUL@imageFile{#2}%
                }{%
                    \IfFileExists{graphics/#2}{%
                        \def\MUL@imageFile{graphics/#2}%
                    }{
                        % File not found: keep placeholder.
                        \def\MUL@imageFile{graphics/placeholder_image.png}%
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
% (Insert \MUL@drawFooterRibbon, \BuildBottomRibbon here)

\newcommand{\BuildBottomRibbon}{%
    \begin{tikzpicture}[remember picture, overlay, shift={(current page.south west)}]
        \fill[Turquoise] (0,0) rectangle (\paperwidth,\FooterBandHeight);
        \fill[Turquoise] (0,0) -- (0,2\FooterBandHeight) -- (2\FooterBandHeight,0) -- cycle;
        \node[anchor=west] at (\MarginLeft,0.5\FooterBandHeight)
        {\begin{minipage}[c]{0.5\paperwidth-\MarginLeft}
            \raggedright\ClaimStyle
            \MUL@FooterLeftText
        \end{minipage}};
        \node[anchor=east, inner sep=0pt] at (\paperwidth-\MarginRight,0.5\FooterBandHeight)
        {\begin{minipage}[c]{0.5\paperwidth-\MarginRight}
            \raggedleft\ClaimStyle\color{TechGreen}\MUL@ClaimText
        \end{minipage}};
    \end{tikzpicture}
}

\makeatother
\endinput