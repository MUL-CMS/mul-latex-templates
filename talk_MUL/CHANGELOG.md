*   v3.10-2026 (current)
    XeLaTeX/LuaTeX using `tikz`, structure with `figs`, `graphics`, and
    `fonts` (University 2025 rebranding, aligned with the Brandbook 2026
    and the official PowerPoint master)
    - brand colours of the style guide (`digital_*`, same names as in
      MUL_poster.cls; MULgreen, MULturquoise, MULaddress kept as aliases);
      blocks in the combination colours, ToC without red, claim in the
      footer in white, English claim "Move mountains"
    - new options: brandFont (Host Grotesk, bundled in fonts/) and
      classicFont (Latin Modern Sans, default); operator names (\sin, ...)
      in the text font
    - new options: lightTitle (default) / darkTitle (dark title slide);
      DElogo/ENlogo and DEslogan/ENslogan (mix languages, e.g.
      ENlocalization with DElogo, DEslogan)
    - new slides from the PowerPoint master: \agendaframe (Inhalt/Outline),
      \personframe (Zur Person), \finalframe (closing slide with title,
      authors, e-mail, website, QR code)
    - new settings: \setTitleLogo, \setSlogan, \setThanksText,
      \setAgendaTitle, \setDarkBackground, \website, \setQRcode
    - dark backgrounds (CMS variant and PowerPoint master), white logos,
      demo QR code
    - \aff omitted in PDF strings (no hyperref warnings)
    - templates: talk.tex without sidebar, ENlocalization with German logo
      and claim, closing and backup slides; lecture.tex with darkTitle
    - demo: overview of all options and commands (with footer sketches),
      demo_functionality.tex (renamed) and demo_documentation.tex
      (detailed documentation as backup slides)
    - README: colours, fonts, deviations from the style guide, QR codes
    - visible changes for existing presentations: colours of blocks and
      ToC, author/affiliations on the title slide in Graphite Black, white
      footer claim, English claim spelled "Move mountains"

*   v3.03-2026
    XeLaTeX/LuaTeX using `tikz`, structure with `figs` and `graphics`
    (University 2025 rebranding)
    - template split into two starting points, `talk.tex` (conference
      mode) and `lecture.tex` (lecture mode), sharing the slides in
      `functionality_demo.tex` that demonstrate the class features;
      no personal information, demo figures drawn with TikZ
      (`template.tex` removed)
    - new option: lectureFootings (slogan, lecture name, slide number;
      the lecture name is not replaced by section names)
    - \lecture{} stores the lecture name (\insertMULlecture); beamer's
      original \lecture remains available as \lectureBeamer
    - default localization: German again (DElocalization); presentations
      relying on the English default need the ENlocalization option
    - fixed: footer did not show the section name at section starts in
      lecture mode
    - fixed: empty e-mail/conference/date on the title page still added
      their spacing; conference slot not shown in lecture mode
    - empty slogan (\renewcommand{\MULsloganText}{}) supported
    - fixed: \conference after \lecture did not switch off the ToC slides
      at section starts
    - removed debug output and a redundant re-opening of the .nav file at
      the end of the compilation; \lastslide counter renamed MULlastslide
    - lecture.tex: plain-text PDF title (\texorpdfstring)
    - README: Getting Started section, documented \email, \example,
      \setFrameLogo, \lastslide, \lectureBeamer

*   v3.02-2025
    XeLaTeX/LuaTeX using `tikz`, structure with `figs` and `graphics`
    (University 2025 rebranding)
    - new background title image for CMS, lighther version
    - new slogan style on title page ("scientific template")
    - change from turquoise to greyish slogan on slides
    - default localization: English

*   v3.01-2025
    XeLaTeX/LuaTeX using `tikz`, structure with `figs` and `graphics`
    (University 2025 rebranding)
    - change of the ugly turquoise slogan in footings to whitish color
    - corrected format of defaultFootings
    - CMS backgroung image on title page
    
*   v3.00-2025
    XeLaTeX/LuaTeX using `tikz`, structure with `figs` and `graphics`
    (University 2025 rebranding)
    - renaming beamerDMS to mul-beamer (consistency of the whole LaTeX suite)
    - inclusion of Funnel Display (2025 MUL branding)
    - change from pdflatex to xelatex to be able to use TTFs (see above)
    - new option: defaultFootings (to complement emptyFootings and fullFootings)
    - new option: DElocalization (default) vs ENlocalization (logos, slogan)
    - change of indentation signs in itemize (from triangles to squares)
    - overdraw is relative to the text area, not page (i.e. shifts with sidebar)

*   v2.10-2024
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - list of ToDos for next class update

*   v2.01-2024
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - update of `\framegrid` command

*   v2.00-2024
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - new format: 16/9
    - new options: `emptyFootings` and `fullFootings`
    - major clean up

*   v1.02-2020
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)
    - new environment `overdraw`

*   v1.01-2019
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)

*   v1.00-2019
    pdfLaTeX using `tikz`, structure with `figs` and `graphics`
    (Department of Materials Science design)

*   v0.23-2016
    LaTeX + `dvips` + `ps2pdf` using `pstricks`
    (Department of Physical Metallurgy and Materials Testing design)

*   v0.22-2013
    LaTeX + `dvips` + `ps2pdf` using `pstricks`
    (Department of Physical Metallurgy and Materials Testing design)

*   v0.21-2013
    LaTeX + `dvips` + `ps2pdf` using `pstricks`
    (Department of Physical Metallurgy and Materials Testing design)

*   v0.1-2008-2012
    LaTeX + `dvips` + `ps2pdf` using `pstricks`
    (old Department of Physical Metallurgy and Materials Testing design)
