\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul_poster}[2019/09/25 MontanUni Poster Class by David Holec]%
%
% based on the a0poster package
% intended for use with pdfLaTeX, i.e. use with tikz
\LoadClass[a0, portrait]{a0poster}%
%
% use calc expressions for length
\RequirePackage{calc}%
%
% define poster geometry
\RequirePackage[margin=2cm]{geometry}%
% separation of boxes
\newlength{\dhBoxSep}%
\setlength{\dhBoxSep}{2cm}%
% number of columns and their width
\def\dhNumCols{2}%
\newlength{\dhColumnWidth}%
\setlength{\dhColumnWidth}{(\textwidth-\dhBoxSep)/\dhNumCols}%
% width of vertical title bars
\newlength{\dhTitleBarWidth}%
\setlength{\dhTitleBarWidth}{3cm}%
\newlength{\dhBoxMargin}%
\setlength{\dhBoxMargin}{3mm}%
% fonts
\RequirePackage{arev}
%
% graphics, color
\RequirePackage{graphicx}%
\RequirePackage[x11names]{xcolor}%
\RequirePackage{tikz}%
\usetikzlibrary{fit}%
\RequirePackage{contour}%
%
\RequirePackage{ifthen}%
%
%
% -------------- end of packages and option declarations ------------------
%
%
% from marvosym.sty -- email symbol
\newcommand\dhEmailSymbol{{\fontfamily{mvs}\fontencoding{U}\fontseries{m}\fontshape{n}\selectfont\char66{}}}%
%
% definition of highlighted coulours
\definecolor{MULgreen}{RGB}{34,144,141}%
\newcommand{\alert}[1]{{\color{Red3}#1}}%
\newcommand{\Alert}[1]{{\color{MULgreen}#1}}%
%

%% redefinition of the \section command - different spacing + '.' after the section's number
\renewcommand{\thesection}{\arabic{section}.}
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-0.1ex \@plus -1ex \@minus -.2ex}%
  {0.2ex \@plus.2ex}%
  {\normalfont\large\bfseries}}%
\renewcommand\subsection{\@startsection{subsection}{1}{\z@}%
  {-0.1ex \@plus -1ex \@minus -.2ex}%
  {0.2ex \@plus.2ex}%
  {\normalfont\bfseries}}%
%% get rid of the ``section'' title in bibliography
\renewenvironment{thebibliography}[1]
     {\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% know deficiency of tikz
% https://tex.stackexchange.com/questions/449145/savebox-doesnt-work-inside-tikz-foreach-loop
\newcommand{\tikzSaveBox}[2]{
     \begin{pgfinterruptpicture}%
     \begin{lrbox}{0\null\global\setbox\csname#1\endcsname}%
     #2
     \end{lrbox}%
     \end{pgfinterruptpicture}
}
% posterBox
\newsavebox{\dhBox}%
\newlength{\dhBoxHeight}%
\newlength{\dhBoxWidth}%
\newlength{\dhBoxLeft}%
\newlength{\dhBoxBottom}%
\newlength{\dhBoxTextWidth}%
% \posterBox{width}(pos_x, pos_y){title}{contents}  -- with section number
% \posterBox*{width}(pos_x, pos_y){title}{contents} -- no section number
% position x: in units of columns
% position y: in units of box separations
\def\posterBox{\@ifstar\@posterBox\@@posterBox}%
\def\@posterBox#1(#2,#3)#4#5{\@@@posterBox{#1}(#2,#3){\protect\section*{#4}}{#5}}%
\def\@@posterBox#1(#2,#3)#4#5{\typeout{--> Box: #4}\@@@posterBox{#1}(#2,#3){\protect\section{#4}}{#5}}%
\def\@@@posterBox#1(#2,#3)#4#5{%
  % set up lengths
  \setlength{\dhBoxLeft}{#2\dhColumnWidth+#2\dhBoxSep}%
  \setlength{\dhBoxWidth}{#1\dhColumnWidth+#1\dhBoxSep-\dhBoxSep}%
  \setlength{\dhBoxTextWidth}{\dhBoxWidth-4\dhBoxMargin-0.9\dhTitleBarWidth}%
  \tikzSaveBox{dhBox}{\begin{minipage}{\dhBoxTextWidth}\protect#5\end{minipage}}%
  \setlength{\dhBoxHeight}{\ht\dhBox+\dp\dhBox+\dhBoxMargin}%
  \setlength{\dhBoxBottom}{\dhBoxHeight+#3\dhBoxSep}%
  % draw elements
  \draw[fill, left color=MULgreen, right color=white, draw=none] (\dhBoxLeft, \textheight-\dhHeaderHight-#3\dhBoxSep-\dhBoxHeight-2\dhBoxMargin) rectangle + (\dhTitleBarWidth, \dhBoxHeight+2\dhBoxMargin);%
  \node[right] at (\dhBoxLeft+0.9\dhTitleBarWidth+\dhBoxMargin, \textheight-\dhHeaderHight-#3\dhBoxSep-\dhBoxHeight/2-\dhBoxMargin) {\usebox{\dhBox}};%
  \node at (\dhBoxLeft+0.35*\dhTitleBarWidth, \textheight-\dhHeaderHight-#3\dhBoxSep-\dhBoxHeight/2-\dhBoxMargin) {\rotatebox{90}{\parbox{\dhBoxHeight}{\centering#4}}};%
  \draw[line width=1mm] (\dhBoxLeft, \textheight-\dhHeaderHight-#3\dhBoxSep-\dhBoxHeight-2\dhBoxMargin) rectangle + (\dhBoxWidth, \dhBoxHeight+2\dhBoxMargin);%
  \typeout{--> Box bottom position: \the\dhBoxBottom(fraction will be \the\dhBoxBottom/\the\dhBoxSep)}
}%
%
% header
\def\dhAuthorPhoto{}%
\newcommand{\authorPhoto}[1]{\def\dhAuthorPhoto{#1}}%
\def\dhTitle{}%
\renewcommand{\title}[1]{\def\dhTitle{#1}}%
\def\dhAuthors{}%
\renewcommand{\author}[1]{\def\dhAuthors{#1}}%
\def\dhInstitute{}%
\newcommand{\institute}[1]{\def\dhInstitute{#1}}%
\def\dhEmail{}%
\newcommand{\email}[1]{\def\dhEmail{#1}}%
\newcommand{\aff}[1]{\textsuperscript{#1}}%
%
\newlength{\dhHeaderHight}
\setlength{\dhHeaderHight}{0pt}
\newcommand{\makeHeader}{%
  \tikzSaveBox{dhBox}{
  \begin{tikzpicture}
    \node[above right] at (0,0) {\includegraphics[height=10cm]{graphics/logo_MU}};
    \node[above right] at (8cm, -0.5cm) {\includegraphics[height=11cm]{graphics/DMSbackground}};
    \node[above left] at (\textwidth, 0.5) {\includegraphics[height=1.5cm]{graphics/DMSname}};
    \node[above left] at (\textwidth, 2.5) {\includegraphics[height=7cm]{graphics/DMSlogo}};
    \ifthenelse{\equal{\dhAuthorPhoto}{}}{}{
      \node[above left, draw, MULgreen, line width=1.5mm, inner sep=1mm] at (\textwidth-5cm, 2.5) {\includegraphics[height=7cm]{\dhAuthorPhoto}};
    }
    \node[below right] at (9cm,9.5cm){\begin{minipage}{0.8\textwidth}
      \color{white}\bfseries
      \Huge\contourlength{1mm}\contour*{MULgreen}{\protect\scalebox{0.75}[1.]{\dhTitle}}\medskip\\
      \Large\scalebox{0.75}[1.]{\dhAuthors}\bigskip\\
      \normalfont\small\slshape\dhInstitute      
    \end{minipage}};
    \ifthenelse{\equal{\dhEmail}{}}{}{
      \node[above left] at (\textwidth-12cm, 0.5cm) {\color{white}\normalfont\small\dhEmailSymbol{ }\dhEmail};
    }
  \end{tikzpicture}
  }
  \setlength{\dhBoxHeight}{\ht\dhBox+\dp\dhBox}%
  \node[right] at (0,\textheight-\dhBoxHeight/2) {\usebox{\dhBox}};
  \setlength{\dhHeaderHight}{\dhBoxHeight+\dhBoxSep/2}
}%
%
\pagestyle{empty}% switch off page numbers on a poster, obviously, and section numbers too.
%% noindentation
\setlength{\parindent}{0pt}
\setlength{\parskip}{1eX}
%
%% different item symbols
\renewcommand{\labelitemi}{{\color{MULgreen}$\blacktriangleright$}}
\renewcommand{\labelitemii}{{\color{MULgreen}$\bullet$}}
\AtBeginDocument{
\begin{tikzpicture}
  \draw[use as bounding box, draw=none] (0,0) rectangle (\textwidth,\textheight-1pt);
}
\AtEndDocument{
% \node[
%       draw=red,
%       minimum width=\textwidth,
%       minimum height=\textheight-5pt,
%       fit=(current bounding box.north west) (current bounding box.south east),
%     ] at (current bounding box.north){};
\end{tikzpicture}
}
