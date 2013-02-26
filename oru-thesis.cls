%---------------------------------------------------------------------------
% ÖREBRO UNIVERSITY THESIS STYLE FILE FOR LATEX
%
% Author: Martin Magnusson (martin.magnusson@oru.se)
% Modified by Robert Lundh (robert.lundh@oru.se)
% Modified by Federico Pecora (federico.pecora@oru.se)
%  -Added support for international master's theses.
% Modified by Jonas Ullberg (jonas.ullberg@oru.se)
%  -Added \supervisor and \examinor commands.
% Modified by Kevin LeBlanc (kevin.leblanc@aass.oru.se)
%  -Updated comments, a few options, and defaults, and cleaned things up a bit.
%
%
%---------------------------------------------------------------------------
% USAGE:
%
% \documentclass[options]{oru-thesis}
%
% With the default options, this style needs the fonts Sabon and Trade Gothic,
% which are not included in standard LaTeX distributions.  Search online for
% help on installing these.  For draft versions you can use the [latexfonts]
% option to use standard latex fonts or [times] to use the Times font instead.
% For the final version you should, however, use the proper fonts.
%
% For the final version you also need to include a number of new commands, which
% are discussed below.  In particular, the \oruseries{}, \isbn{}, and \printer{}
% options will normally need to be set.
%
% For each option below, we mention whether or not the option should be used for
% the final submitted version.
%
%
%---------------------------------------------------------------------------
% OPTIONS:
%
% [doc] - FINAL: YES (if Ph.D. thesis)
%   Make doctoral thesis (one of doc, mas, or lic is needed).
%
% [mas] - FINAL: YES (if Master's thesis)
%   Make masters thesis (one of doc, mas, or lic is needed).
%
% [lic] - FINAL: YES (if licentiate thesis)
%   Make licentiate thesis (one of doc, mas, or lic is needed).
%
% [cugs] - FINAL: YES (if partially funded by CUGS)
%   Adds CUGS logo to first page (use this if you are associated with CUGS).
%
% [notfinished] - FINAL: NO
%   Print "draft" marks on output, to mark that the document is not
%   finished. Works correctly only together with nopageheaders.
%   With pageheaders it puts draft only on title pages.
%
% [a4paper] - FINAL: NO
%   Use A4 paper size instead of G5, as for the standard thesis format.
%
% [latexfonts] - FINAL: NO
%   Use standard latex fonts for running text and math, instead of Sabon,
%   Euler, and Trade Gothic, as for the standard thesis format.
%
% [times] - FINAL: NO
%   Use Times for running text and math, instead of Sabon, Euler, and
%   Trade Gothic, as for the standard thesis format.
%
% [mathtimes] - FINAL: NO
%   Use Times for math mode instead of Euler. This is done automatically
%   if [times] is specified.
%
% [osf] - FINAL: NO
%   Use Sabon "old style figures". This is recommended by the university
%   library, but looks bad in math mode. Not applicable if [times] is used.
%
% [decoratedheadings] - FINAL: NO
%   Use decorated chapter and section headings
%
% [nopageheaders] - FINAL: NO
%   Do NOT use page headers. Instead: number at bottom of the page
%
% [notitle] - FINAL: NO
%   Skip title page.
%
% [bibliography] - FINAL: NO
%   Changes bibname to Bibliography instead of References.
%
%
%---------------------------------------------------------------------------
% COMMANDS:
%
% \oruseries{n} - FINAL: YES
%   Default: none (get from print editors)
%
% \isbn{yournumber} - FINAL: YES
%   Default: none (get from print editors, must be set for doc)
%
% \issn{yournumber} - FINAL: YES
%   Default: none (get from print editors)
%
% \printer{yourprinter} - FINAL: YES
%   Default: none (get from print editors)
%
% \publisher{yourpublisher} - FINAL: YES (default is usually correct)
%   Default: \"{O}rero University
%
% \publisherweb{yourpublisherwebpage} - FINAL: YES (default is usually correct)
%   Default: www.publications.oru.se
%
% \editor{youreditor} - FINAL: NO (unless told otherwise)
%   Default: none
%
% \editoremail{youreditoremail} - FINAL: NO (unless told otherwise)
%   Default: none (only shown if editor is set)
%
% \supervisor{yoursupervisor} - FINAL: NO (unless told otherwise)
%   Default: none (can be used more than once)
%
% \examinor{yourexaminor} - FINAL: NO (unless told otherwise)
%   Default: none (can be used more than once)
%
%---------------------------------------------------------------------------


%======================================================================
% Identification
%======================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oru-thesis}[2010/10/09 v0.5 Last revised by Kevin LeBlanc]


%======================================================================
% Package loading
%======================================================================
\LoadClass{book}


%======================================================================
% Options:
%======================================================================

% Whether or not to print ``draft'' watermarks (calling this option ``draft''
% screws up figures, possibly because of hyperref):
\newif\ifnotfinished
\DeclareOption{notfinished}{\notfinishedtrue}

% Whether to use A4 paper size, otherwise use G5 size for printing:
\newif\ifafour
\DeclareOption{a4paper}{\afourtrue}

% Whether to use standard latex fonts instead of sabon and trade gothic (does
% not affect title pages):
\newif\iflatexfonts
\DeclareOption{latexfonts}{\latexfontstrue}

% Whether to use Sabon + TimesGothic or Times
\newif\iftimes
\DeclareOption{times}{\timestrue}

% Whether to use Times instead of Euler
\newif\ifmathtimes
\DeclareOption{mathtimes}{\mathtimestrue}

% Whether to use Sabon OSF
\newif\ifosf
\DeclareOption{osf}{\osftrue}

% Whether to use decorated headings
\newif\ifdecoratedheadings
\DeclareOption{decoratedheadings}{\decoratedheadingstrue}

% Whether to print title page
\newif\ifnotitle
\DeclareOption{notitle}{\notitletrue}

% Whether to print official ORU logo and stuff
\newif\ifplaintitle
\DeclareOption{plaintitle}{\plaintitletrue}

% Whether to use page headers or not
\newif\ifnopageheaders
\DeclareOption{nopageheaders}{\nopageheaderstrue}

% Type of thesis
\newif\ifdoc
\DeclareOption{doc}{\doctrue}
\newif\iflic
\DeclareOption{lic}{\lictrue}
\newif\ifmas
\DeclareOption{mas}{\mastrue}

% Whether CUGS or not
\newif\ifcugs
\DeclareOption{cugs}{\cugstrue}

% Whether to use References or Bibliography
\newif\ifbibliography
\DeclareOption{bibliography}{\bibliographytrue}

\ProcessOptions

% Make sure doc, lic, or mas are set
\ifdoc
\else
  \iflic
  \else
    \ifmas
    \else
      \ClassError{oru-thesis}{Type not set}{Use one of doc, lic, or mas}
    \fi
  \fi
\fi


%======================================================================
% Commands
%======================================================================
\newcommand{\theissn}{}
\newcommand{\issn}[1]{\renewcommand{\theissn}{#1}}

\newcommand{\theisbn}{}
\newcommand{\isbn}[1]{\renewcommand{\theisbn}{#1}}

\newcommand{\theoruseries}{}
\newcommand{\oruseries}[1]{\renewcommand{\theoruseries}{#1}}

\newcommand{\thepublisher}{\"{O}rebro University}
\newcommand{\publisher}[1]{\renewcommand{\thepublisher}{#1}}

\newcommand{\thepublisherweb}{www.publications.oru.se}
\newcommand{\publisherweb}[1]{\renewcommand{\thepublisherweb}{#1}}

\newcommand{\theprinter}{}
\newcommand{\printer}[1]{\renewcommand{\theprinter}{#1}}

\newcommand{\theeditor}{}
\newif\ifhasEditor
\newcommand{\editor}[1]
{
  \expandafter\def\expandafter\theeditor\expandafter{#1}
  \hasEditortrue
}

\newcommand{\theeditoremail}{}
\newif\ifhasEditorEmail
\newcommand{\editoremail}[1]
{
  \expandafter\def\expandafter\theeditoremail\expandafter{#1}
  \hasEditorEmailtrue
}

\newcommand{\thesupervisors}{}
\newif\ifhasSupervisors
\newif\ifhasMultipleSupervisors
\newcommand{\supervisor}[1]
{
  \ifhasSupervisors
    \expandafter\def\expandafter\thesupervisors\expandafter{\thesupervisors \newline{} #1}
    \hasMultipleSupervisorstrue
  \else
    \expandafter\def\expandafter\thesupervisors\expandafter{#1}
  \fi
  \hasSupervisorstrue
}

\newcommand{\theexaminers}{}
\newif\ifhasExaminers
\newif\ifhasMultipleExaminers
\newcommand{\examiner}[1]
{
  \ifhasExaminers
    \expandafter\def\expandafter\theexaminers\expandafter{\theexaminers \newline{} #1}
    \hasMultipleExaminerstrue
  \else
    \expandafter\def\expandafter\theexaminers\expandafter{#1}
  \fi
  \hasExaminerstrue
}


%======================================================================
% Layout:
%======================================================================
\ifafour
  \usepackage[
    a4paper,
    %body={120mm,220mm},
    right  = 25mm,
    left   = 25mm,
    top    = 33mm, %25
    bottom = 20mm, %25
    marginparwidth={35mm},
    marginparsep={5mm},
    includemp,
    includefoot,
    reversemp,
    dvips,
    %twoside
  ]{geometry}
\else
  \usepackage[
    % g5paper,
    paperwidth = 169mm,
    paperheight = 239mm,
    \ifnopageheaders
      top= 20mm,
      left = 25mm,
      right = 25mm,
      bottom= 30mm,
    \else
      % More top margin when page headers.
      top= 24mm,
      left = 25mm,
      right = 25mm,
      bottom= 30mm,
    \fi
    marginparwidth= 23mm, %13mm,
    marginparsep= 1mm, %0mm,
    %includehead,
    reversemp,
    dvips,
    twoside
  ]{geometry}
\fi

\newlength{\marginwidth}
\setlength{\marginwidth}{\marginparwidth}
\addtolength{\marginwidth}{\marginparsep}

\newlength{\bodywidth}
\setlength{\bodywidth}{\textwidth}
\ifafour
  \addtolength{\bodywidth}{\marginwidth}
\fi

% Hairline line thickness for frames (keylines and such)
\linethickness{0.25pt}

% == For empty page =================================================

\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
  \clearpage
  {\pagestyle{empty}\origdoublepage}%
}
\let\cleardoublepage\clearemptydoublepage

% == Fonts used: =====================================================
\usepackage[T1]{fontenc}
\usepackage{textcomp}
\iflatexfonts
\else
  \iftimes
    % Use Times:
    \usepackage{mathptmx}
    %
    \providecommand{\vect}[1]{\ensuremath{\mathbf{#1}}}
    \providecommand{\matr}[1]{\ensuremath{\mathbf{#1}}}
  \else
    \ifosf
      % Sabon with OSF:
      \renewcommand{\rmdefault}{psbj}
    \else
      % Sabon without OSF:
      \renewcommand{\rmdefault}{psbx}
    \fi
    \ifmathtimes
      % Use Times for math:
      \providecommand{\vect}[1]{\ensuremath{\mathbf{#1}}}
      \providecommand{\matr}[1]{\ensuremath{\mathbf{#1}}}
    \else
      % Use Euler for math
      \ifosf
        \usepackage[euler-digits]{eulervm}%[small]
      \else
        \usepackage[]{eulervm}%[small]
      \fi
      \providecommand{\vect}[1]{\ensuremath{\vec{#1}}}
      \providecommand{\matr}[1]{\ensuremath{\mathbold{#1}}}
    \fi
    % Trade Gothic: (Trade Gothic Bold Two is fontseries eb)
    %\renewcommand{\sfdefault}{ptg}
    \renewcommand{\sffamily}{\fontfamily{ptg}\fontseries{eb}\selectfont}
  \fi
\fi

% No extra large spaces after end of sentence.
\frenchspacing

\raggedbottom

%% Rules to get rid of widows and orphans, but not very effective.
%% Use manual \looseness adjustments instead, if \flushbottom is in
%% effect. (Does PDFTeX have a problem with this?)
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

%======================================================================
% Headers:
%======================================================================
\iflatexfonts
  \ifnopageheaders
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \renewcommand{\headrulewidth}{0pt}%{0.65pt}%
    \fancyhf{}
    \ifnotfinished
      \lfoot{\textit{Draft}}
      \rfoot{\textit{\@date}}
    \fi
    \cfoot{\thepage}
  \fi
\else
  \usepackage{fancyhdr}
  \pagestyle{fancy}
  \renewcommand{\headrulewidth}{0pt}%{0.65pt}%
  \ifnopageheaders
    \fancyhf{}
    \ifnotfinished
      \lfoot{\textit{Draft}}
    \else
      \lfoot{}
    \fi
    \cfoot{\thepage}
    \ifnotfinished
      \rfoot{\textit{\@date}}
    \else
      \rfoot{}
    \fi
  \else
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[LE,RO]{\rmfamily \small \thepage} %{\sffamily\itshape\thepage}
    \fancyhead[LO]{\rmfamily\itshape\small\rightmark} %{\sffamily\itshape\rightmark}
    \fancyhead[RE]{\rmfamily\itshape\small\leftmark} %{\sffamily\itshape\leftmark}
    \fancyfoot[C]{} % {}
    \fancypagestyle{plain}{%
    \fancyhf{} % clear all header and footer fields
    \fancyfoot[C]{\rmfamily\small\thepage} % except the center %{\sffamily\itshape\thepage}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}}
  \fi
  \addtolength{\headwidth}{\oddsidemargin}
\fi

%======================================================================
% Title pages:
%======================================================================
\renewcommand{\maketitle}{
  \begin{titlepage}%
    \pagestyle{empty}
    \enlargethispage{20mm}
    %
    % Centering hack:
    \begin{list}{}{%
      \setlength{\topsep}{0pt}%
      \setlength{\leftmargin}{-\oddsidemargin}%
      \setlength{\rightmargin}{0cm}%
      \setlength{\listparindent}{\parindent}%
      \setlength{\itemindent}{\parindent}%
      \setlength{\parsep}{\parskip}}%
      \item[]%
      \centering%
      %
      \ifplaintitle
        % Skip extra front matter
      \else
      \large\fontfamily{psbj}\selectfont
      \vspace*{0.1\textheight}
      \noindent
      \ifdoc
        \includegraphics[width=4.0cm]{Logo_txt_runt_farg_krans_ENG}\\
      \else
        \includegraphics[width=4.0cm]{Logo_txt_runt_farg_ENG}\\
      \fi
      \vspace*{2ex}
      \ifdoc
        \textit{Doctoral Dissertation}\\
      \else
        \ifmas
          \textit{International Master's Thesis}\\
        \else
          \textit{Licentiate Thesis}\\
        \fi
      \fi
      \vspace*{2.5em}
      \Large\fontfamily{psbj}\selectfont \@title\\
      \vspace*{6em}
      \large\fontfamily{psbj}\selectfont \textsc{\@author}\\
      \textit{Technology}\\
      \vspace*{\fill}
      \footnotesize\fontfamily{psbj}\selectfont
      \ifdoc
        \textit{\"{O}rebro Studies in Technology \theoruseries}\\
      \else
        \textit{Studies from the Department of Technology at \"{O}rebro University \theoruseries}\\
      \fi
      \textsc{\"{o}rebro} \the\year
      \cleardoublepage
      \vspace*{0.09\textheight}%
      \Large\fontfamily{ptg}\selectfont\@title\\
      \cleardoublepage
      \vspace*{0.09\textheight}%
      \Large\fontfamily{psbj}\selectfont
      \ifdoc
        \textit{\"Orebro Studies in Technology \theoruseries}\\
      \else
        \textit{Studies from the Department of Technology \\ at \"Orebro
          University \theoruseries}\\
      \fi
      \vspace*{3ex}%
      \includegraphics[width=1.7cm]{Logo_txt_runt_svv_ENG}\\
      \fi % end \ifplaintitle
      \vspace*{7ex}%
      \Large\fontfamily{ptg}\selectfont\@author\\
      \vspace*{3ex}%
      \huge\fontfamily{ptg}\fontseries{eb}\selectfont\@title\\
      \ifnotfinished
        \vspace*{7ex}
        \large\sffamily
        \@date \\  DRAFT
      \else \ifplaintitle \else
        \ifcugs
          \vspace*{16ex}
          \includegraphics[width=4cm]{CUGS_logo_sv_txt}
        \fi%end cugs

        \vfill

        \newcommand{\pind}{0.20\textwidth}

        \ifhasSupervisors
          \normalsize
          \ifhasMultipleSupervisors
            \parbox[t]{\pind}{Supervisors:}
          \else
            \parbox[t]{\pind}{Supervisor:}
          \fi
          \parbox[t]{0.50\textwidth}{\thesupervisors}
          \newline
        \fi

        \ifhasExaminers
          \normalsize
          \ifhasMultipleExaminers
            \parbox[t]{\pind}{Examiners:}
          \else
            \parbox[t]{\pind}{Examiner:}
          \fi
          \parbox[t]{0.50\textwidth}{\theexaminers}
          \newline
        \fi

        \clearpage
        \vspace*{\fill}
        \large\fontfamily{psbj}\selectfont%
        \copyright\ \@author, \the\year

        \normalsize
        \vspace*{3ex}
        \textit{Title: } \@title

        \ifdoc
          \vspace*{3ex}
          \textit{Publisher}: \thepublisher, \the\year \\
          \thepublisherweb

          \ifhasEditor
            \vspace*{3ex}
            \textit{Editor}: \theeditor \\
            \ifhasEditorEmail
              \theeditoremail
            \fi
          \fi

          \vspace*{3ex}
          \textit{Printer}: \theprinter

          \vspace*{3ex}
          {\scriptsize ISSN} \theissn \\
          {\scriptsize ISBN} \theisbn
        \else
          \vspace*{1ex}
          {\scriptsize ISSN} \theissn
        \fi
      \fi
      \fi
    \end{list} % End of centering hack
  \end{titlepage}%
}

%======================================================================
% Headings:
%======================================================================
\iflatexfonts
% Do nothing
\else
\ifdecoratedheadings
  \input{decoratedheadings}
\else

%======================================================================
% Chapter headings:
%======================================================================

% Numbered chapters:
\def\@makechapterhead#1{
  {
    %\cleardoublepage%
    \vspace*{0.09\textheight}%
    \noindent\raggedright
    \huge \bfseries\sffamily \@chapapp{} \thechapter \\
    \Huge \bfseries\sffamily #1
    \vskip 0.09\textheight
    \ifnopageheaders
    \else
      \thispagestyle{plain}
    \fi
  }
}

% Un-numbered chapters:
\def\@makeschapterhead#1{
  {
    %\cleardoublepage%
    \vspace*{0.07\textheight}%
    \noindent\raggedright
    \phantom{\huge \bfseries\sffamily \@chapapp{} \thechapter} \\
    \Huge\bfseries\sffamily #1
    \vskip 0.09\textheight
    \ifnopageheaders
    \else
      \thispagestyle{plain}
    \fi
  }
}

%======================================================================
% Section headings:
%======================================================================
\renewcommand\section{%
    \@startsection {section}{1}%
    {\z@}%
    {-3.5ex \@plus -1ex \@minus -.2ex}%
    {2.3ex \@plus.2ex}%
    {
      \normalfont\Large\bfseries\sffamily%
      \raggedright  %  Always use ragged right!!
      \vspace{-3mm}
    }%
}

%======================================================================
% Subsection headings:
%======================================================================
\renewcommand\subsection{\@startsection{subsection}{2}%
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {
   \reset@font\large\bfseries\sffamily
   \raggedright
   %Hyphenated headings are ugly:
   \hyphenpenalty=5000
   \tolerance=1000
}}

%======================================================================
% Sub-subsection headings:
%======================================================================
\renewcommand\subsubsection{\@startsection{subsubsection}{3}
  {\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\reset@font\normalsize\bfseries\sffamily%
}}

%======================================================================
% Paragraph headings:
%======================================================================
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                {3.25ex \@plus1ex \@minus.2ex}%
                {-1em}%
                {\reset@font\normalsize\bfseries\sffamily%
}}

%======================================================================
% Subparagraph headings:
%======================================================================
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                {3.25ex \@plus1ex \@minus .2ex}%
                {-1em}%
                {\reset@font\normalsize\bfseries\sffamily%
}}


\fi % end \ifdecoratedheadings
\fi

\ifnotitle
  \renewcommand{\maketitle}{}
\fi

%======================================================================
% Different font in captions:
%======================================================================
\iflatexfonts
\else
  \newcommand{\captionfonts}{\small}
  \def\@makecaption#1#2{%
    \vskip\abovecaptionskip
    \sbox\@tempboxa{\captionfonts \textbf{#1:} #2}%
    \ifdim \wd\@tempboxa >\hsize
      {\captionfonts \textbf{#1:} #2\par}
    \else
      \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
    \vskip\belowcaptionskip}
\fi

%======================================================================
% Change name of bibliography to references by default:
%======================================================================
\ifbibliography
\else
\providecommand*{\bibname}{}
\renewcommand*{\bibname}{References}
\fi
\let\@internalcite\cite
\def\cite{\def\citename##1{##1}\@internalcite}
\def\shortcite{\def\citename##1{}\@internalcite}

%======================================================================
% End of file 'oru-thesis.cls'.
%======================================================================
