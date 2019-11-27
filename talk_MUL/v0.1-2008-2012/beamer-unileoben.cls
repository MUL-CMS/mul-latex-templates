% David Holec, david.holec@unileoben.ac.at
%
% -------------------------------- HEADER -----------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{beamer-unileoben}[2012/08/28 v0.2 David's amends to the beamer class for the at IMW, University of Leoben, Austria]
% 
% the class is based on the beamer class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\PassOptionsToClass{
  10pt,                 % smaller fonts
  t,                    % slides aligned to top
  xcolor=pst,           % xcolor settings for PSTricks
  dvips                 % to be used with dvips + pstopdf
}{beamer}
\ProcessOptions
\LoadClass{beamer}
%
% loading additional packages
\RequirePackage{ifthen}
\RequirePackage{calc}
%
% ---------------------------- END OF HEADER --------------------------------
%
%
% ------------------------------ ADDITIONS ----------------------------------
%
% commands for hiding some parts in handouts
\newboolean{showResults}
\setboolean{showResults}{true}
\newcommand{\showResults}[1]{\ifthenelse{\boolean{showResults}}{#1}{\phantom{#1}}}
%
% literature to be printed above footer
\def\beamer@Leoben@Literature{}
\newcommand{\literature}[1]{\def\beamer@Leoben@Literature{#1}}
\newcommand{\insertLiterature}{\beamer@Leoben@Literature}
%
% \lastslide command for not counting the back up slides
\newcounter{beamerLeobenlastslide}
\setcounter{beamerLeobenlastslide}{0}
\newcommand{\lastslide}{\setcounter{beamerLeobenlastslide}{\value{framenumber}}}
\AtEndDocument{%
  \message{\arabic{beamerLeobenlastslide}}
  \ifthenelse{\equal{\value{beamerLeobenlastslide}}{0}}{
    \setcounter{beamerLeobenlastslide}{\value{framenumber}}
  }{
    \relax
  }
  \if@filesw
      \immediate\write\@auxout{\string\@writefile{nav}%
        {\noexpand\headcommand{\noexpand\def\noexpand\inserttotalframenumber{\arabic{beamerLeobenlastslide}}}}}
      \newwrite\tf@nav
      \immediate\openout\tf@nav\jobname.nav\relax
    \fi
}
% -------------------------- END OF ADDITIONS -------------------------------
%
%
% --------------------- DEFINITION OF THE STYLE -----------------------------
% loading the predefined schemes
\mode<presentation>{
  \useoutertheme[
    height=1.2\baselineskip,            % height of the title bar
    width=8.5eX,                        % width of the side bar
    hideothersubsections                % show only subsections from current section
  ]{sidebar}                            % outer style with ToC
  \useinnertheme[shadow]{rounded}       % inner style
  \usecolortheme[RGB={22,91,231}]{structure}
                                        % default colour scheme tuned to IMW
}
% no navigation symbols
\setbeamertemplate{navigation symbols}{}
% uncover everything in a step-wise fashion
\beamerdefaultoverlayspecification{<+->}
% use triangles in itemize environments
\setbeamertemplate{items}[default]
%
% COLOURS
\setbeamercolor{frametitle}{fg=white}   % frame title
\setbeamercolor{alerted text}{fg=red!80!black} % alerted text
% tune colours for the framed boxes
\setbeamercolor{block title}{use=structure,fg=structure.fg,bg=structure.fg!25!bg!90!black}
\setbeamercolor{block body}{parent=normal text,use=block title,bg=block title.bg!25!bg}
%
% FRAME DESIGN
% adding a MUL header and shifting the frame title
\addtobeamertemplate{frametitle}{
  \vskip0.2eX
  \let\originalinsertframetitle\insertframetitle
  \renewcommand{\insertframetitle}{
    \hspace*{-\beamer@sidebarwidth}
    \unitlength=1eX
    \begin{picture}(0,0)
      \put(-2,-1.35){\includegraphics[width=0.998\paperwidth]{mul_heading.eps}}
    \end{picture}
    \hspace*{8.2eX}\originalinsertframetitle
  }
}{}
% adding footings
\newlength{\footerConferenceLeftMargin}
\newlength{\footerConferenceWidth}
\defbeamertemplate*{footline}{sidebar theme}{
  \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,leftskip=.3cm,rightskip=.3cm plus1fil]{author in head/foot}%
    \unitlength=1eX
    \setlength{\footerConferenceLeftMargin}{\widthof{\beamer@shortauthor: \beamer@shorttitle}}
    \setlength{\footerConferenceWidth}{149eX-\widthof{\insertdate}}
    \begin{picture}(0,0)
      \ifnum\insertframenumber>1
        \put(2,-6.5){\includegraphics[width=0.9\paperwidth]{mul_footing.eps}}   % graphics
        \put(151,0){\parbox{8eX}{\mbox{}\hfill\insertframenumber/\inserttotalframenumber\hfill\mbox{}}} % frame numbers
        \put(3,0){\mbox{\usebeamercolor[fg]{frametitle}\beamer@shortauthor: \beamer@shorttitle}}        % author & title
        \put(119,0){\parbox{30eX}{\raggedleft\usebeamercolor[fg]{frametitle}\insertdate}}               % date
        \put(3,0){\parbox{\footerConferenceWidth}{\hspace*{\footerConferenceLeftMargin}\mbox{}\hfill\usebeamercolor[fg]{frametitle}\beamer@leoben@conference\hfill\mbox{}}}     % conference / lecture title centered
        \put(0,4){\parbox[b]{149eX}{\mbox{}\hfill\color{black}\tiny\insertLiterature}}                  % literature
      \else
        % no author & title on the title slide, longer graphics
        \put(2,-6.5){\includegraphics[width=0.9\paperwidth]{mul_footing.eps}}
      \fi
    \end{picture}
  \end{beamercolorbox}
}
%
% SIDEBAR
% removing presentation name and title from the sidebar
\renewcommand{\insertshortauthor}[1][]{}
\renewcommand{\insertshorttitle}[1][]{}
%
% suppressing the side bar on the title page
% (modified code from beamer/themes/outer/beamerouterthemesidebar.sty)
\defbeamertemplate*{sidebar \beamer@sidebarside}{}
  {
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
    \ifnum\insertframenumber>1
      \insertverticalnavigation{\beamer@sidebarwidth}%
    \fi
    \vfill
    \ifx\beamer@sidebarside\beamer@lefttext%
    \else%
      \usebeamercolor{normal text}%
      \llap{\usebeamertemplate***{navigation symbols}\hskip0.1cm}%
      \vskip2pt%
    \fi%
  }%
%
% TITLE PAGE
\setbeamertemplate{title page}
{
  \hspace*{-\beamer@sidebarwidth}
  \unitlength=1eX
  \begin{picture}(0,0)
    \put(-3.85,3.5){\includegraphics[width=0.998\paperwidth]{mul_heading.eps}}
  \end{picture}
  \vskip2eX\hspace{-7eX}{\usebeamerfont{title}\textbf{\inserttitle}\par}
  \vskip-1eX\hspace{-7eX}\rule{9cm}{0.01cm}\par
  \vskip0eX\hspace{-7eX}{\usebeamerfont{subtitle}\textbf{\insertsubtitle}}\par
  \vskip5eX{\usebeamerfont{author}\textbf{\insertauthor}}\par
  \begin{picture}(0,0)
    \put(-7,-2){\includegraphics[width=1cm]{mul_crest.eps}}
    \insertadditionsToTitlePage
  \end{picture}
  \vskip2eX{\usebeamerfont{institute}\insertinstitute}\par
  \vskip4eX{\usebeamerfont{institute}\insertemail}\par
  \vskip4eX{\usebeamerfont{institute}\insertdate}\par
}
% email address
\def\beamer@leoben@email{}
\newcommand{\email}[1]{\def\beamer@leoben@email{#1}}
\newcommand{\insertemail}{\beamer@leoben@email}
% conference name
\def\beamer@leoben@conference{}
\newcommand{\conference}[1]{\def\beamer@leoben@conference{#1}}
\def\lecture{}
\renewcommand{\lecture}[1]{\def\beamer@leoben@conference{#1}}
\newcommand{\insertconference}{\beamer@leoben@conference}
% additional graphics and other elements to be included on the title page
\def\beamer@leoben@titleAdditions{}
\newcommand{\additionsToTitlePage}[1]{\def\beamer@leoben@titleAdditions{#1}}
\newcommand{\insertadditionsToTitlePage}{\beamer@leoben@titleAdditions}
% redefine font sizes
\setbeamerfont{title}{size=\large,parent=structure}
\setbeamerfont{subtitle}{size=\footnotesize,parent=title}
\setbeamerfont{institute}{size=\footnotesize}
% ----------------- END OF DEFINITION OF THE STYLE --------------------------