% Author: David Holec, david.holec@unileoben.ac.at
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{beamerDMS}[2019/05/09 v1.00  Beamer with a new DMS layout]%
% 
\RequirePackage{ifthen}%
%
% The template is primarily used for making presentations in two modes given as an option to the class:
% * beamer [default]: for presenting: 
%                       16:10 aspect ratio with sidebar ToC
%                       overlays
%                       results shown by default
% * trans:            for printing handouts: 
%                       4:3 aspect ratio without sidebar
%                       no overlays (1 slide per frame)
%                       results not shown by default
% DMSIsSidebar: true for beamer mode, false for trans mode
\newboolean{DMSIsSidebar}%
\setboolean{DMSIsSidebar}{true}%
% DMSShowResults: true if content of \showResults{} to be shown
\newboolean{DMSShowResults}%
\setboolean{DMSShowResults}{true}%
% DMSlecture: true if the presentation is a lecture (addding ToC as the begining of sections)
\newboolean{DMSLecture}%
\setboolean{DMSLecture}{false}%
% 
% class option beamer
\DeclareOption{beamer}{%
\setboolean{DMSIsSidebar}{true}%
  \ExecuteOptions{showResults}%
  \PassOptionsToClass{beamer, aspectratio=1610}{beamer}%
}%
% class option trans%
\DeclareOption{trans}{%
  \setboolean{DMSIsSidebar}{false}%
  \ExecuteOptions{hideResults}%
  \PassOptionsToClass{trans, aspectratio=43}{beamer}%
}%
% class option showResults%
\DeclareOption{showResults}{\setboolean{DMSShowResults}{true}}%
% class option hideResults%
\DeclareOption{hideResults}{\setboolean{DMSShowResults}{false}}%
% 
% class option slideSingleNumber: slides numbered as #(slide)
\DeclareOption{slideSingleNumber}{\def\frameNumber{\insertframenumber}}%
% class option slideTotalNumber: slides numbered as #(slide)/#(total)
\DeclareOption{slideTotalNumber}{\def\frameNumber{\insertframenumber/\inserttotalframenumber}}%
% 
% class option hideothersubsections: only section titles are shown for inactive sections in ToC
\DeclareOption{hideothersubsections}{\def\DMShideothersubsections{hideothersubsections}}
% class option showothersubsections: all subsections are shown in ToC
\DeclareOption{showothersubsections}{\def\DMShideothersubsections{}}
% pass all other options to beamer
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%
% default behavior
\ExecuteOptions{beamer, slideSingleNumber, showothersubsections}%
\ProcessOptions%
% other general options for the beamer class
\PassOptionsToClass{%
  10pt,% default font size
  t,%    slides aligned to top
}{beamer}%
\LoadClass{beamer}%
% 
% 
% other required packages
\RequirePackage{calc}%
\RequirePackage{marvosym}% for example signs
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
      height=1mm,%  height of the title bar
      width=3.5cm,% width of the side bar
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
\ifthenelse{\boolean{DMSIsSidebar}}{%
  \setbeamersize{text margin left=0.2cm}%
}{%
  \setbeamersize{text margin right=0.5cm}%
  \setbeamersize{text margin left=0.5cm}%
}%
%
\newlength{\DMSleftSkip}%
% correct for the width of the sidebar
\ifthenelse{\boolean{DMSIsSidebar}}{
  \setlength{\DMSleftSkip}{3.2cm}
}{
  \setlength{\DMSleftSkip}{0cm}
}
%
% shifting the frame title
\ifthenelse{\boolean{DMSIsSidebar}}{%
%   \setbeamertemplate{frametitle}[default][center]%   
    \setbeamertemplate{frametitle}{%
      \nointerlineskip%
      \unitlength=1cm%
      \begin{picture}(0,0)%
        \put(10,0.05){\parbox{23mm}{\mbox{}\hfill\includegraphics[height=6mm]{graphics/institute-logo}}}        
      \end{picture}%
      \begin{beamercolorbox}[leftskip=\DMSleftSkip,rightskip=2cm plus1fil,ht=2.5ex,dp=0.0ex]{frametitle}%
          \centering\insertframetitle%
      \end{beamercolorbox}%  
    }%
}{%
  \setbeamertemplate{frametitle}{%
      \nointerlineskip%
      \unitlength=1cm%
      \begin{picture}(0,0)%
        \put(10,0.05){\parbox{23mm}{\mbox{}\hfill\includegraphics[height=6mm]{graphics/institute-logo}}}
        \put(-0.3,0.05){\parbox{3cm}{\includegraphics[height=5mm]{graphics/logo_MUL_M}}}
      \end{picture}%
      \begin{beamercolorbox}[wd=\paperwidth,ht=2.5ex,dp=0.0ex]{frametitle}%
          \centering\insertframetitle%
      \end{beamercolorbox}%  
    }%
}%
% 
% 
% FRAME FOOTINGS
\newlength{\footerConferenceLeftMargin}
\defbeamertemplate*{footline}{sidebar theme}{
  \begin{beamercolorbox}[ht=1eX,dp=0.1cm,leftskip=\DMSleftSkip,rightskip=0cm plus1fil]{author in head/foot}%
    \unitlength=1cm%
    \setlength{\footerConferenceLeftMargin}{\widthof{\beamer@shortauthor: \beamer@shorttitle}}%
    \begin{picture}(0,0)%
      \ifnum\insertframenumber>1%
%         frame numbers
        \put(11.8,0){\parbox{7mm}{\mbox{}\hfill\frameNumber\mbox{}}}%
        \put(0.2,0){\mbox{\usebeamercolor[fg]{frametitle}\beamer@shortauthor: \beamer@shorttitle}}%
%         author & title
        \put(10.5,0){{\usebeamercolor[fg]{frametitle}\mbox{}\hfill\parbox{1.7cm}\insertdate}}%
%         date
        \put(0.2,0){\parbox{10.3cm}{\hspace*{\footerConferenceLeftMargin}\mbox{}\hfill\usebeamercolor[fg]{frametitle}\DMS@conference\hfill\mbox{}}}%
%         conference / lecture title centered
        \ifthenelse{\boolean{DMSIsSidebar}}{%
          \put(-3.1,0){\parbox{3cm}{\includegraphics[height=2eX]{graphics/logo_MUL_M}\ 
            \color{gray}\raisebox{0.2eX}{\scalebox{0.8}{MONTANUNIVERSITÄT LEOBEN}}}%
          }%
        }{}%
        % literature
        \put(0,0.2){\parbox[b]{12.5cm}{\raggedleft\color{black}\tiny\insertLiterature}}%
      \fi%
    \end{picture}%
  \end{beamercolorbox}%
}%
%
% 
% TITLE PAGE
% additional graphics and other elements to be included on the title page
\def\DMS@titleAdditions{}
\newcommand{\additionsToTitlePage}[1]{\def\DMS@titleAdditions{#1}}
\newcommand{\insertadditionsToTitlePage}{\DMS@titleAdditions}
\setbeamertemplate{title page}{%
  \unitlength=1cm%
  \ifthenelse{\boolean{DMSIsSidebar}}{%
    \hspace*{-1.5cm}%
  }{%
    \hspace*{-1mm}%
  }%
  \begin{picture}(12,9)%
%     \put(0,0){\rule{12cm}{90mm}}
    \put(5,6.9){\includegraphics[width=1.5cm]{graphics/logo_MUL}}
    \put(0,5.8){\parbox[t]{12cm}{%
      \centering%
      \usebeamerfont{title}{\usebeamercolor{title}\color{fg}\inserttitle}\par\bigskip%
      \usebeamerfont{author}{\color{DMSaddress}\insertauthor}\par\bigskip%
      \usebeamerfont{institute}{\color{DMSaddress}\insertinstitute\par\smallskip%
      \insertemail}%
    }}%
    \put(0,0.7){\parbox[t]{12cm}{%
      \centering%
      \color{DMSaddress}
      \usebeamerfont{institute}\insertdate%
    }}%
    \put(0,0.1){\parbox[t]{12cm}{%
      \centering%
      \color{DMSslogan}\usebeamerfont{author}%
      \ifthenelse{\boolean{DMSIsSidebar}}{\raisebox{-5mm}{\DMSsloganText}}{\DMSsloganText}%
    }}%
    \put(0,0){\insertadditionsToTitlePage}%
  \end{picture}%
}%
% 
% 
% COLORS
\usecolortheme[RGB={0, 115, 126}]{structure}%
\definecolor{MULgreen}{RGB}{0, 115, 126}%
\definecolor{DMSaddress}{RGB}{58, 57, 56}%
\definecolor{DMSslogan}{RGB}{166, 166, 166}%
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
% 
% 
% FONTS
\setbeamerfont{title}{size=\LARGE}
\setbeamerfont{author}{size=\normalsize}
\setbeamerfont{institute}{size=\footnotesize}
\ifthenelse{\boolean{DMSIsSidebar}}{
  \setbeamerfont{frametitle}{size=\LARGE}
}{
  \setbeamerfont{frametitle}{size=\Large}
}
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
\newcommand{\DMSsloganText}{WHERE RESEARCH MEETS FUTURE}%
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
