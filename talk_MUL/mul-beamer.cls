% Author: David Holec, david.holec@unileoben.ac.at
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul-beamer}[2026/10/13 v3.03 Beamer with a MUL/DMS layout]%
%
%
% +---------------------------+
% | INTERNAL DESIGN VARIABLES |
% +---------------------------+
%
% MULIsSidebar: true for beamer mode, false for trans mode
\newif\ifMULIsSidebar
\MULIsSidebartrue
% MULShowResults: true if content of \showResults{} to be shown
\newif\ifMULShowResults
\MULShowResultstrue
% MUL@footings: type of footings (empty, default, full, lecture)
\def\MUL@footings{default}
\def\MUL@footings@empty{empty}
\def\MUL@footings@default{default}
\def\MUL@footings@lecture{lecture}
% MULDarkTitle: true for the dark version of the title page
\newif\ifMULDarkTitle
\MULDarkTitlefalse
% MULBrandFont: true if Host Grotesk (MUL brand font) is used as text font
\newif\ifMULBrandFont
\MULBrandFontfalse
% MULLecture: true if the presentation is a lecture (adding ToC at the beginning of sections)
\newif\ifMULLecture
\MULLecturefalse
%
%
% +--------------------------------------------+
% | CLASS OPTIONS AND LOADING THE BEAMER CLASS |
% +--------------------------------------------+
%
% class option showSidebar
\DeclareOption{showSidebar}{\MULIsSidebartrue}%
% class option hideSidebar
\DeclareOption{hideSidebar}{\MULIsSidebarfalse}%
%
% class option emptyFootings
\DeclareOption{emptyFootings}{\def\MUL@footings{empty}}%
% class option defaultFootings
\DeclareOption{defaultFootings}{\def\MUL@footings{default}}%
% class option fullFootings
\DeclareOption{fullFootings}{\def\MUL@footings{full}}%
% class option lectureFootings
\DeclareOption{lectureFootings}{\def\MUL@footings{lecture}}%
%
% class option slideSingleNumber: slides numbered as #(slide)
\DeclareOption{slideSingleNumber}{\def\frameNumber{\insertframenumber}}%
% class option slideTotalNumber: slides numbered as #(slide)/#(total)
\DeclareOption{slideTotalNumber}{\def\frameNumber{\insertframenumber/\inserttotalframenumber}}%
%
% class option hideothersubsections: only section titles are shown for inactive sections in ToC
\DeclareOption{hideothersubsections}{\def\MULhideothersubsections{hideothersubsections}}%
% class option showothersubsections: all subsections are shown in ToC
\DeclareOption{showothersubsections}{\def\MULhideothersubsections{}}%
%
% class option DElocalization
\DeclareOption{DElocalization}{%
	\def\MULframeLogo{graphics/logo-mul_M}%
	\def\MULtitleLogo{graphics/logo-mul}%
	\def\MULtitleLogoWhite{graphics/logo-mul-white}%
	\def\MULsloganText{Versetz’ Berge}%
	\def\MULthanksText{Danke für Ihre Aufmerksamkeit!}%
}%
% class option ENlocalization
\DeclareOption{ENlocalization}{%
	\def\MULframeLogo{graphics/logo-mul_M}%
	\def\MULtitleLogo{graphics/logo-mul-en}%
	\def\MULtitleLogoWhite{graphics/logo-mul-en-white}%
	\def\MULsloganText{Move mountains}%
	\def\MULthanksText{Thank you for your attention!}%
}%
%
% class option showResults
\DeclareOption{showResults}{\MULShowResultstrue}%
% class option lightTitle: light title page (light background, turquoise title)
\DeclareOption{lightTitle}{\MULDarkTitlefalse}%
% class option darkTitle: dark title page (dark background, white logo and text)
\DeclareOption{darkTitle}{\MULDarkTitletrue}%
%
% class option brandFont: Host Grotesk as text font (MUL brand font)
\DeclareOption{brandFont}{\MULBrandFonttrue}%
% class option classicFont: Latin Modern Sans as text font (beamer default; class default)
\DeclareOption{classicFont}{\MULBrandFontfalse}%
%
% class option hideResults
\DeclareOption{hideResults}{\MULShowResultsfalse}%
%
% pass all other options to beamer
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%
% default behavior
\ExecuteOptions{beamer, slideSingleNumber, showothersubsections, showSidebar, DElocalization, defaultFootings, showResults, classicFont, lightTitle}%
\ProcessOptions%
% other general options for the beamer class
\PassOptionsToClass{%
	10pt,% default font size
	t,% slides aligned to top
	aspectratio=169,% new layout using ONLY 16:9 aspect ratio
}{beamer}%
\LoadClass{beamer}%
%
% no navigation symbols
\setbeamertemplate{navigation symbols}{}%
% uncover everything in a step-wise fashion
\beamerdefaultoverlayspecification{<+->}%
% use squares in itemize environments, use n-dash for lower levels
\setbeamertemplate{itemize item}{\raisebox{0.15em}{\tiny$\blacksquare$}}
\setbeamertemplate{itemize subitem}{--}
\setbeamertemplate{itemize subsubitem}{--}
\setbeamertemplate{blocks}[rounded][shadow=true]%
%
% other required packages
\RequirePackage{ifthen}%
\RequirePackage{calc}%
\RequirePackage{marvosym}% for example signs
\RequirePackage{tikz}%
\RequirePackage{fontspec}%
%
%
% +------------------+
% | SLIDE COMPONENTS |
% +------------------+
%
% load SIDEBAR with ToC
\newlength{\MULsideBarWidth}%
\setlength{\MULsideBarWidth}{2cm}%
\ifMULIsSidebar%
	\useoutertheme[%
		height=0mm,%  height of the title bar
		width=\MULsideBarWidth,% width of the side bar
		\MULhideothersubsections% show only subsections from current section
	]{sidebar}%
	% removing presentation name and title from the sidebar
	\renewcommand{\insertshortauthor}[1][]{}%
	\renewcommand{\insertshorttitle}[1][]{}%
	% suppressing the side bar on the title page
	% (modified code from beamer/themes/outer/beamerouterthemesidebar.sty)
	\defbeamertemplate*{sidebar \beamer@sidebarside}{}%
	{%
		\beamer@tempdim=\beamer@sidebarwidth%
		\advance\beamer@tempdim by -6pt%
		{\usebeamerfont{title in sidebar}%
			\vskip1.5em%
			\hskip3pt%
			\usebeamercolor[fg]{title in sidebar}%
			\insertshorttitle[width=\beamer@tempdim,center,respectlinebreaks]\par%
			\vskip1.25em%
		}%
		{%
			\hskip3pt%
			\usebeamercolor[fg]{author in sidebar}%
			\usebeamerfont{author in sidebar}%
			\insertshortauthor[width=\beamer@tempdim,center,respectlinebreaks]\par%
			\vskip1.25em%
		}%
		\ifnum\insertframenumber>1%
			\insertverticalnavigation{\beamer@sidebarwidth}%
		\fi%
		\vfill%
		\ifx\beamer@sidebarside
			\beamer@lefttext%
		\else%
			\usebeamercolor{normal text}%
			\llap{\usebeamertemplate***{navigation symbols}\hskip0.1cm}%
			\vskip2pt%
		\fi%
	}%
\fi%
%
%
% FRAME HEADINGS
\newlength{\MULtitleWidth}%
\ifthenelse{\boolean{MULIsSidebar}}{%
	\setlength{\MULtitleWidth}{\paperwidth-\MULsideBarWidth}%
}{%
	\setlength{\MULtitleWidth}{\paperwidth}%
}%
\setbeamertemplate{frametitle}{%
	\begin{beamercolorbox}[ht=1eX, dp=0.0eX, wd=\MULtitleWidth]{frametitle}%
		\ifMULIsSidebar%
			\hspace*{0.02\paperwidth}%
		\else%
			\hspace*{0.05\paperwidth}%
		\fi%
		\insertframetitle\hfill%
		\begin{tikzpicture}[overlay]%
			\path[use as bounding box] (0,0) rectangle (0,0);%
			\node[anchor=south east, shift={(0,-0.015\paperwidth)}] at (0,0) {\includegraphics[height=5mm]{\MULframeLogo}};%
		\end{tikzpicture}%
	\end{beamercolorbox}%
}%
%
%
% FRAME FOOTINGS
\newlength{\footerConferenceLeftMargin}%
\defbeamertemplate*{footline}{sidebar theme}{%
	% exclude footing on the title page
	\ifnum\insertframenumber>1%
		\begin{beamercolorbox}[ht=0.035\paperheight, dp=0.018\paperheight, wd=\paperwidth]{author in head/foot}%
			% literature
			\begin{tikzpicture}%
				\path[use as bounding box] (0,0) rectangle (0,0);%
				\node[anchor=south east, shift={(\paperwidth-2ex,0.04\paperheight)}] at (0,0) {\parbox{0.8\paperwidth}{\raggedleft\color{black}\tiny\insertLiterature}};%
				\fill[MULgreen](0,0) -- (0.09\paperheight, 0) -- (0, 0.09\paperheight);%
			\end{tikzpicture}%
			\usebeamerfont{foot}%
			\hspace*{0.068\paperwidth}%
			\ifx\MUL@footings\MUL@footings@empty\else%
				% uni slogan
				{\usebeamerfont{MULslogan in foot}{\color{MULsloganSlideColor}\MULsloganText}}%
				\hfill%
				\ifx\MUL@footings\MUL@footings@default%
					% defaultFootings
					% author | organisation unit
					\parbox{6cm}{\centering\beamer@shortauthor{} | \shortinstitute}%
				\else\ifx\MUL@footings\MUL@footings@lecture%
					% lectureFootings
					% lecture name only (not replaced by section names)
					\parbox{10cm}{\centering\insertMULlecture}%
				\else%
					% fullFootings
					% author & title ... conference / lecture title ... date
					\parbox{4cm}{\centering\beamer@shortauthor: \beamer@shorttitle}%
					\hfill%
					\parbox{4cm}{\centering\MULconference}%
					\hfill%
					\parbox{2cm}{\centering\mbox{}\hfill\parbox{1.7cm}\insertdate}%
				\fi\fi%
			\fi%
			\hfill%
			% frame numbers
			\parbox{1cm}{\raggedleft\frameNumber}%
			\hspace*{3eX}%
		\end{beamercolorbox}%
	\fi%
}%
%
%
% DARK SLIDES (final frame, dark title page)
% background image: turquoise with a multiplied black-and-white photo (style guide)
\def\MULdarkBackground{graphics/background_dark_cms.jpg}%
\newcommand{\setDarkBackground}[1]{\def\MULdarkBackground{#1}}%
% background and white logo of the dark slides (inside a tikzpicture with remember picture)
\newcommand{\MUL@darkbackground}{%
	\path[use as bounding box] (current page.south west) rectangle (current page.north east);%
	\node at (current page.center) {\includegraphics[width=\paperwidth]{\MULdarkBackground}};%
	\node[anchor=north east, shift={(-0.04\paperheight,-0.04\paperheight)}] at (current page.north east) {\includegraphics[width=0.084\paperwidth]{\MULtitleLogoWhite}};%
}%
%
% FINAL FRAME
% \finalframe[<text>]: closing slide, by default "Thank you for your attention!"
% (localised), with the e-mail address (\email) and a white footer band with the claim
\newcommand{\finalframe}[1][\MULthanksText]{%
	\begin{frame}[plain]%
		\begin{tikzpicture}[overlay, remember picture]%
			\MUL@darkbackground%
			% e-mail address and text
			\node[anchor=south west, inner sep=0pt, text width=0.8\paperwidth, align=left] at ([shift={(0.068\paperwidth,0.28\paperheight)}]current page.south west) {%
				\ifdefempty{\insertemail}{}{{\usebeamerfont{MULfinal email}\color{white}\insertemail}\par\medskip}%
				{\usebeamerfont{MULfinal}\color{white}#1\par}%
			};%
			% white footer band (as the footer of the frames) with the claim in turquoise
			\fill[white] (current page.south west) rectangle ([shift={(\paperwidth,0.053\paperheight)}]current page.south west);%
			\fill[white] ([shift={(0,0.018\paperheight)}]current page.south west) -- ++(0.09\paperheight,0) -- ++(-0.09\paperheight,0.09\paperheight) -- cycle;%
			\node[anchor=base west, inner sep=0pt] at ([shift={(0.068\paperwidth,0.018\paperheight)}]current page.south west) {\usebeamerfont{MULslogan in foot}\color{digital_Turquoise}\MULsloganText};%
		\end{tikzpicture}%
	\end{frame}%
}%
%
% PERSON FRAME
% \personframe[<photo>]{<name>}{<role>}{<text>}: introduction of a person as in the
% "Zur Person" layout of the PowerPoint master; photo on the left (cropped to fill
% the area; a placeholder without <photo>), name, role, and text on the right
\newsavebox{\MUL@photobox}%
\newcommand{\personframe}[4][]{%
	{%
	\setbeamertemplate{sidebar left}{}% no sidebar on this frame
	\begin{frame}%
		\begin{tikzpicture}[overlay, remember picture]%
			\path[use as bounding box] (current page.south west) rectangle (current page.north east);%
			% photo area: left 37% of the slide, from the top down to the footer
			\begin{scope}%
				\clip (current page.north west) rectangle ([shift={(0.37\paperwidth,0.053\paperheight)}]current page.south west);%
				\ifblank{#1}{%
					% placeholder: silhouette on GW Light
					\fill[digital_GWLight] (current page.north west) rectangle ([shift={(0.37\paperwidth,0.053\paperheight)}]current page.south west);%
					\fill[digital_GWDark] ([shift={(0.185\paperwidth,0.62\paperheight)}]current page.south west) circle (0.12\paperheight);%
					\fill[digital_GWDark] ([shift={(0.185\paperwidth,0.053\paperheight)}]current page.south west) ellipse [x radius=0.14\paperwidth, y radius=0.42\paperheight];%
				}{%
					% photo scaled to cover the area (by height for wide, by width for tall photos)
					\sbox{\MUL@photobox}{\includegraphics[width=10cm]{#1}}%
					\pgfmathtruncatemacro{\MUL@photowide}{(\wd\MUL@photobox/\ht\MUL@photobox) > (0.37*\paperwidth/(0.947*\paperheight)) ? 1 : 0}%
					\node at ([shift={(0.185\paperwidth,0.5265\paperheight)}]current page.south west) {%
						\ifnum\MUL@photowide=1 \includegraphics[height=0.947\paperheight]{#1}%
						\else\includegraphics[width=0.37\paperwidth]{#1}\fi%
					};%
				}%
			\end{scope}%
			% frame logo (as in the frame titles)
			\node[anchor=north east, shift={(-0.02\paperwidth,-0.025\paperheight)}] at (current page.north east) {\includegraphics[height=5mm]{\MULframeLogo}};%
			% name and role
			\node[anchor=north west, inner sep=0pt, text width=0.52\paperwidth, align=left] at ([shift={(0.41\paperwidth,-0.12\paperheight)}]current page.north west) {%
				{\usebeamerfont{MULperson name}\color{digital_Turquoise}#2\par}%
				\smallskip%
				{\usebeamerfont{MULperson role}\color{digital_GraphiteBlack}#3\par}%
			};%
			% text
			\node[anchor=north west, inner sep=0pt, text width=0.52\paperwidth, align=left] at ([shift={(0.41\paperwidth,-0.38\paperheight)}]current page.north west) {%
				\usebeamercolor[fg]{normal text}#4%
			};%
		\end{tikzpicture}%
	\end{frame}%
	}%
}%
%
% TITLE PAGE
% additional graphics and other elements to be included on the title page
\def\MULtitleAdditions{}%
\newcommand{\additionsToTitlePage}[1]{\def\MULtitleAdditions{#1}}%
\newcommand{\insertadditionsToTitlePage}{\MULtitleAdditions}%
\setbeamertemplate{title page}{%
	\begin{tikzpicture}[overlay, remember picture]%
		\path[use as bounding box] (current page.south west) rectangle (current page.north east);%
		% light or dark version (class options lightTitle/darkTitle)
		\ifMULDarkTitle%
			\def\MUL@titlebackground{\MULdarkBackground}%
			\def\MUL@titlelogo{\MULtitleLogoWhite}%
			\def\MUL@titlecolor{\color{white}}%
			\colorlet{MUL@addresscolor}{white}%
			\colorlet{MUL@slogancolor}{MULsloganDarkColor}%
		\else%
			\def\MUL@titlebackground{graphics/background_title_cms.jpg}%
			\def\MUL@titlelogo{\MULtitleLogo}%
			\def\MUL@titlecolor{\usebeamercolor{title}\color{fg}}%
			\colorlet{MUL@addresscolor}{MULaddress}%
			\colorlet{MUL@slogancolor}{MULsloganTitleColor}%
		\fi%
		% background, logo and slogan
		\node at (current page.center) {\includegraphics[width=\paperwidth]{\MUL@titlebackground}};%
		\node[anchor=north east, shift={(-0.04\paperheight,-0.04\paperheight)}] at (current page.north east) {\includegraphics[width=0.084\paperwidth]{\MUL@titlelogo}};%
		\ifdefempty{\MULsloganText}{}{%
			\node[anchor=south west, shift={(-.02\paperwidth, 0.00\paperheight)}] at (current page.south west) {\usebeamerfont{MULslogan in title}{\color{MUL@slogancolor}\resizebox{1.02\paperwidth}{!}{\MULsloganText}}};%
		}%
		% title
		\node[anchor=south, shift={(0,0.02\paperwidth)}] at (current page.center) {\parbox{0.9\paperwidth}{%
			\centering%
			\usebeamerfont{title}{\MUL@titlecolor\bfseries\funneldisplay\inserttitle}%
		}};%
		% affiliations, email, conference name, date
		\node[anchor=north, shift={(0,0\paperwidth)}] at (current page.center) {\parbox{0.9\paperwidth}{%
			\centering%
			\usebeamerfont{author}{\color{MUL@addresscolor}\insertauthor}\par\medskip%
			\usebeamerfont{institute}{\color{MUL@addresscolor}
				\insertinstitute\par\smallskip
				\ifdefempty{\insertemail}{}{\href{mailto:\insertemail}{\insertemail}\par\bigskip}%
				% conference name only (in lecture mode it holds section names)
				\ifMULLecture\else\ifdefempty{\MULconference}{}{\insertconference\par\smallskip}\fi%
				\ifdefempty{\insertdate}{}{\insertdate}
			}%
		}};%
		% custom additions
		\insertadditionsToTitlePage%
	\end{tikzpicture}
}%
%
%
% +--------+
% | COLORS |
% +--------+
%
% MUL brand colours (Brandbook 2026, digital/RGB values; same names as in MUL_poster.cls)
% primary colours
\definecolor{digital_Turquoise}{RGB}{0,114,125}% #00727d
\definecolor{digital_GraphiteBlack}{RGB}{28,38,41}% #1c2629
\definecolor{digital_White}{RGB}{255,255,255}% #ffffff
\definecolor{digital_LightGreen}{RGB}{136,205,211}% #88cdd3
\definecolor{digital_TechGreen}{RGB}{0,255,255}% #00ffff, digital only
% secondary colours (reserved for the study areas Rohstoffe/Werkstoffe/Prozesse)
\definecolor{digital_Violet}{RGB}{149,75,151}% #954b97
\definecolor{digital_Orange}{RGB}{237,106,91}% #ed6a5b
\definecolor{digital_Blue}{RGB}{88,165,219}% #58a5db
% combination colours ("Kombifarben"; always use together with a primary colour)
\definecolor{digital_BTLight}{RGB}{14,76,83}% #0e4c53
\definecolor{digital_BTDark}{RGB}{21,57,62}% #15393e
\definecolor{digital_TGLight}{RGB}{68,160,168}% #44a0a8
\definecolor{digital_TGDark}{RGB}{34,137,147}% #228993
\definecolor{digital_GWLight}{RGB}{225,242,244}% #e1f2f4
\definecolor{digital_GWDark}{RGB}{195,230,233}% #c3e6e9
% names used by earlier versions of this class (kept for compatibility)
\colorlet{MULgreen}{digital_Turquoise}%
\colorlet{MULturquoise}{digital_TechGreen}%
\colorlet{MULaddress}{digital_GraphiteBlack}%
\definecolor{MULgray}{RGB}{166, 166, 166}%
\usecolortheme[named=digital_Turquoise]{structure}%
% plot colours (for figures and data; not part of the brand palette)
\definecolor{plotblue}{RGB}{31,119,180}%
\definecolor{plotgreen}{RGB}{44,160,44}%
\definecolor{plotorange}{RGB}{255,127,14}%
\definecolor{plotred}{RGB}{214,39,40}%
\definecolor{plotpurple}{RGB}{148, 103, 189}%
\definecolor{plotbrown}{RGB}{140, 86, 75}%
% slogan (claim) on the title page: discreet grey (deliberate deviation from
% the PowerPoint master, which uses turquoise; see README)
\colorlet{MULsloganTitleColor}{white!83!black}%
% slogan (claim) on the dark title page: Light-Green on Turquoise (allowed by the style guide)
\colorlet{MULsloganDarkColor}{digital_LightGreen}%
% slogan in the footer band: white on Turquoise (allowed by the style guide)
\colorlet{MULsloganSlideColor}{digital_White}%
%
% alerted text: red (deliberate deviation, not in the brand palette; see README)
\setbeamercolor{alerted text}{fg=red!80!black}%
% example text (e.g. title of example blocks)
\setbeamercolor{example text}{fg=digital_TGDark}%
% boxes: white title on a primary/combination colour, body in GW Light
\setbeamercolor{block title}{fg=white,bg=digital_Turquoise}%
\setbeamercolor{block body}{parent=normal text,bg=digital_GWLight}%
\setbeamercolor{block title alerted}{use=alerted text,fg=white,bg=alerted text.fg}%
\setbeamercolor{block body alerted}{parent=normal text,bg=digital_GWLight}%
\setbeamercolor{block title example}{fg=white,bg=digital_TGDark}%
\setbeamercolor{block body example}{parent=normal text,bg=digital_GWLight}%
% titles
\setbeamercolor{frametitle}{fg=MULgreen}%
% ToC
\setbeamercolor{section in toc}{fg=digital_GraphiteBlack}%
\setbeamercolor{section in toc shaded}{fg=normal text.fg!50}%
% footings
\setbeamercolor{author in head/foot}{fg=white, bg=MULgreen}%
%
%
% +-------+
% | FONTS |
% +-------+
%
% TEXT FONT
% beamer sets letters and digits in formulas in the text font; operator names
% (\sin, \log, ...) and \mathrm are set in the text font as well (\setmathrm),
% Greek letters and other symbols stay Computer Modern
% \MUL@settextfont{<font>}{<fontspec options>}: text font and \mathrm/operators
\newcommand{\MUL@settextfont}[2]{%
	\setsansfont{#1}[#2]%
	\setmathrm{#1}[#2]%
}%
% Latin Modern Sans (beamer default) for \mathrm/operators
\newcommand{\MUL@setclassicmath}{%
	\setmathrm{lmsans10-regular.otf}[%
		BoldFont = lmsans10-bold.otf,%
		ItalicFont = lmsans10-oblique.otf,%
		BoldItalicFont = lmsans10-boldoblique.otf%
	]%
}%
\ifMULBrandFont%
	% Host Grotesk (MUL brand font); fallbacks: system-installed Host Grotesk,
	% Calibri, Carlito, and finally Latin Modern Sans
	\IfFileExists{./graphics/HostGrotesk-Regular.ttf}{%
		\MUL@settextfont{HostGrotesk}{%
			Path = ./graphics/,%
			Extension = .ttf,%
			UprightFont = *-Regular,%
			ItalicFont = *-Italic,%
			BoldFont = *-Bold,%
			BoldItalicFont = *-BoldItalic%
		}%
	}{%
		\IfFontExistsTF{Host Grotesk}{\MUL@settextfont{Host Grotesk}{}}{%
			\IfFontExistsTF{Calibri}{\MUL@settextfont{Calibri}{}}{%
				\IfFontExistsTF{Carlito}{\MUL@settextfont{Carlito}{}}{\MUL@setclassicmath}%
			}%
		}%
	}%
\else%
	% Latin Modern Sans (beamer default, option classicFont)
	\MUL@setclassicmath%
\fi%
%
% Funnel Display font - if possible
\newif\iffunneldisplayavailable%
\funneldisplayavailablefalse%
\IfFontExistsTF{Funnel Display}{%
  \newfontfamily\funnelfont{Funnel Display}%
  \funneldisplayavailabletrue%
}{%
	\IfFileExists{./graphics/FunnelDisplay-Regular.ttf}{%
		\IfFileExists{./graphics/FunnelDisplay-Bold.ttf}{%
			\newfontfamily\funnelfont[%
				Path = ./graphics/,%
				UprightFont = FunnelDisplay-Regular.ttf,%
				BoldFont = FunnelDisplay-Bold.ttf%
			]{FunnelDisplay}%
			\funneldisplayavailabletrue%
		}{}%
	}{}%
}%
% Command to use Funnel Display or fallback
\newcommand{\funneldisplay}{%
  \iffunneldisplayavailable%
    \funnelfont%
  \else%
    \sffamily%
  \fi%
}%
%
\setbeamerfont{title}{size=\huge}%
\setbeamerfont{author}{size=\normalsize, series=\bfseries}%
\setbeamerfont{institute}{size=\footnotesize, series=\mdseries}%
\setbeamerfont{frametitle}{size=\LARGE, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULslogan in title}{size=\large, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULslogan in foot}{size=\scriptsize, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULperson name}{size=\LARGE, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULperson role}{size=\large, series=\mdseries, family=\funneldisplay}%
\setbeamerfont{MULfinal}{size=\Huge, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULfinal email}{size=\small, series=\mdseries}%
\setbeamerfont{foot}{size=\tiny, family=\sffamily}%
%
%
% +--------------------------------+
% | IDENTIFICATION OF PRESENTATION |
% +--------------------------------+

% email address
\def\insertemail{}%
\newcommand{\email}[1]{\def\insertemail{#1}}%
% conference name or lecture name (+setting the lecture mode)
\def\MULconference{}%
\def\MULlecture{}%
\newcommand{\conference}[1]{%
	\def\MULconference{#1}%
	\MULLecturefalse%
}%
% keep beamer's original \lecture[<short>]{<title>}{<label>} (splitting a file into
% several lectures, see \includeonlylecture) available as \lectureBeamer, and let
% beamer's handling of text outside frames recognise it as it does \lecture
\let\lectureBeamer\lecture%
\patchcmd{\beamer@treat}{\ifx\beamer@nexttoken\lecture}{\ifx\beamer@nexttoken\lectureBeamer}{}{}%
% lecture mode: \lecture{<lecture name>}
\renewcommand{\lecture}[1]{%
	\def\MULlecture{#1}%
	\MULLecturetrue%
	% the hooks act only in lecture mode (a later \conference switches it off)
	\AtBeginSection{%
		\ifMULLecture\expandafter\@firstofone\else\expandafter\@gobble\fi{%
			\def\MULconference{\thesection{}~\insertsectionhead}%
			\begin{frame}{\insertsectionhead}%
				\vspace*{-2mm}\mbox{}\vfill%
				\tableofcontents[currentsection, subsectionstyle=hide]%
				\vfill\mbox{}%
			\end{frame}%
		}%
	}%
	\AtBeginSubsection{%
		\ifMULLecture%
			\def\MULconference{\thesection.\thesubsection{}~\insertsubsection}%
		\fi%
	}%
}%
% name of the conference/lecture
\newcommand{\insertconference}{\MULconference}%
% name of the lecture (used in "lectureFootings")
\newcommand{\insertMULlecture}{\MULlecture}%
% superscripts for affiliations
% (\texorpdfstring: omitted in the PDF metadata, e.g. the author list)
\newcommand{\aff}[1]{\texorpdfstring{\textsuperscript{#1}}{}}%
\let\origbeamerinstitute\institute
% institution name used in "defaultFootings"
\newcommand{\shortinstitute}{} % initially empty
% redefinition of \institute to have an optional entry for short institute name
\renewcommand{\institute}{%
  \@ifnextchar[% then call with optional argument
    \beamer@institute@opt
    \beamer@institute@noopt
}
\newcommand{\beamer@institute@opt}[2][]{%
  \def\shortinstitute{#1}%
  \origbeamerinstitute{#2}%
}
\newcommand{\beamer@institute@noopt}[1]{%
  \def\shortinstitute{#1}%
  \origbeamerinstitute{#1}%
}
%
%
% +-----------------------+%
% | CONVENIENCE FUNCTIONS |
% +-----------------------+
%
% literature to be printed above footer
\def\MUL@Literature{}%
\newcommand{\literature}[1]{\def\MUL@Literature{#1}}%
\newcommand{\insertLiterature}{\MUL@Literature}%
% commands for hiding some parts in handouts
\newcommand{\showResults}[1]{\ifthenelse{\boolean{MULShowResults}}{#1}{\phantom{#1}}}%
% highlighting
\newcommand{\Alert}[1]{{\color{MULgreen}#1}}%
% changes symbol in itemize for examples
\def\example{\item[\alert{\Stopsign}]\textit{Example: }}%
% user defined logo in the headings of slides
\newcommand{\setFrameLogo}[1]{\renewcommand{\MULframeLogo}{#1}}%
%
% environment for adding drawings with absolute coordinates w.r.t. to slide/text area
\newenvironment{overdraw}{%
	\setlength{\unitlength}{\paperwidth/16}%
	\ifMULIsSidebar%
		\begin{tikzpicture}[overlay, remember picture, shift={(current page.south west)}, xshift=\MULsideBarWidth]%
	\else%
		\begin{tikzpicture}[overlay, remember picture, shift={(current page.south west)}]%
	\fi%
}{%
	\end{tikzpicture}%
}%
% show grid for easier navigation on slide
\newcommand\framegrid{} % just for safety
\def\framegrid{%
	% Synopsis
	% \centerarc[draw options](center)(initial angle:final angle:radius)
	\draw[gray!10!white](0,0) grid[xstep=\dimexpr\paperwidth/160,ystep=\dimexpr\paperheight/90](\paperwidth,\paperheight);%
	\draw[gray!50!white](0,0) grid[xstep=\dimexpr\paperwidth/32,ystep=\dimexpr\paperheight/18](\paperwidth,\paperheight);%
	\draw[red](0,0) grid[xstep=\dimexpr\paperwidth/16,ystep=\dimexpr\paperheight/9](\paperwidth,\paperheight);%
	\foreach \x in {1,2,...,15} { \node [anchor=north] at (\x,0.5) {\textbf{\tiny\x}}; }%
	\foreach \x in {1,2,...,15} { \node [anchor=south] at (\x,8.5) {\textbf{\tiny\x}}; }%
	\foreach \y in {1,2,...,8} { \node [anchor=east] at (0.5,\y) {\textbf{\tiny\y}}; }%
	\foreach \y in {1,2,...,8} { \node [anchor=west] at (15.5,\y) {\textbf{\tiny\y}}; }%
}%
%
%
% +--------------------+
% | INTERNAL FUNCTIONS |
% +--------------------+

% \lastslide command for not counting the back up slides
\newcounter{MULlastslide}%
\setcounter{MULlastslide}{0}%
\newcommand{\lastslide}{\setcounter{MULlastslide}{\value{framenumber}}}%
\AtEndDocument{%
\ifthenelse{\equal{\value{MULlastslide}}{0}}{%
	\setcounter{MULlastslide}{\value{framenumber}}%
}{%
	\relax%
}%
\if@filesw%
\immediate\write\@auxout{\string\@writefile{nav}%
	{\noexpand\headcommand{\noexpand\gdef\noexpand\inserttotalframenumber{\arabic{MULlastslide}}}}}%
\fi%
}%
%
% in the lecture mode, add Table of Contents as the begining of each section
\patchcmd{\beamer@sectionintoc}{\vskip1.5em}{\vskip0.3em}{}{}%
\patchcmd\insertverticalnavigation{\dohead}{\vskip-25pt\dohead}{}{}%
\setbeamertemplate{section in toc}{\parbox[b]{0.6cm}{\raggedleft\Alert{\inserttocsectionnumber.}}\quad\inserttocsection}%
\setbeamertemplate{section in toc shaded}[default][100]%
