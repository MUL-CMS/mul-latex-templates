\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{mul_poster}[2018/07/02 MontanUni Poster Class by David Holec]%
%
% based on the a0poster package
% currently working with dvi->ps->pdf so that pstricks can be used
\LoadClass[a0, portrait]{a0poster}
%
% fonts
\RequirePackage{arev}
%
% graphics, color
\RequirePackage{graphicx}%
\RequirePackage[x11names]{xcolor}%
\RequirePackage{pst-text, pst-grad}% for fancy title etc.
%
% positioning of boxes
\usepackage[overlay,absolute,showboxes]{textpos}
%% set up the TexPos grid
\TPGrid[15mm,125mm]{41}{60}%
\setlength{\TPVertModule}{\TPHorizModule}%
\TPMargin{5mm}%
\TPboxrulesize=0pt%
%
% use calc expressions for length
\RequirePackage{calc}%
%
% -------------- end of packages and option declarations ------------------
%
%
% from marvosym.sty -- email symbol
\newcommand\dhEmail{{\fontfamily{mvs}\fontencoding{U}\fontseries{m}\fontshape{n}\selectfont\char66{}}}%
%
% definition of highlighted coulours
\definecolor{IMWgreen}{RGB}{34,144,141}%
\newcommand{\alert}[1]{{\color{Red3}#1}}%
\newcommand{\Alert}[1]{{\color{IMWgreen}#1}}%
%
% posterBox
\newsavebox{\dhBox}%
\newlength{\dhBoxHeight}%
\newlength{\dhBoxShading}%
% \posterBox{width}(pos_x, pos_y){title}{contents}  -- with section number
% \posterBox*{width}(pos_x, pos_y){title}{contents} -- no section number
\def\posterBox{\@ifstar\@posterBox\@@posterBox}%
\def\@posterBox#1(#2,#3)#4#5{\@@@posterBox{#1}(#2,#3){\protect\section*{#4}}{#5}}%
\def\@@posterBox#1(#2,#3)#4#5{\@@@posterBox{#1}(#2,#3){\protect\section{#4}}{#5}}%
\def\@@@posterBox#1(#2,#3)#4#5{%
  \begin{textblock}{#1}(#2,#3)%
    \unitlength=\TPHorizModule%
    \savebox{\dhBox}{\parbox{#1\TPHorizModule-1.7\TPHorizModule}{#5}}%
    \setlength{\dhBoxHeight}{\totalheightof{\usebox{\dhBox}}}%
    \setlength{\dhBoxShading}{\dhBoxHeight}%
    \addtolength{\dhBoxShading}{0.20\TPHorizModule}%
    \begin{pspicture}(0,\dhBoxHeight)
      \psframe[linestyle=none, fillstyle=gradient, gradbegin=IMWgreen, gradend=white, gradmidpoint=1, gradangle=90]%
      (-0.21\TPHorizModule,-0.21\TPHorizModule)(1.2\TPHorizModule,\dhBoxShading)%
      \psframe[linewidth=3pt](-0.21\TPHorizModule,-0.21\TPHorizModule)(#1\TPHorizModule,\dhBoxShading)%
      \rput[bl](0.1,0){\rotatebox{90}{\parbox{\dhBoxHeight}{\centering{#4}}}}%
      \rput[bl](2.5,-0.15){\usebox{\dhBox}}%
    \end{pspicture}%
  \end{textblock}%
}%
