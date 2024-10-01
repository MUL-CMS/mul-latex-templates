% Author: David Holec, david.holec@unileoben.ac.at
%
%%% TODO: Add here version history
% The template is primarily used for making presentations in two modes given as an option to the class:
% * beamer [default]: for presenting:
%                       16:10 aspect ratio with sidebar ToC
%                       overlays
%                       results shown by default
% * trans:            for printing handouts:
%                       4:3 aspect ratio without sidebar
%                       no overlays (1 slide per frame)
%                       results not shown by default
% TODO Document all features!
% \setbeamercovered{transparent}
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{beamerDMS}[2023/02/22 v2.00  Beamer with a MUL/DMS layout]%
% 
\RequirePackage{ifthen}%
\RequirePackage{tikz}%
%
% DMSIsSidebar: true for beamer mode, false for trans mode
\newboolean{DMSIsSidebar}%
\setboolean{DMSIsSidebar}{true}%
% DMSShowResults: true if content of \showResults{} to be shown
\newboolean{DMSShowResults}%
\setboolean{DMSShowResults}{true}%
% DMSOnlySlideNumbers: true if only slide numbers are to be added to footings (for printing slides)
\newboolean{DMSOnlySlideNumbers}%
\setboolean{DMSOnlySlideNumbers}{false}%
% DMSlecture: true if the presentation is a lecture (addding ToC as the begining of sections)
\newboolean{DMSLecture}%
\setboolean{DMSLecture}{false}%
% 
% class option showSidebar%
\DeclareOption{showSidebar}{\setboolean{DMSIsSidebar}{true}}%
% class option hideResults%
\DeclareOption{hideSidebar}{\setboolean{DMSIsSidebar}{false}}%
%
% class option showResults%
\DeclareOption{showResults}{\setboolean{DMSShowResults}{true}}%
% class option hideResults%
\DeclareOption{hideResults}{\setboolean{DMSShowResults}{false}}%
%
% class option showResults%
\DeclareOption{emptyFootings}{\setboolean{DMSOnlySlideNumbers}{true}}%
% class option hideResults%
\DeclareOption{fullFootings}{\setboolean{DMSOnlySlideNumbers}{false}}%
% 
% class option slideSingleNumber: slides numbered as #(slide)
\DeclareOption{slideSingleNumber}{\def\frameNumber{\insertframenumber}}%
% class option slideTotalNumber: slides numbered as #(slide)/#(total)
\DeclareOption{slideTotalNumber}{\def\frameNumber{\insertframenumber/\inserttotalframenumber}}%
% 
% class option hideothersubsections: only section titles are shown for inactive sections in ToC
\DeclareOption{hideothersubsections}{\def\DMShideothersubsections{hideothersubsections}}%
% class option showothersubsections: all subsections are shown in ToC
\DeclareOption{showothersubsections}{\def\DMShideothersubsections{}}%
%
% pass all other options to beamer
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%
% default behavior
\ExecuteOptions{beamer, slideSingleNumber, showothersubsections, showSidebar}%
\ProcessOptions%
% other general options for the beamer class
\PassOptionsToClass{%
	10pt,% default font size
	t,% slides aligned to top
	aspectratio=169,% new layout using ONLY 16:9 aspect ratio
}{beamer}%
\LoadClass{beamer}%
% 
% 
% other required packages
\RequirePackage{calc}%
\RequirePackage{marvosym}% for example signs
\RequirePackage{microtype}% for typesetting the slogan
%
% 
% no navigation symbols
\setbeamertemplate{navigation symbols}{}
% uncover everything in a step-wise fashion
\beamerdefaultoverlayspecification{<+->}
% use triangles in itemize environments
\setbeamertemplate{items}[default]
\setbeamertemplate{blocks}[rounded][shadow=true]
% 
%
% % % % % % % % %
% FRAME DESIGN  %
% % % % % % % % %
% 
% load SIDEBAR with ToC
\ifthenelse{\boolean{DMSIsSidebar}}{%
	\useoutertheme[%
	height=0mm,%  height of the title bar
	width=2cm,% width of the side bar
	\DMShideothersubsections% show only subsections from current section
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
		\ifx\beamer@sidebarside\beamer@lefttext%
		\else%
		\usebeamercolor{normal text}%
		\llap{\usebeamertemplate***{navigation symbols}\hskip0.1cm}%
		\vskip2pt%
		\fi%
	}%
}{}%
%
%
%
\newcommand{\DMS@frameLogo}{graphics/logo_MUL_hor}%
\newcommand{\setFrameLogo}[1]{\renewcommand{\DMS@frameLogo}{#1}}%
% FRAME HEADINGS
\newlength{\DMStitleWidth}%
\ifthenelse{\boolean{DMSIsSidebar}}{%
	\setlength{\DMStitleWidth}{\paperwidth-2cm}%
}{%
	\setlength{\DMStitleWidth}{\paperwidth}%
}%
\setbeamertemplate{frametitle}{%
	\begin{beamercolorbox}[ht=1eX, dp=0.0eX, wd=\DMStitleWidth]{frametitle}%
		\hfill\insertframetitle\hfill%
% 		\\includegraphics[height=5mm]{\DMS@frameLogo}%
% 		\hspace{0.5eX}%
		\begin{tikzpicture}[overlay]%
			\path[use as bounding box] (0,0) rectangle (0,0);%
			\node[anchor=south east, shift={(0,-0.015\paperwidth)}] at (0,0) {\includegraphics[height=5mm]{\DMS@frameLogo}};%
		\end{tikzpicture}%
	\end{beamercolorbox}%
}%
% 
% 
% FRAME FOOTINGS
\newlength{\footerConferenceLeftMargin}%
\defbeamertemplate*{footline}{sidebar theme}{%
	\begin{beamercolorbox}[ht=1eX, dp=1eX, wd=\paperwidth]{author in head/foot}%
% 	exclude footing on the title page
	\ifnum\insertframenumber>1
		\hspace*{3eX}%
		\ifthenelse{\boolean{DMSOnlySlideNumbers}}{}{%
	% 		uni logo
			\includegraphics[height=2eX]{graphics/logo_MUL_M}\ \scalebox{0.75}[0.9]{\textls[200]{\DMSsloganText}}%
			\hfill%
	% 		author & title
			\parbox{4cm}{\centering\usebeamercolor[fg]{frametitle}\beamer@shortauthor: \beamer@shorttitle}%
			\hfill%
	% 		conference / lecture title centered
			\parbox{4cm}{\centering\usebeamercolor[fg]{frametitle}\DMS@conference}%
			\hfill%
	% 		date
			\parbox{2cm}{\centering\usebeamercolor[fg]{frametitle}\mbox{}\hfill\parbox{1.7cm}\insertdate}%
		}%
		\hfill%
% 		frame numbers
		\parbox{1cm}{\raggedleft\frameNumber}%
		\hspace*{3eX}%
% 		literature
		\begin{tikzpicture}%
			\path[use as bounding box] (0,0) rectangle (0,0);%
			\node[anchor=south east, shift={(-2.5ex,0.7em)}] at (0,0) {\parbox{12.5cm}{\raggedleft\color{black}\tiny\insertLiterature}};%
		\end{tikzpicture}%
	\fi%
	\end{beamercolorbox}%
}%
%
% 
% TITLE PAGE
% additional graphics and other elements to be included on the title page
\def\DMS@titleAdditions{}%
\newcommand{\additionsToTitlePage}[1]{\def\DMS@titleAdditions{#1}}%
\newcommand{\insertadditionsToTitlePage}{\DMS@titleAdditions}%
\setbeamertemplate{title page}{%
	\begin{tikzpicture}[overlay, remember picture]%
		\path[use as bounding box] (current page.south west) rectangle (current page.north east);%
		\node at (current page.center) {\includegraphics[width=\paperwidth]{graphics/background_title.jpg}};%
		\node[anchor=north east, shift={(-0.01\paperwidth,-0.01\paperwidth)}] at (current page.north east) {\includegraphics[width=0.11\paperwidth]{graphics/logo_MUL_hor}};%
		\node[anchor=south, shift={(0,0.04\paperwidth)}] at (current page.south) {\color{DMSslogan}\large\scalebox{1}[0.9]{\textls[150]{\DMSsloganText}}};%
		\node[anchor=south, shift={(0,0.02\paperwidth)}] at (current page.center) {\parbox{0.8\paperwidth}{%
			\centering%
			\usebeamerfont{title}{\usebeamercolor{title}\color{fg}\inserttitle}%
		}};%
		\node[anchor=north, shift={(0,0\paperwidth)}] at (current page.center) {\parbox{0.8\paperwidth}{%
			\centering%
			\usebeamerfont{author}{\color{DMSaddress}\insertauthor}\par\bigskip%
			\usebeamerfont{institute}{\color{DMSaddress}\insertinstitute\par\smallskip\insertemail}\par\bigskip%
			\usebeamerfont{institute}{\color{DMSaddress}\insertdate}%
		}};%
		\insertadditionsToTitlePage%
	\end{tikzpicture}
}%
% 
% 
% COLORS
\usecolortheme[RGB={0, 115, 126}]{structure}%
\definecolor{MULgreen}{RGB}{0, 115, 126}%
\definecolor{DMSaddress}{RGB}{58, 57, 56}%
\definecolor{DMSslogan}{RGB}{166, 166, 166}%
\definecolor{plotblue}{RGB}{31,119,180}%
\definecolor{plotgreen}{RGB}{44,160,44}%
\definecolor{plotorange}{RGB}{255,127,14}%
\definecolor{plotred}{RGB}{214,39,40}%
\definecolor{plotpurple}{RGB}{148, 103, 189}%
\definecolor{plotbrown}{RGB}{140, 86, 75}%
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
\setbeamercolor{author in head/foot}{fg=DMSslogan, bg=white}%
% 
% 
% FONTS
\setbeamerfont{title}{size=\huge}%
\setbeamerfont{author}{size=\normalsize}%
\setbeamerfont{institute}{size=\footnotesize}%
\setbeamerfont{frametitle}{size=\Large}%
% 
% 
% email address
\def\DMS@email{}%
\newcommand{\email}[1]{\def\DMS@email{#1}}%
\newcommand{\insertemail}{\DMS@email}%
% conference name or lecture name (+setting the lecture mode)
\def\DMS@conference{}%
\newcommand{\conference}[1]{\def\DMS@conference{#1}\setboolean{DMSLecture}{false}}%
\renewcommand{\lecture}[1]{\def\DMS@conference{#1}\setboolean{DMSLecture}{true}%
	\AtBeginSection{%
		\def\DMS@conference{\thesection{}~\insertsection}%
		\begin{frame}{\insertsection}%
			\vspace*{-2mm}\mbox{}\vfill%
			\tableofcontents[currentsection, subsectionstyle=hide]%
			\vfill\mbox{}%
		\end{frame}%
	}%
	\AtBeginSubsection{%
		\def\DMS@conference{\thesection.\thesubsection{}~\insertsubsection}%
	}%
}%
\newcommand{\insertconference}{\DMS@conference}%
\newcommand{\aff}[1]{\textsuperscript{#1}}%
% MUL 'fancy slogan'
\newcommand{\DMSsloganText}{WHERE RESEARCH MEETS THE FUTURE}%
% 
% literature to be printed above footer
\def\DMS@Literature{}%
\newcommand{\literature}[1]{\def\DMS@Literature{#1}}%
\newcommand{\insertLiterature}{\DMS@Literature}%
% 
%
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
% 
% in the lecture mode, add Table of Contents as the begining of each section
\patchcmd{\beamer@sectionintoc}{\vskip1.5em}{\vskip0.3em}{}{}%
\patchcmd\insertverticalnavigation{\dohead}{\vskip-25pt\dohead}{}{}%
\setbeamertemplate{section in toc}{\parbox[b]{0.6cm}{\raggedleft\Alert{\inserttocsectionnumber.}}\quad\inserttocsection}%
\setbeamertemplate{section in toc shaded}[default][100]%
% 
% 
% % % % % % % % % % % % %
% OTHER USEFUL COMMANDS %
% % % % % % % % % % % % %
% 
% commands for hiding some parts in handouts
\newcommand{\showResults}[1]{\ifthenelse{\boolean{DMSShowResults}}{#1}{\phantom{#1}}}%
% highlighting
\newcommand{\Alert}[1]{{\color{MULgreen}#1}}%
% changes symbol in itemize for examples
\def\example{\item[\alert{\Stopsign}]\textit{Example: }}%
%
%
\newcommand\framegrid{} % just for safety
\def\framegrid{%
% Synopsis
% \centerarc[draw options](center)(initial angle:final angle:radius)
\draw[gray!10!white](0,0) grid[xstep=\dimexpr\paperwidth/160,ystep=\dimexpr\paperheight/90](\paperwidth,\paperheight);%
\draw[gray!50!white](0,0) grid[xstep=\dimexpr\paperwidth/32,ystep=\dimexpr\paperheight/20](\paperwidth,\paperheight);%
\draw[red](0,0) grid[xstep=\dimexpr\paperwidth/16,ystep=\dimexpr\paperheight/9](\paperwidth,\paperheight);%
\foreach \x in {1,2,...,15} { \node [anchor=north] at (\x,0.5) {\textbf{\tiny\x}}; }%
\foreach \x in {1,2,...,15} { \node [anchor=south] at (\x,8.5) {\textbf{\tiny\x}}; }%
\foreach \y in {1,2,...,8} { \node [anchor=east] at (0.5,\y) {\textbf{\tiny\y}}; }%
\foreach \y in {1,2,...,8} { \node [anchor=west] at (15.5,\y) {\textbf{\tiny\y}}; }%
}%
%
%
\newenvironment{overdraw}{%
	\setlength{\unitlength}{\paperwidth/16}%
	\begin{tikzpicture}[overlay, remember picture,shift={(current page.south west)}]
}{%
	\end{tikzpicture}%
}%
