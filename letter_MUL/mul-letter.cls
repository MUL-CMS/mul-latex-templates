% Author: David Holec, david.holec@unileoben.ac.at
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul-letter}[2025/06/03 v2.00  MUL Letter LaTeX class]%
%
%
\RequirePackage{xifthen}%
%
% +-------------------------------------+
% | Class options and internal booleans |
% +-------------------------------------+
%
% whether to typeset the address condensed
\newboolean{MULcondensedAddress}%
\setboolean{MULcondensedAddress}{false}%
\DeclareOption{condensedAddress}{\setboolean{MULcondensedAddress}{true}}%
\DeclareOption{normalAddress}{\setboolean{MULcondensedAddress}{false}}%
% 
% whether and how to print page numbers
\newboolean{MULpageNumbers}%
\setboolean{MULpageNumbers}{true}%
\newboolean{MULpageNumbersMofN}%
\setboolean{MULpageNumbersMofN}{false}%
\DeclareOption{noPageNumbres}{\setboolean{MULpageNumbers}{false}}%
\DeclareOption{pageNumbres}{%
  \setboolean{MULpageNumbers}{true}%
  \setboolean{MULpageNumbersMofN}{false}%
}%
\DeclareOption{pageNumbresMofN}{%
  \setboolean{MULpageNumbers}{true}%
  \setboolean{MULpageNumbersMofN}{true}%
}%
%
% whether to print the header on every page or not
\newboolean{MULheaderEveryPage}%
\setboolean{MULheaderEveryPage}{true}%
\DeclareOption{headerEveryPage}{\setboolean{MULheaderEveryPage}{true}}%
\DeclareOption{headerOnlyFirstPage}{\setboolean{MULheaderEveryPage}{false}}%
%
% whether to print folding marks and which
\newboolean{MULfoldmarkHalf}%
\setboolean{MULfoldmarkHalf}{false}%
\newboolean{MULfoldmarkThird}%
\setboolean{MULfoldmarkThird}{false}%
\DeclareOption{foldmarkHalf}{\setboolean{MULfoldmarkHalf}{true}}%
\DeclareOption{foldmarkThird}{\setboolean{MULfoldmarkThird}{true}}%
%
%
% +---------------------------------------+
% | Load class and necessary dependencies |
% +---------------------------------------+
%
% pass all other options to the class and load it
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}%
% default behavior
\ExecuteOptions{normalAddress, pageNumbres, headerOnlyFirstPage}%
\ProcessOptions%
% other general options for the class
\PassOptionsToClass{%
  11pt,% default font size
}{article}%
\LoadClass{article}%
%
\RequirePackage{xcolor}%
\RequirePackage{geometry}%
\RequirePackage{lastpage}%
\RequirePackage{tikz}%
\RequirePackage{fancyhdr}%
\RequirePackage{adjustbox}%
%
%
% +---------------+
% | Custom colors |
% +---------------+
%
\definecolor{mul-green}{HTML}{006E6E}%
\definecolor{mul-header}{HTML}{000000}%
\definecolor{mul-text}{HTML}{3C3C3C}%
%
%
% +----------------------+
% | Define page geometry |
% +----------------------+
%
\ifthenelse{\boolean{MULheaderEveryPage}}%
{%
  \geometry{a4paper, top=12.5mm, headheight=35mm, headsep=15mm, bottom=12.5mm, footskip=13mm, left=25mm, right=25mm, includehead, includefoot}%
}%
{%
  \geometry{a4paper, top=12.5mm, headheight=0mm, headsep=15mm, bottom=12.5mm, footskip=13mm, left=25mm, right=25mm, includehead, includefoot}%
  \AtBeginDocument{%
    \vspace*{25mm}%
  }%
}%
\setlength{\parindent}{0pt}%
\setlength{\parskip}{1.5eX}%
%
% define skips after subject, receiver and date
\def\receiverSkip{-0.5em}%
\def\dateSkip{1em}%
\def\subjectSkip{1em}%
%
%
% +------------------------------------------+
% | Header components, headings and footings |
% +------------------------------------------+
%
\newcommand{\MULdepartment}{Department of Materials Science}%
\newcommand{\department}[1]{\renewcommand{\MULdepartment}{#1}}%
%
\newcommand{\MULmail}{}%
\newcommand{\mail}[1]{\renewcommand{\MULmail}{#1}}%
%
\newcommand{\MULweb}{https://unileoben.ac.at}%
\newcommand{\web}[1]{\renewcommand{\MULweb}{#1}}%
%
\newcommand{\MULhead}{}%
\newcommand{\head}[1]{\renewcommand{\MULhead}{#1}}%
%
\newcommand{\MULaddress}{Franz-Josef-Stra{\ss}e 18 \\ A-8700 Leoben \\ Austria}%
\newcommand{\address}[1]{\renewcommand{\MULaddress}{#1}}%
%
\newcommand{\checkIfText}[3]{%
  \sbox0{#1}%
  \ifdim\wd0=0pt%
    #3%
  \else%
    #2% if #1 is not empty
  \fi%
}%
\newcommand{\printNonEmpty}[1]{%
  \checkIfText{#1}%
  {#1 \newline}% if #1 is not empty
  {}% if #1 is empty
}%
\newcommand{\printLink}[1][]{%
  \ifthenelse{\isempty{#1}}%
  {}% if #1 is empty
  {\href{#1}{#1}}% if #1 is not empty
}%
\newcommand{\printMail}[1][]{%
  \ifthenelse{\isempty{#1}}%
  {}% if #1 is empty
  {\href{mailto:#1}{#1}}% if #1 is not empty
}%
%
\newcommand{\headleft}{%
  \adjincludegraphics[height=31mm,valign=M]{logo-mul.pdf}%
  \hspace*{5mm}%
  \begin{minipage}{0.4\textwidth}%
    \raggedright%
    \color{mul-header}{%
      \fontfamily{phv}\fontsize{10pt}{\baselineskip}%
      \ifthenelse{\boolean{MULcondensedAddress}}{\fontseries{bc}}{\fontseries{b}}%
      \selectfont%
      \checkIfText{\MULhead}%
        {%
          \MULhead \\%
          \ifthenelse{\boolean{MULcondensedAddress}}{\fontseries{mc}}{\fontseries{m}}\selectfont%
          \printNonEmpty{\MULdepartment}%
        }%
        {\checkIfText{\MULdepartment}%
          {\MULdepartment \\}%
          {}%
        }%
        \ifthenelse{\boolean{MULcondensedAddress}}{\fontseries{mc}}{\fontseries{m}}\selectfont%
        \MULaddress \\%
        \printMail{\MULmail \\}%
        \printLink{\MULweb}%
    }%
  \end{minipage}%
}%
\newcommand{\headright}{%
  \adjincludegraphics[width=33.5mm, valign=M]{logo-dms.pdf}%
}%
\newcommand{\footcenter}{%
\adjincludegraphics[height=9.3mm, valign=B]{logo-footer.pdf}%
}%
\newcommand{\footright}{%
  \ifthenelse{\boolean{MULpageNumbers}}%
  {%
    \ifthenelse{\boolean{MULpageNumbersMofN}}%
    {\thepage/\pageref{LastPage}}%
    {\thepage}%
  }%
  {}%
}%
\newcommand{\footleft}{%
  % folding markers
  \begin{tikzpicture}[overlay, remember picture, shift=(current page.south west)]%
  \ifthenelse{\boolean{MULfoldmarkHalf}}{%
    \draw (0.5, 0.5\paperheight) -- +(0.5,0);%
  }{}%
  \ifthenelse{\boolean{MULfoldmarkThird}}{%
    \draw (0.5, 0.333\paperheight) -- +(0.5,0);%
    \draw (0.5, 0.667\paperheight) -- +(0.5,0);%
  }{}%
  \end{tikzpicture}%
}%
%
% set header with logos and so on
\fancypagestyle{firstpage}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyhead[L]{\headleft}%
  \fancyhead[R]{\headright}%
  \fancyfoot[L]{\footleft}%
  \fancyfoot[C]{\footcenter}%
  \fancyfoot[R]{\footright}%
}%
\fancypagestyle{allpages}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \ifthenelse{\boolean{MULheaderEveryPage}}%
  {%
    \fancyhead[L]{\headleft}%
    \fancyhead[R]{\headright}%
  }%
  {}%
  \fancyfoot[L]{\footleft}%
  \fancyfoot[C]{\footcenter}%
  \fancyfoot[R]{\footright}%
}%
\pagestyle{allpages}%
\AtBeginDocument{%
  \thispagestyle{firstpage}%
}%
%
%
% +-------------------+
% | Letter components |
% +-------------------+
% receiver
\newcommand{\receiver}[1]{%
  \parbox{\textwidth}{%
    \color{mul-text}{#1}%
  }%
  \vspace*{\receiverSkip}\par%
}%
% date
\newcommand{\MULplaceInDate}{Leoben, }%
\newcommand{\placeInDate}[1]{\renewcommand{\MULplaceInDate}{\checkIfText{#1}{#1, }{}}}%
\newcommand{\MULdate}{\today}%
\renewcommand{\date}[1]{\renewcommand{\MULdate}{#1}}%
\newcommand{\showdate}{%
  \parbox{\textwidth}{%
    \raggedleft%
    \color{mul-text}{\MULplaceInDate \MULdate}%
  }%
  \vspace*{\dateSkip}\par%
}%
% subject
\newcommand{\subject}[1]{%
  \parbox{\textwidth}{%
    \fontshape{sc}\selectfont%
    \color{mul-green}{#1}%
  }%
  \vspace*{\subjectSkip}\par%
}%
%
%
% +-------------------------------+
% | Set document fonts and colors |
% +-------------------------------+
\color{mul-text}%
\renewcommand{\familydefault}{phv}%
\renewcommand\mddefault{m}%
\selectfont%
\flushbottom%
\renewcommand{\baselinestretch}{1.2}%
