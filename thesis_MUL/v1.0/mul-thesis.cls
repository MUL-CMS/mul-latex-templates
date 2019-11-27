% Thesis class for LaTeX
% Montanuniversität Leoben, Austria
% David Holec, 2011-2012
% david.holec@unileoben.ac.at
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul-thesis}[2012/04/02 v1.0 MUL thesis class]%
%
% options
% use pdfpages - for inclusion of papers in pdfpages
% this option works only together with pdfLaTeX
\def\@multhesis@pdfpages{}%
\def\@multhesis@twopages{}%
\def\@multhesis@colorlinks{}%
\def\@multhesis@lineno{0}%
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
  \RequirePackage{pdfpages,final}[2010/01/12]%
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
\newcommand{\newChapter}[1]{
  \chapter{#1}
  \markright{\thechapter. Introduction}
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