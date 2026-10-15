TODO:
 - user defined footings?

 \licenseframe
     - Appends a slide at the end with CC-BY license and DLE attribution.
     - Intended for open/public talks.

 \appendixframe
     - Inserts a visual "Appendix" frame with muted design.
     - Useful to separate supplementary material.

 \imageframe{<path>}
     - Creates a full-background image slide with no text.
     - Path should be relative to project folder (e.g., ./figures/img1.jpg).

 \imageframec{<path>}
     - Same as \imageframe but adds a centered text box on top.
     - Use inside a frame environment.

 \titleframe
     - Manually creates a title frame (e.g., for a second intro slide).
     - Partly covered: the class options lightTitle/darkTitle select the
       light or dark title slide (v3.10-2026).

 website on the title slide
     - The PowerPoint master shows "UNILEOBEN.AC.AT" at the bottom left of the
       title slide; \website{} is currently used on the closing slide only.

DONE:

 \finalframe (v3.10-2026)
     - Closing slide in the dark style of the PowerPoint master
       ("Danke für Ihre Aufmerksamkeit!"/"Thank you for your attention!"),
       see README.md.

 \agendaframe, \personframe (v3.10-2026)
     - Layouts "Agenda" and "Zur Person" of the PowerPoint master.
