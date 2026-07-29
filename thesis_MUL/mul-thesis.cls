% Thesis class for LaTeX
% Montanuniversität Leoben, Austria
% David Holec, 2011-2012
% david.holec@unileoben.ac.at
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul-thesis}[2012/04/12 v1.1 MUL thesis class]%
%
% options
% use pdfpages - for inclusion of papers in pdfpages
% this option works only together with pdfLaTeX
\def\@multhesis@pdfpages{}%
\def\@multhesis@twopages{}%
\def\@multhesis@colorlinks{}%
\def\@multhesis@lineno{0}%
\def\@multhesis@blob{0}
\DeclareOption{pdfpages}{\def\@multhesis@pdfpages{1}%
  \PassOptionsToPackage{pdftex}{pdfpages}%
  \PassOptionsToPackage{pdftex}{hyperref}%
  \PassOptionsToPackage{pdftex}{geometry}%
}%
% single page or both-sided page layout
\DeclareOption{oneside}{%
  \def\@multhesis@twopages{0}%
  \PassOptionsToClass{oneside}{memoir}%
  \PassOptionsToPackage{left}{lineno}%
}%
\DeclareOption{twoside}{%
\def\@multhesis@twopages{1}%
\PassOptionsToClass{twoside}{memoir}%
\PassOptionsToPackage{switch}{lineno}%
}%
% add ``blobs'' for publications
\DeclareOption{blob}{%
\def\@multhesis@blob{1}%
}%
% color or B&W links in the final pdfLaTeX
\DeclareOption{colorlinks}{\def\@multhesis@colorlinks{1}}%
\DeclareOption{BWlinks}{\def\@multhesis@colorlinks{0}}%
% line numbers
\DeclareOption{lineno}{\def\@multhesis@lineno{1}}%
%
\ExecuteOptions{oneside,colorlinks}%
\ProcessOptions\relax%
%
%
% loading parent class
% the class is based on the standard memoir class
\LoadClass[12pt,a4paper]{memoir}%
%
% loading pdfpages (if required)
\if\@multhesis@pdfpages1%
  \typeout{[mul-thesis] Loading pdfpages package.}%
  \PassOptionsToPackage{final,pdftex}{pdfpages,graphicx}%
  \RequirePackage{pdfpages}[2010/01/12]%
\fi%
%
% page geometry
\RequirePackage[top=3cm,bottom=3cm,outer=2cm,inner=2.5cm,a4paper]{geometry}%
%
% headings & footings
\RequirePackage{fancyhdr}%
\pagestyle{fancy}%
\fancyhead{}%
\fancyfoot{}%
\renewcommand{\headrulewidth}{0.4pt}%
\renewcommand{\sectionmark}[1]{\markboth{\thesection\ #1}{\thesection\ #1}}%
\if\@multhesis@twopages0%
  \typeout{[mul-thesis] Using single page layout.}%
  \fancyhead[R]{\rightmark}%
  \fancyfoot[R]{\thepage}%
\else%
  \typeout{[mul-thesis] Using both-sided page layout.}%
  \fancyhead[RO,LE]{\rightmark}%
  \fancyfoot[RO,LE]{\thepage}%
\fi%
% 
% hyperref class
\if\@multhesis@colorlinks0%
  \typeout{[mul-thesis] Using B&W links.}%
  \RequirePackage[colorlinks=true,linkcolor=black,citecolor=black,filecolor=black,urlcolor=black]{hyperref}%
\else%
  \RequirePackage[colorlinks=true]{hyperref}%
\fi%
% 
% adding line numbers (if needed)
\if\@multhesis@lineno1%
  \typeout{[mul-thesis] Adding line numbers.}%
  \RequirePackage[pagewise]{lineno}%
  \linenumbers%
\fi%
%
% standard graphicx package
\RequirePackage{graphicx}%
%
% standard ifthen package
\RequirePackage{ifthen}%
%
% 
% % % % % % % %
% definitions %
% % % % % % % %

% setting-up chapter style (based on the madsen style
\makechapterstyle{mul-madsen}{%
  \chapterstyle{default}%
  \renewcommand*{\chapnamefont}{%
    \normalfont\Large\scshape\raggedleft}
  \renewcommand*{\chaptitlefont}{%
    \normalfont\Huge\bfseries\sffamily\raggedleft}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*{\printchapternum}{%
      \hspace{0.4em}%
      \resizebox{!}{4ex}{%
        \chapnamefont\bfseries\sffamily\thechapter}%
    }%
  \renewcommand*{\printchapternonum}{%
    \afterchapternum %
  }%
  \renewcommand*{\afterchapternum}{%
    \par\hspace{1.5cm}\hrule\vskip\midchapskip}}
\chapterstyle{mul-madsen}%
% 
% redefinition of sections and subsection
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\sffamily\Large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\sffamily\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\sffamily\normalsize\bfseries}}%
\setsecnumdepth{subsection}
\settocdepth{subsection}
\newcommand{\newChapter}[2][]{
  \ifthenelse{\equal{#1}{*}}{
    \chapter*{#2}
    \addcontentsline{toc}{chapter}{#2}%
    \markright{#2}
  }{
    \chapter{#2}
    \markright{\thechapter. #2}
  }
}

% formatting
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.5\baselineskip}
\linespread{1.2}

% table of contents
\renewcommand\tableofcontents{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\contentsname}
  \addcontentsline{toc}{chapter}{\contentsname}
  \markright{\contentsname}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
  \cleardoublepage%
}
% 
% 
% definitions for sidebars used for publication
\newcounter{cntPublication}
\newcommand{\newPublicationLogo}[2]{
  \stepcounter{cntPublication}
  \lhead{}
  \chapter*{Publication \Roman{cntPublication}}
  \addcontentsline{toc}{chapter}{Publication \Roman{cntPublication}}
  \rhead{\blob}
  \markright{Publication \Roman{cntPublication}}
  \thispagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}
  \vfill
  {\raggedleft
  \includegraphics[height=2cm]{#1}\par
  #2
  \par
  \phantom{ahoj}
  }
  \vspace*{3cm}
  \clearpage
  \fancyhead{}
  \fancyhead[RO]{\rightmark\blob}
  \fancyhead[LE]{\rightmark\lblob}
  \renewcommand{\headrulewidth}{0.4pt}
}
\newcommand{\newPublication}[1]{
  \stepcounter{cntPublication}
  \lhead{}
  \chapter*{Publication \Roman{cntPublication}}
  \addcontentsline{toc}{chapter}{Publication \Roman{cntPublication}}
  \rhead{\blob}
  \markright{Publication \Roman{cntPublication}}
  \thispagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}
  \vfill
  {\raggedleft
  #1
  \par
  \phantom{ahoj}
  }
  \vspace*{3cm}
  \clearpage
  \fancyhead{}
  \fancyhead[RO]{\rightmark\blob}
  \fancyhead[LE]{\rightmark\lblob}
  \renewcommand{\headrulewidth}{0.4pt}
}
% blobs
\newcommand\blob{}%
\newcommand\lblob{}%
\if\@multhesis@blob1{
  \renewcommand\blob{
  \setlength{\unitlength}{30mm}
  \begin{picture}(0,0)
    \put(0.3,-\value{cntPublication}){\rule{2\unitlength}{1.2\unitlength}}
    \put(0.3,-\value{cntPublication}){\hspace*{3mm}\rotatebox{90}{\parbox{1.2\unitlength}	{\mbox{}\hfill\color{white}\sffamily\bfseries\rightmark\hfill\mbox{}}}}
  \end{picture}
  }
  \renewcommand\lblob{
  \setlength{\unitlength}{30mm}
  \begin{picture}(0,0)
    \put(-3.25,-\value{cntPublication}){\rule{2\unitlength}{1.2\unitlength}}
    \put(-1.57,-\value{cntPublication}){\hspace*{3mm}\rotatebox{90}{\parbox{1.2\unitlength}{\mbox{}\hfill\color{white}\sffamily\bfseries\rightmark\hfill\mbox{}}}}
  \end{picture}
}
\fi
\endinput