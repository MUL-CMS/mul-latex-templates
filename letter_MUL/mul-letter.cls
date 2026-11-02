% Author: David Holec, david.holec@unileoben.ac.at
%
% Letter class with the layout of the official MUL letterhead (Word templates
% "Briefpapier allgemein" einseitig/mehrseitig, 2025 rebranding). Positions in mm
% from the top left corner of the A4 page are taken from these templates.
%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul-letter}[2026/11/02 v3.00 MUL Letter LaTeX class]%
%
\RequirePackage{etoolbox}%
%
%
% +-------------------------------------+
% | Class options and internal switches |
% +-------------------------------------+
%
% text font: Calibri (default; Carlito, metrically compatible with Calibri, as in
% the Word templates) or Helvetica
\newif\ifMUL@calibri%
\DeclareOption{helvetica}{\MUL@calibrifalse}%
\DeclareOption{calibri}{\MUL@calibritrue}%
%
% sender block in condensed Helvetica (no effect with calibri)
\newif\ifMUL@condensed%
\DeclareOption{condensedAddress}{\MUL@condensedtrue}%
\DeclareOption{normalAddress}{\MUL@condensedfalse}%
%
% page numbers from page 2 on (the first page carries the claim); style as in v2.0
% ("2/3" bottom right) or as in the Word templates ("▪ 2 von 3 ▪" centred)
\def\MUL@pagenumbers{mofn}%
\newif\ifMUL@templatenumbers%
\DeclareOption{pageNumbersClassic}{\MUL@templatenumbersfalse}%
\DeclareOption{pageNumbersTemplate}{\MUL@templatenumberstrue}%
\DeclareOption{noPageNumbers}{\def\MUL@pagenumbers{none}}%
\DeclareOption{pageNumbers}{\def\MUL@pagenumbers{single}}%
\DeclareOption{pageNumbersMofN}{\def\MUL@pagenumbers{mofn}}%
% option names of v2.0 (misspelled; kept for compatibility)
\DeclareOption{noPageNumbres}{\def\MUL@pagenumbers{none}}%
\DeclareOption{pageNumbres}{\def\MUL@pagenumbers{single}}%
\DeclareOption{pageNumbresMofN}{\def\MUL@pagenumbers{mofn}}%
%
% logo and sender block on the first page only (as the Word templates) or on every page
\newif\ifMUL@headereverypage%
\DeclareOption{headerOnlyFirstPage}{\MUL@headereverypagefalse}%
\DeclareOption{headerEveryPage}{\MUL@headereverypagetrue}%
%
% fold marks and punch mark at the left edge of every page
\newif\ifMUL@foldmarks%
\DeclareOption{foldMarks}{\MUL@foldmarkstrue}%
\DeclareOption{noFoldMarks}{\MUL@foldmarksfalse}%
% option names of v2.0 (kept for compatibility; both give the marks of the Word templates)
\DeclareOption{foldmarkHalf}{\MUL@foldmarkstrue}%
\DeclareOption{foldmarkThird}{\MUL@foldmarkstrue}%
%
% localization: language (babel), logo, claim, labels, date format, placeholders
\DeclareOption{DElocalization}{%
  \def\MUL@language{ngerman}%
  \def\MUL@logo{graphics/logo-mul}%
  \def\MUL@university{Montanuniversität Leoben}%
  \def\MUL@claim{graphics/claim-de}%
  \def\MUL@claimtext{Versetz’ Berge}%
  \def\MUL@placeInDate{Leoben, }%
  \def\MUL@date{\MUL@todayDE}%
  \def\MUL@contactlabel{Sachbearbeiter*in:}%
  \def\MUL@phonelabel{Tel.:}%
  \def\MUL@mobilelabel{Mobil:}%
  \def\MUL@oflabel{von}%
  \def\MUL@enclosureslabel{Beilagen}%
  \def\MUL@department{Organisationseinheit}%
  \def\MUL@sendername{Vorname Nachname}%
  \def\MUL@address{Franz-Josef-Straße 18, A-8700 Leoben}%
}%
\DeclareOption{ENlocalization}{%
  \def\MUL@language{english}%
  \def\MUL@logo{graphics/logo-mul-en}%
  \def\MUL@university{TU Leoben}%
  \def\MUL@claim{graphics/claim-en}%
  \def\MUL@claimtext{Move mountains}%
  \def\MUL@placeInDate{Leoben, }%
  \def\MUL@date{\MUL@todayEN}%
  \def\MUL@contactlabel{Contact:}%
  \def\MUL@phonelabel{Phone:}%
  \def\MUL@mobilelabel{Mobile:}%
  \def\MUL@oflabel{of}%
  \def\MUL@enclosureslabel{Enclosures}%
  \def\MUL@department{Organisational unit}%
  \def\MUL@sendername{First name Last name}%
  \def\MUL@address{Franz-Josef-Straße 18, 8700 Leoben, Austria}%
}%
% language of the logo and of the claim, independent of the localization: these
% options are declared after DE/ENlocalization, hence always processed after them
% (independent of the order in \documentclass) and overwrite their logo/claim;
% the university name in the sender block follows the language of the logo
\DeclareOption{DElogo}{%
  \def\MUL@logo{graphics/logo-mul}%
  \def\MUL@university{Montanuniversität Leoben}%
}%
\DeclareOption{ENlogo}{%
  \def\MUL@logo{graphics/logo-mul-en}%
  \def\MUL@university{TU Leoben}%
}%
\DeclareOption{DEclaim}{%
  \def\MUL@claim{graphics/claim-de}%
  \def\MUL@claimtext{Versetz’ Berge}%
}%
\DeclareOption{ENclaim}{%
  \def\MUL@claim{graphics/claim-en}%
  \def\MUL@claimtext{Move mountains}%
}%
% names of v2.0 style (kept as aliases)
\DeclareOption{DEslogan}{\ExecuteOptions{DEclaim}}%
\DeclareOption{ENslogan}{\ExecuteOptions{ENclaim}}%
%
%
% +---------------------------------------+
% | Load class and necessary dependencies |
% +---------------------------------------+
%
% pass all other options to the article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}%
% default behavior
\ExecuteOptions{calibri, normalAddress, pageNumbersMofN, pageNumbersClassic, headerOnlyFirstPage, foldMarks, ENlocalization}%
\ProcessOptions\relax%
% font size: 12pt Calibri as in the Word templates; 11pt Helvetica (comparable
% appearance, Helvetica runs larger than Calibri)
\ifMUL@calibri%
  \PassOptionsToClass{12pt}{article}%
\else%
  \PassOptionsToClass{11pt}{article}%
\fi%
\PassOptionsToClass{a4paper}{article}%
\LoadClass{article}%
%
\RequirePackage{iftex}%
\ifPDFTeX%
  \RequirePackage[T1]{fontenc}%
  % several included PDFs with transparency groups on one page (logos, claim): harmless
  \pdfsuppresswarningpagegroup=1\relax%
\fi%
\ifMUL@calibri%
  \RequirePackage[sfdefault, lining]{carlito}%
\else%
  \RequirePackage{helvet}%
  \renewcommand{\familydefault}{\sfdefault}%
\fi%
% math in the text font (Latin letters, digits, basic symbols; Greek letters and
% large operators stay Computer Modern); amsmath has to be loaded before mathastext
\RequirePackage{amsmath}%
\RequirePackage[italic]{mathastext}%
% German via ngerman.ldf (package babel-german) if installed, otherwise via babel's
% own locale data (\babelprovide), e.g. on a minimal Debian/Ubuntu TeX Live
\IfFileExists{ngerman.ldf}{%
  \edef\MUL@tmp{\noexpand\RequirePackage[english, ngerman, main=\MUL@language]{babel}}%
  \MUL@tmp%
}{%
  \RequirePackage[english]{babel}%
  \ifdefstring{\MUL@language}{ngerman}{%
    \babelprovide[import=de-1996, main]{ngerman}%
  }{%
    \babelprovide[import=de-1996]{ngerman}%
  }%
}%
\RequirePackage{xcolor}%
\RequirePackage{graphicx}%
\RequirePackage{geometry}%
\RequirePackage{fancyhdr}%
\RequirePackage{lastpage}%
\RequirePackage{tikz}%
%
%
% +---------------+
% | Custom colors |
% +---------------+
%
% MUL brand colours (Brandbook 2026, digital/RGB values; same names as in mul-beamer.cls
% and MUL_poster.cls)
\definecolor{digital_Turquoise}{RGB}{0,114,125}% #00727d
\definecolor{digital_GraphiteBlack}{RGB}{28,38,41}% #1c2629
\definecolor{digital_White}{RGB}{255,255,255}% #ffffff
\definecolor{digital_LightGreen}{RGB}{136,205,211}% #88cdd3
\definecolor{digital_TechGreen}{RGB}{0,255,255}% #00ffff, digital only
\definecolor{digital_BTLight}{RGB}{14,76,83}% #0e4c53
\definecolor{digital_BTDark}{RGB}{21,57,62}% #15393e
\definecolor{digital_TGLight}{RGB}{68,160,168}% #44a0a8
\definecolor{digital_TGDark}{RGB}{34,137,147}% #228993
\definecolor{digital_GWLight}{RGB}{225,242,244}% #e1f2f4
\definecolor{digital_GWDark}{RGB}{195,230,233}% #c3e6e9
% letter elements (Word templates)
\colorlet{MULsubject}{digital_Turquoise}% subject line
\colorlet{MULclaim}{digital_Turquoise!25}% claim and rule in the footer of the first page
\colorlet{MULpagenumber}{black}% page numbers
\colorlet{MULfoldmark}{black!50}% fold and punch marks
% names of v2.0 (kept for compatibility)
\colorlet{mul-green}{digital_Turquoise}%
\colorlet{mul-header}{black}%
\colorlet{mul-text}{black}%
%
%
% +----------------------+
% | Define page geometry |
% +----------------------+
%
% text area: 25 mm margins (Word templates); 25 mm at the bottom keep the text clear of
% the claim on the first page. With headerEveryPage, the text starts below the header.
\newlength{\MULtopmargin}%
\ifMUL@headereverypage%
  \setlength{\MULtopmargin}{55mm}%
\else%
  \setlength{\MULtopmargin}{25mm}%
\fi%
\geometry{a4paper, top=\MULtopmargin, bottom=25mm, left=25mm, right=25mm, headheight=16pt, headsep=5mm, footskip=12mm}%
% first page: the text (subject) starts below the address and date fields
\newlength{\MULbodystart}%
\setlength{\MULbodystart}{107mm}%
% size of the logos and the claim
\newlength{\MULlogoheight}%
\setlength{\MULlogoheight}{30.7mm}%
\newlength{\MULclaimheight}%
\setlength{\MULclaimheight}{5.64mm}%
% fold marks (DIN 5008, form B) and punch mark
\newcommand{\MULfoldmarkA}{105mm}%
\newcommand{\MULpunchmark}{148.5mm}%
\newcommand{\MULfoldmarkB}{210mm}%
%
\setlength{\parindent}{0pt}%
\linespread{1.15}%
\raggedbottom%
% top of the date field (below the address field, which ends at 83.5 mm)
\newlength{\MULdatetop}%
\setlength{\MULdatetop}{86mm}%
% space below the subject (the empty line between paragraphs comes in addition)
\newcommand{\subjectSkip}{0.5\baselineskip}%
% v2.0 settings, no longer used (kept for compatibility)
\newcommand{\receiverSkip}{0pt}%
\newcommand{\dateSkip}{0pt}%
%
%
% +--------------------------------------+
% | Sender, recipient, date (user level) |
% +--------------------------------------+
%
% sender block next to the logo (placeholders set by the localization)
\newcommand{\department}[1]{\def\MUL@department{#1}}%
\newcommand{\sendername}[1]{\def\MUL@sendername{#1}}%
\newcommand{\head}[1]{\def\MUL@sendername{#1}}% v2.0 name
% university name, below the unit (set by the language of the logo)
\newcommand{\university}[1]{\def\MUL@university{#1}}%
\newcommand{\address}[1]{\def\MUL@address{#1}}%
\def\MUL@phone{}%
\newcommand{\phone}[1]{\def\MUL@phone{#1}}%
\def\MUL@mobile{}%
\newcommand{\mobile}[1]{\def\MUL@mobile{#1}}%
\def\MUL@mail{}%
\newcommand{\mail}[1]{\def\MUL@mail{#1}}%
% \web[<url>]{<text>}: <url> defaults to <text>, with https:// added if missing
\def\MUL@web{www.unileoben.ac.at}%
\def\MUL@webURL{https://www.unileoben.ac.at}%
\newcommand{\web}[2][]{%
  \def\MUL@web{#2}%
  \ifblank{#1}%
    {\in@{://}{#2}\ifin@\def\MUL@webURL{#2}\else\def\MUL@webURL{https://#2}\fi}%
    {\def\MUL@webURL{#1}}%
}%
% logo of the organisational unit (top right; none by default)
\def\MUL@unitlogo{}%
\newcommand{\unitlogo}[1]{\def\MUL@unitlogo{#1}}%
% replace the MUL logo or the claim (\setSlogan{} removes the claim)
\newcommand{\setLogo}[1]{\def\MUL@logo{#1}}%
\newcommand{\setSlogan}[1]{\def\MUL@claim{}\def\MUL@claimtext{#1}}%
%
% recipient: \receiver[<note>]{<address>}; <note> (e.g. a dispatch note) is printed in
% the first of the two lines above the address
\def\MUL@receiver{}%
\def\MUL@receivernote{}%
\newcommand{\receiver}[2][]{\def\MUL@receivernote{#1}\def\MUL@receiver{#2}}%
%
% date and contact person (below each other, right aligned)
\newcommand{\MUL@todayDE}{\two@digits{\day}.\two@digits{\month}.\number\year}%
\newcommand{\MUL@todayEN}{\number\day\nobreakspace\ifcase\month\or January\or February\or March\or April\or May\or June\or July\or August\or September\or October\or November\or December\fi\nobreakspace\number\year}%
\renewcommand{\date}[1]{\def\MUL@date{#1}}%
\newcommand{\placeInDate}[1]{\ifblank{#1}{\def\MUL@placeInDate{}}{\def\MUL@placeInDate{#1, }}}%
\def\MUL@contact{}%
\newcommand{\contact}[1]{\def\MUL@contact{#1}}%
\newcommand{\showdate}{}% v2.0: the date is now always printed in its field
%
% name below the closing (default: the sender's name)
\def\MUL@signature{\MUL@sendername}%
\newcommand{\signature}[1]{\def\MUL@signature{#1}}%
%
%
% +-------------------------+
% | Letter body (user level) |
% +-------------------------+
%
% subject in small caps; Carlito and Helvetica have no small caps in pdfLaTeX, so they
% are simulated: capitals at full size, lowercase letters as capitals at 80 %.
% \subjectFont can be redefined, e.g. as \textsc for a font with real small caps.
\ExplSyntaxOn
\cs_new_protected:Npn \MUL@fakesmallcaps #1
  {
    \text_map_inline:nn {#1}
      {
        \str_if_eq:eeTF {##1} { \text_uppercase:n {##1} }
          {##1}
          {
            {
              \fontsize { \fp_eval:n { 0.8 * \f@size } pt } { \f@baselineskip }
              \selectfont \text_uppercase:n {##1}
            }
          }
      }
  }
\ExplSyntaxOff
\newcommand{\subjectFont}{\MUL@fakesmallcaps}%
\newcommand{\subject}[1]{%
  \par{\color{MULsubject}\subjectFont{#1}\par}%
  \vspace{\subjectSkip}%
}%
% closing: \closing[<signature, e.g. \includegraphics>]{<closing text>}
\newcommand{\closing}[2][]{%
  \par#2\par\nopagebreak%
  \ifblank{#1}{\vspace{2\baselineskip}}{\nopagebreak#1\par}%
  \nopagebreak%
  \ifdefempty{\MUL@signature}{}{\MUL@signature\par}%
}%
% enclosures: \enclosures{<list, separated by \\>}
\newcommand{\enclosures}[1]{%
  \par{\bfseries\MUL@enclosureslabel}\par\nopagebreak%
  {\setlength{\parskip}{0pt}#1\par}%
}%
%
%
% +--------------------------------------------+
% | Page elements (absolute positions on A4)   |
% +--------------------------------------------+
%
% fonts of the sender block: 10pt Helvetica / 11pt Calibri
\newcommand{\MUL@headerfont}{%
  \normalfont%
  \ifMUL@calibri%
    \fontsize{11pt}{13.4pt}\selectfont%
  \else%
    \fontsize{10pt}{12.5pt}%
    \ifMUL@condensed\fontseries{mc}\fi%
    \selectfont%
  \fi%
}%
\newcommand{\MUL@bold}{%
  \ifMUL@calibri\bfseries\else\ifMUL@condensed\fontseries{bc}\selectfont\else\bfseries\fi\fi%
}%
%
% sender block: name, unit (bold), university, address, phone, mobile, e-mail, web;
% empty lines omitted
\newif\ifMUL@firstline%
\newcommand{\MUL@addline}[1]{\ifMUL@firstline\global\MUL@firstlinefalse\else\\\fi#1}%
\newcommand{\MUL@senderblock}{%
  \global\MUL@firstlinetrue%
  \ifdefempty{\MUL@sendername}{}{\MUL@addline{\MUL@sendername}}%
  \ifdefempty{\MUL@department}{}{\MUL@addline{{\MUL@bold\MUL@department}}}%
  \ifdefempty{\MUL@university}{}{\MUL@addline{\MUL@university}}%
  \ifdefempty{\MUL@address}{}{\MUL@addline{\MUL@address}}%
  \ifdefempty{\MUL@phone}{}{\MUL@addline{\MUL@phonelabel\ \MUL@phone}}%
  \ifdefempty{\MUL@mobile}{}{\MUL@addline{\MUL@mobilelabel\ \MUL@mobile}}%
  \ifdefempty{\MUL@mail}{}{\MUL@addline{\href{mailto:\MUL@mail}{\MUL@mail}}}%
  \ifdefempty{\MUL@web}{}{\MUL@addline{\href{\MUL@webURL}{\MUL@web}}}%
}%
%
% address field: two lines (note, empty) above the address
\newcommand{\MUL@receiverblock}{%
  \strut\MUL@receivernote\\\strut\\\MUL@receiver%
}%
% date field: place and date, contact person
\newcommand{\MUL@dateblock}{%
  \ifdefempty{\MUL@date}%
    {\ifdefempty{\MUL@contact}{}{\MUL@contactlabel\ \MUL@contact}}%
    {\MUL@placeInDate\MUL@date\ifdefempty{\MUL@contact}{}{\\\MUL@contactlabel\ \MUL@contact}}%
}%
%
% claim: graphic in Funnel Display (graphics/claim-de.pdf, claim-en.pdf); if missing
% (or set by \setSlogan), typeset in the text font
\newcommand{\MUL@claimbox}{%
  \IfFileExists{\MUL@claim.pdf}%
    {\includegraphics[height=\MULclaimheight]{\MUL@claim}}%
    {{\fontsize{14pt}{14pt}\selectfont\bfseries\color{MULclaim}\MUL@claimtext}}%
}%
%
% the following commands are used inside the tikzpicture of \MUL@overlay;
% MUL@nw is the top left corner of the page
\newcommand{\MUL@drawfoldmarks}{%
  \foreach \MUL@y in {\MULfoldmarkA, \MULpunchmark, \MULfoldmarkB}{%
    \draw[MULfoldmark, line width=0.25pt] ([shift={(5mm,-\MUL@y)}]MUL@nw) -- ++(5mm,0);%
  }%
}%
\newcommand{\MUL@drawheader}{%
  % MUL logo
  \node[anchor=north west, inner sep=0pt] at ([shift={(25mm,-14mm)}]MUL@nw) {\includegraphics[height=\MULlogoheight]{\MUL@logo}};%
  % sender block
  \node[anchor=north west, inner sep=0pt, text width=73mm, align=left, text=black, font=\MUL@headerfont] at ([shift={(66.6mm,-14mm)}]MUL@nw) {\MUL@senderblock};%
  % logo of the organisational unit (optional)
  \ifdefempty{\MUL@unitlogo}{}{%
    \node[anchor=north east, inner sep=0pt] at ([shift={(185mm,-18mm)}]MUL@nw) {\includegraphics[width=42.6mm, height=16.1mm, keepaspectratio]{\MUL@unitlogo}};%
  }%
}%
\newcommand{\MUL@drawfields}{%
  % address field (85 x 40 mm, window envelope position)
  \node[anchor=north west, inner sep=0pt, text width=85mm, align=left, text=black, font=\normalfont\normalsize] at ([shift={(25mm,-43.5mm)}]MUL@nw) {\MUL@receiverblock};%
  % date and contact person
  % (a one-column tabular instead of a paragraph: no underfull line warnings)
  \node[anchor=north east, inner sep=0pt, text=black, font=\normalfont\normalsize] at ([shift={(184mm,-\MULdatetop)}]MUL@nw) {\begin{tabular}[t]{@{}r@{}}\MUL@dateblock\end{tabular}};%
}%
\newcommand{\MUL@drawclaim}{%
  \draw[MULclaim, line width=0.5pt] ([shift={(30mm,-276.5mm)}]MUL@nw) -- ++(150mm,0);%
  \ifdefempty{\MUL@claimtext}{}{%
    \node[anchor=north, inner sep=0pt] at ([shift={(105mm,-279.8mm)}]MUL@nw) {\MUL@claimbox};%
  }%
}%
% page number, style of v2.0 ("2/3", right-aligned at the right margin) or of the
% Word templates ("▪ 2 von 3 ▪", 8pt, centred)
\newcommand{\MUL@square}{\raisebox{0.2ex}{\rule{0.6ex}{0.6ex}}}%
\newcommand{\MUL@drawpagenumber}{%
  \ifdefstring{\MUL@pagenumbers}{none}{}{%
    \ifMUL@templatenumbers%
      \node[anchor=base, inner sep=0pt, text=MULpagenumber, font=\normalfont\fontsize{8pt}{10pt}\selectfont] at ([shift={(105mm,-283.5mm)}]MUL@nw) {%
        \MUL@square\enspace\textbf{\thepage}%
        \ifdefstring{\MUL@pagenumbers}{mofn}{\ \MUL@oflabel\ \textbf{\pageref*{LastPage}}}{}%
        \enspace\MUL@square%
      };%
    \else%
      \node[anchor=base east, inner sep=0pt, text=MULpagenumber, font=\normalfont\normalsize] at ([shift={(185mm,-284.5mm)}]MUL@nw) {%
        \thepage\ifdefstring{\MUL@pagenumbers}{mofn}{/\pageref*{LastPage}}{}%
      };%
    \fi%
  }%
}%
%
% all page elements, drawn from the page header
\newcommand{\MUL@overlay}{%
  \begin{tikzpicture}[remember picture, overlay]%
    \coordinate (MUL@nw) at (current page.north west);%
    \ifMUL@foldmarks\MUL@drawfoldmarks\fi%
    \ifnum\value{page}=1\relax%
      \MUL@drawheader%
      \MUL@drawfields%
      \MUL@drawclaim%
    \else%
      \ifMUL@headereverypage\MUL@drawheader\fi%
      \MUL@drawpagenumber%
    \fi%
  \end{tikzpicture}%
}%
\fancypagestyle{MULletter}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyhead[C]{\MUL@overlay}%
}%
\pagestyle{MULletter}%
%
%
% +--------------------------------+
% | Text spacing and hyperlinks    |
% +--------------------------------+
%
\AtBeginDocument{%
  \normalsize%
  % an empty line between paragraphs
  \setlength{\parskip}{\baselineskip}%
  % first page: start the text below the address and date fields
  \vspace*{\dimexpr\MULbodystart-\MULtopmargin-\topskip-\parskip\relax}%
}%
\RequirePackage[hidelinks]{hyperref}%
