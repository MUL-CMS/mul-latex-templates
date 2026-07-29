
% Letter for mul Tempate

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mul-letter}[2014/08/16 Example LaTeX class]
 
\newcommand{\headlinecolor}{\normalcolor}

\LoadClass[11pt]{article}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{helvet}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{adjustbox}
\RequirePackage{hyperref}
\RequirePackage{anyfontsize}
\RequirePackage{calc}
\RequirePackage{transparent}
\definecolor{slcolor}{HTML}{882B21}
\definecolor{mul-turquoise}{HTML}{006E6E}
\definecolor{mul-smoke}{HTML}{3C3C3C}

% Set font type to Arial
\usepackage{helvet}
\usepackage{graphicx}
\usepackage{adjustbox}
\usepackage{hyperref}
\usepackage{anyfontsize}
\usepackage{calc}
\usepackage{transparent}
\usepackage{xifthen}

\renewcommand{\familydefault}{\sfdefault}
% Set up geometry as defined in the QM documents
% See https://qm.unileoben.ac.at/fileadmin/shares/unileoben/qm/private/Q4.1_100.pdf
\geometry{a4paper, width=210mm, height=297mm, top=12mm, headheight=35mm, headsep=15mm, bottom=16mm, left=25mm, right=25mm, includehead, includefoot}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5eX}

% Define macro that prints only something if the value is not empty

\newcommand{\checkempty}[1][]{%
  \ifthenelse{\isempty{#1}}%
    {}% if #1 is empty
    {#1 \\}% if #1 is not empty
}

\newcommand{\checkemptylink}[1][]{%
  \ifthenelse{\isempty{#1}}%
    {}% if #1 is empty
    {
           \href{{#1}}{{#1}} \\
    }% if #1 is not empty
}

\newcommand{\checkemptymail}[1][]{%
  \ifthenelse{\isempty{#1}}%
    {}% if #1 is empty
    {
           \href{mailto:#1}{#1} \\
    }% if #1 is not empty
}

% Define Skips after subject, reciever and date
\def\recieverSkip{2em}	% default value is
\def\subjectSkip{0em}
\def\dateSkip{1em}


%Define user variables

\def\@department{{Department of Materials Science}\\}	% default value is 
\def\department#1{\gdef\@department{#1}}

\def\@mail{}
\def\mail#1{\gdef \@mail{#1}}

\def\@web{https://unileoben.ac.at}
\def\web#1{\gdef \@web{#1}}

\def\@head{}
\def\head#1{\gdef \@head{#1}}

\def\@address{{Franz-Josef-Stra{\ss}e 18 \\ A-8700 Leoben \\ Austria \\}}
\def\address#1{\gdef \@address{#1}}

% Set header with logos and so on
\usepackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0mm}
\lhead{
    \adjincludegraphics[height=27mm,valign=M]{mul-logo} 
    \hspace{5pt}{\color{mul-turquoise}\vrule}\hspace{1pt} 
    \begin{minipage}{0.4\textwidth}
        \raggedright{
            \color{mul-smoke}{
                {
                \fontsize{11pt}{\baselineskip} \selectfont
                \fontfamily{phv}\fontseries{bc}\selectfont \checkempty{\@head}
                \fontfamily{phv}\fontseries{mc}\selectfont \checkempty{\@department}
                \checkempty{\@address}
                \checkemptymail{{\@mail}}
                \checkemptylink{{\@web}}
                }
            }
        }
    \end{minipage}
}
    
    
\rhead{
       \adjincludegraphics[width=30mm, valign=M]{institute-logo}%
}

% Make the footer
\cfoot{
  \fontsize{20pt}{\baselineskip} \fontfamily{phv}\fontseries{mc} \selectfont
%   \makebox[\widthof{WO AUS FORSCHUNG ZUKUNFT WIRD}][c]{ \color{mul-turquoise} {\transparent{0.3}  WO AUS FORSCHUNG ZUKUNFT WIRD} }
  \makebox[\widthof{WHERE RESEARCH MEETS THE FUTURE}][c]{ \color{mul-turquoise} {\transparent{0.3}  WHERE RESEARCH MEETS THE FUTURE} }
}


% Make the reciever
\newcommand{\reciever}[1]{
% \vspace*{\recieverSkip}  
{\raggedright
\parbox{\textwidth}
{
    \strut
    \color{mul-smoke}{
            \fontsize{11pt}{\baselineskip} \selectfont \\ #1  \\
    }
    \strut
}}
}





\newcommand{\showdate}{ \vspace*{\dateSkip} {\raggedright \parbox{\textwidth}{\strut \raggedleft \today \strut}} \vspace*{\dateSkip} }

\newcommand{\subject}[1]{{\vspace*{\subjectSkip} {\raggedright \parbox{\textwidth}{ \fontsize{11pt}{\baselineskip}\fontfamily{phv}\fontseries{m} \fontshape{sc} \selectfont \color{mul-turquoise} #1 }} }   \vspace*{\subjectSkip}}

%Set fonts and colors
\color{mul-smoke}
\renewcommand{\familydefault}{phv}
\renewcommand\mddefault{m}
\selectfont
