oru-thesis:

  This directory contains the Örebro University thesis LaTeX class (oru-thesis).
  See the file oru-thesis.cls for details about which class options are
  available, and for a list of commands which are used to set the thesis
  front matter.

  You can place the files contained in the oru-thesis directory in the same
  directory as your source files, or install the class "properly".  In either
  case you include the document class file using:

    \documentclass[options]{oru-thesis}

  The procedure for installing the class properly will depend on your system.
  Typically you'll want to find a folder called ".../texmf/tex/latex/"
  containing other classes (hint: search for *.cls files).  Then you'll want to
  add the oru-thesis directory to that folder (hint: use svn export).  The
  folder might be in:
    -MiKTeX: C:\Program Files\MiKTeX\tex\latex
    -Cygwin: C:\cygwin\usr\share\texmf\tex\latex
    -Linux: /usr/local/share/texmf/tex/latex or /usr/share/texmf/tex/latex

  After copying the oru-thesis directory, you need to let LaTeX know about the
  new class.  For MiKTeX you do this via the graphical interface (refresh the
  file name database and formats), for Cygwin or Linux you probably need to run
  texhash.  Note that to install the class on a Linux system you'll probably
  need sudo or root access.


fonts:

  The oru-thesis class requires some commercial fonts that are not shipped with
  LaTeX.  This directory includes those fonts, and a script to install them
  which might work if you're using Linux/Cygwin.  See the oru-thesis.cls file
  for options which allow you to use standard fonts instead (useful for draft
  versions, should not be used for the final version).

  For more information about installing fonts check online, e.g.
  http://www.macrotex.net/addfont.html.  The following instructions have been
  gathered from various sources, and they might work.

  1. Unpack the adobe_fonts.zip file into your system's "texmf" directory.  The
     following might work:
       -MiKTeX: unzip adobe_fonts.zip -d "C:\Program Files\MiKTeX"
       -Cygwin: unzip adobe_fonts.zip -d C:\cygwin\usr\share\texmf
       -Linux: sudo unzip adobe_fonts.zip -d /usr/share/texmf

  2. Add the line "p +sabon_tradegothic.map" to the dvips configuration file.
     This file might be:
       -MiKTeX: C:\Program Files\MiKTeX\dvips\config\config.ps
       -Cygwin: C:\cygwin\usr\share\texmf\dvips\config\config.ps
       -Linux: /usr/share/texmf-tetex/dvips/config/config.ps

  3. Add the line "Map sabon_tradegothic.map" to the updmap configuration file.
     You can usually use "initexmf --edit-config-file updmap" to edit the
     appropriate file, since you shouldn't update the updmap.cfg
     file directly on most systems.  In either case the file may be:
       -MiKTeX: C:\Program Files\MiKTeX 2.7\miktex\config\updmap.cfg
       -Cygwin: C:\cygwin\usr\share\texmf\web2c\updmap.cfg
       -Linux: /etc/texmf/updmap.d/00updmap.cfg

  4. Update the map, maybe using "initexmf --mkmaps" or "sudo update-updmap".
     For MikTeX, you may also need to update the file name database and formats
     via the graphical interface.


example:

  A sample thesis, which includes a bunch of useful packages and settings.  To
  compile the example, install the oru-thesis class as described above, and run
  the following:

    latex example.tex
    bibtex example.tex
    latex example.tex
    latex example.tex
    dvips -j0 -Ppdf -Pdownload35 -G0 example
    ps2pdf -dCompatibilityLevel=1.4 -dMaxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true example.ps example.pdf

