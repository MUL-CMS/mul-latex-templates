% Author: David Holec, david.holec@unileoben.ac.at
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul-beamer}[2025/06/16 v3.00  Beamer with a MUL/DMS layout]%
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
% MULOnlySlideNumbers: true if only slide numbers are to be added to footings (for printing slides)
\newif\ifMULOnlySlideNumbers
\MULOnlySlideNumbersfalse
% type of footings
\newif\ifMULDefaultFootings
\MULDefaultFootingstrue
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
\DeclareOption{emptyFootings}{\MULOnlySlideNumberstrue}%
% class option defaultFootings
\DeclareOption{defaultFootings}{\MULOnlySlideNumbersfalse\MULDefaultFootingstrue}%
% class option fullFootings
\DeclareOption{fullFootings}{\MULOnlySlideNumbersfalse\MULDefaultFootingsfalse}%
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
	\def\MULsloganText{Versetz’ Berge}%
}%
% class option ENlocalization
\DeclareOption{ENlocalization}{%
	\def\MULframeLogo{graphics/logo-mul_M}%
	\def\MULtitleLogo{graphics/logo-mul-en}%
	\def\MULsloganText{Move Mountains}%
}%
%
% class option showResults
\DeclareOption{showResults}{\MULShowResultstrue}%
% class option hideResults
\DeclareOption{hideResults}{\MULShowResultsfalse}%
%
% pass all other options to beamer
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%
% default behavior
\ExecuteOptions{beamer, slideSingleNumber, showothersubsections, showSidebar, DElocalization, defaultFootings}%
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
		\begin{beamercolorbox}[ht=0.04\paperheight, dp=0.014\paperheight, wd=\paperwidth]{author in head/foot}%
			% literature
			\begin{tikzpicture}%
				\path[use as bounding box] (0,0) rectangle (0,0);%
				\node[anchor=south east, shift={(\paperwidth-2ex,0.04\paperheight)}] at (0,0) {\parbox{0.8\paperwidth}{\raggedleft\color{black}\tiny\insertLiterature}};%
				\fill[MULgreen](0,0) -- (0.09\paperheight, 0) -- (0, 0.09\paperheight);%
			\end{tikzpicture}%
			\usebeamerfont{foot}%
			\hspace*{0.068\paperwidth}%
			\ifMULOnlySlideNumbers\else%
				% uni slogan
				{\usebeamerfont{MULslogan in foot}{\color{MULsloganSlideColor}\MULsloganText}}%
				\hfill%
				\ifMULDefaultFootings%
					% defaultFootings
					% author | organisation unit
					\parbox{6cm}{\centering\beamer@shortauthor | \beamer@shorttitle}%
				\else%
					% fullFootings
					% author & title ... conference / lecture title ... date
					\parbox{4cm}{\centering\beamer@shortauthor: \beamer@shorttitle}%
					\hfill%
					\parbox{4cm}{\centering\MULconference}%
					\hfill%
					\parbox{2cm}{\centering\mbox{}\hfill\parbox{1.7cm}\insertdate}%
				\fi%
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
% TITLE PAGE
% additional graphics and other elements to be included on the title page
\def\MULtitleAdditions{}%
\newcommand{\additionsToTitlePage}[1]{\def\MULtitleAdditions{#1}}%
\newcommand{\insertadditionsToTitlePage}{\MULtitleAdditions}%
\setbeamertemplate{title page}{%
	\begin{tikzpicture}[overlay, remember picture]%
		\path[use as bounding box] (current page.south west) rectangle (current page.north east);%
		% background, logo and slogan
		\node at (current page.center) {\includegraphics[width=\paperwidth]{graphics/background_title.jpg}};%
		\node[anchor=north east, shift={(-0.04\paperheight,-0.04\paperheight)}] at (current page.north east) {\includegraphics[width=0.084\paperwidth]{\MULtitleLogo}};%
		\node[anchor=south west, shift={(0.00\paperheight, 0.00\paperheight)}] at (current page.south west) {\usebeamerfont{MULslogan in title}{\color{MULsloganTitleColor}\MULsloganText}};%
		% title
		\node[anchor=south, shift={(0,0.02\paperwidth)}] at (current page.center) {\parbox{0.9\paperwidth}{%
			\centering%
			\usebeamerfont{title}{\usebeamercolor{title}\color{fg}\bfseries\funneldisplay\inserttitle}%
		}};%
		% affiliations, email, conference name, date
		\node[anchor=north, shift={(0,0\paperwidth)}] at (current page.center) {\parbox{0.9\paperwidth}{%
			\centering%
			\usebeamerfont{author}{\color{MULaddress}\insertauthor}\par\medskip%
			\usebeamerfont{institute}{\color{MULaddress}
				\insertinstitute\par\smallskip
				\ifblank{\insertemail}{}{\href{mailto:\insertemail}{\insertemail}\par\bigskip}%
				\ifblank{\insertconference}{}{\insertconference\par\smallskip}%
				\ifblank{\insertdate}{}{\insertdate}
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
\usecolortheme[RGB={0, 115, 126}]{structure}%
\definecolor{MULgreen}{RGB}{0, 115, 126}%
\definecolor{MULturquoise}{RGB}{0, 255, 254}%
\definecolor{MULaddress}{RGB}{58, 57, 56}%
\definecolor{MULgray}{RGB}{166, 166, 166}%
\definecolor{plotblue}{RGB}{31,119,180}%
\definecolor{plotgreen}{RGB}{44,160,44}%
\definecolor{plotorange}{RGB}{255,127,14}%
\definecolor{plotred}{RGB}{214,39,40}%
\definecolor{plotpurple}{RGB}{148, 103, 189}%
\definecolor{plotbrown}{RGB}{140, 86, 75}%
\colorlet{MULsloganTitleColor}{MULgreen}%
\colorlet{MULsloganSlideColor}{MULturquoise}%
%
% alerted text
\setbeamercolor{alerted text}{fg=red!80!black}%
% boxes
\setbeamercolor{block title}{use=structure,fg=structure.fg,bg=structure.fg!25!bg!90!black}%
\setbeamercolor{block body}{parent=normal text,use=block title,bg=block title.bg!25!bg}%
% titles
\setbeamercolor{frametitle}{fg=MULgreen}%
% ToC
\setbeamercolor{section in toc}{parent=alerted text}%
\setbeamercolor{section in toc shaded}{fg=normal text.fg!50}%
% footings
\setbeamercolor{author in head/foot}{fg=white, bg=MULgreen}%
%
%
% +-------+
% | FONTS |
% +-------+
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
\setbeamerfont{author}{size=\normalsize}%
\setbeamerfont{institute}{size=\footnotesize}%
\setbeamerfont{frametitle}{size=\LARGE, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULslogan in title}{size=\large, series=\bfseries, family=\funneldisplay}%
\setbeamerfont{MULslogan in foot}{size=\scriptsize, series=\bfseries, family=\funneldisplay}%
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
\newcommand{\conference}[1]{%
	\def\MULconference{#1}%
	\MULLecturefalse%
}%
\renewcommand{\lecture}[1]{
	\MULLecturetrue%
	\AtBeginSection{%
		\def\MUL@conference{\thesection{}~\insertsectionhead}%
		\begin{frame}{\insertsectionhead}%
			\vspace*{-2mm}\mbox{}\vfill%
			\tableofcontents[currentsection, subsectionstyle=hide]%
			\vfill\mbox{}%
		\end{frame}%
	}%
	\AtBeginSubsection{%
		\def\MULconference{\thesection.\thesubsection{}~\insertsubsection}%
	}%
}%
% name of the conference/lecture
\newcommand{\insertconference}{\MULconference}%
% superscripts for affiliations
\newcommand{\aff}[1]{\textsuperscript{#1}}%
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
\newcounter{beamerLeobenlastslide}%
\setcounter{beamerLeobenlastslide}{0}%
\newcommand{\lastslide}{\setcounter{beamerLeobenlastslide}{\value{framenumber}}}%
\AtEndDocument{%
\message{\arabic{beamerLeobenlastslide}}%
\ifthenelse{\equal{\value{beamerLeobenlastslide}}{0}}{%
	\setcounter{beamerLeobenlastslide}{\value{framenumber}}%
}{%
	\relax%
}%
\if@filesw%
\immediate\write\@auxout{\string\@writefile{nav}%
	{\noexpand\headcommand{\noexpand\def\noexpand\inserttotalframenumber{\arabic{beamerLeobenlastslide}}}}}%
\newwrite\tf@nav%
\immediate\openout\tf@nav\jobname.nav\relax%
\fi%
}%
%
% in the lecture mode, add Table of Contents as the begining of each section
\patchcmd{\beamer@sectionintoc}{\vskip1.5em}{\vskip0.3em}{}{}%
\patchcmd\insertverticalnavigation{\dohead}{\vskip-25pt\dohead}{}{}%
\setbeamertemplate{section in toc}{\parbox[b]{0.6cm}{\raggedleft\Alert{\inserttocsectionnumber.}}\quad\inserttocsection}%
\setbeamertemplate{section in toc shaded}[default][100]%
