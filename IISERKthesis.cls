\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IISERKthesis}[2026/07/19 IISER Kolkata Thesis Class (example_thesis style)]

% --- Options for Frontmatter Lists ---
\newif\if@showlof \@showloftrue
\newif\if@showlot \@showlottrue
\newif\if@showlol \@showloltrue
\newif\if@shownom \@shownomtrue
\newif\if@showtodo \@showtodotrue

\DeclareOption{nolof}{\@showloffalse}
\DeclareOption{nolot}{\@showlotfalse}
\DeclareOption{nolol}{\@showlolfalse}
\DeclareOption{nonom}{\@shownomfalse}
\DeclareOption{notodo}{\@showtodofalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

% =====================================================================
% --- CLASS DEFINITION & BASE ---
% =====================================================================
% Base class is book. We use twoside for proper even/odd headers.
\LoadClass[12pt, a4paper, openany, twoside]{book}

% =====================================================================
% --- AUTOMATIC FRONT LISTS MACRO ---
% =====================================================================
\newcommand{\makefrontlists}{
    % Temporarily set link color for Table of Contents and Lists
    {
        \hypersetup{linkcolor=toccolor}
        \clearpage
        \phantomsection
        \pdfbookmark[0]{\contentsname}{toc}
        \tableofcontents

        \if@showlof
            \clearpage
            \phantomsection
            \addcontentsline{toc}{chapter}{\listfigurename}
            \listoffigures
        \fi

        \if@showlot
            \clearpage
            \phantomsection
            \addcontentsline{toc}{chapter}{\listtablename}
            \listoftables
        \fi

        \if@showlol
            \@ifundefined{listoflistings}{}{
                \clearpage
                \phantomsection
                \addcontentsline{toc}{chapter}{List of Listings}
                \listoflistings
            }
        \fi

        \if@shownom
            \clearpage
            \phantomsection
            \addcontentsline{toc}{chapter}{\nomname}
            \printnomenclature
        \fi

        \if@showtodo
            \clearpage
            \phantomsection
            \addcontentsline{toc}{chapter}{Todo list}
            \listoftodos
        \fi
    }
}

% =====================================================================
% --- REQUIRED PACKAGES ---
% =====================================================================
\RequirePackage[T1]{fontenc}
\RequirePackage{ebgaramond}     % Garamond font as requested
\RequirePackage{geometry}       % Page margin definitions
\RequirePackage{graphicx}       % For including logos and images
\RequirePackage{setspace}       % For line spacing (onehalfspacing)
\RequirePackage[explicit]{titlesec} % For customizing chapter and section titles
\RequirePackage{fancyhdr}       % For custom headers and footers
\RequirePackage{xcolor}         % For defining custom colors
\RequirePackage{hyperref}       % For clickable links
\RequirePackage{etoolbox}       % For patching commands (e.g., clearing headers at top of page)
\RequirePackage{caption}        % For customizing caption spacing
\captionsetup[listing]{skip=0pt} % Reduce gap between code block frame and caption

\if@shownom
    \RequirePackage{nomencl} % For nomenclature / list of symbols
    \makenomenclature
    \renewcommand{\nomname}{List of Symbols and Abbreviations}
\else
    % Dummy command to prevent compilation errors and whitespace issues
    % if the user disables nomenclature but leaves \nomenclature commands.
    \newcommand{\nomenclature}[3][]{\@bsphack\@esphack}
\fi

\if@showtodo
    \RequirePackage[colorinlistoftodos, textsize=small]{todonotes}
\else
    \RequirePackage[disable]{todonotes}
\fi

% Prevent frontmatter, mainmatter, and backmatter from forcing extra blank pages
\patchcmd{\frontmatter}{\cleardoublepage}{\clearpage}{}{}
\patchcmd{\mainmatter}{\cleardoublepage}{\clearpage}{}{}
\patchcmd{\backmatter}{\cleardoublepage}{\clearpage}{}{}

% Setup hyperref link colors
\definecolor{toccolor}{rgb}{0.0, 0.0, 0.5}     % Dark Blue for TOC
\definecolor{figeqcolor}{rgb}{0.5, 0.0, 0.0}   % Dark Red for Figures/Equations
\definecolor{citecolor}{rgb}{0.0, 0.5, 0.0}    % Dark Green for Citations
\definecolor{urlcolor}{rgb}{0.5, 0.0, 0.5}     % Purple for URLs
\hypersetup{
    colorlinks=true,
    linkcolor=figeqcolor, % Default for internal links (figs, eqs)
    filecolor=urlcolor,      
    urlcolor=urlcolor,
    citecolor=citecolor,
}


% =====================================================================
% --- PAGE GEOMETRY ---
% =====================================================================
\geometry{
    a4paper,
    left=0.9in,
    right=0.9in,
    top=0.8in,
    bottom=0.8in,
    marginparwidth=1.75cm,
    marginparsep=0.25cm
}

% =====================================================================
% --- FONTS & TYPOGRAPHY ---
% =====================================================================
% Set paragraph spacing and line spacing
\onehalfspacing
\setlength{\parindent}{1.5em}
\setlength{\parskip}{0.5em}

% Increase word spacing across the document slightly for readability
% \AddToHook{selectfont}{
%   \spaceskip=1.5\fontdimen2\font 
%   plus 1.5\fontdimen3\font 
%   minus 1.5\fontdimen4\font
% }

% =====================================================================
% --- COLORS ---
% =====================================================================
% Define a color for the large chapter number
\definecolor{chapgray}{gray}{0.6}

% =====================================================================
% --- PAGE HEADERS & FOOTERS (FANCYHDR) ---
% =====================================================================
\pagestyle{fancy}
\fancyhf{} % Clear all header and footer fields
% Customize the chapter and section marks to include the number and title
\renewcommand{\chaptermark}[1]{\markboth{\thechapter\quad #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\quad #1}}
% Place Chapter name on the right side of even pages
\fancyhead[RE]{\nouppercase{\leftmark}}
% Place Section name on the left side of odd pages
\fancyhead[LO]{\nouppercase{\rightmark}}
% Add a line under the header
\renewcommand{\headrulewidth}{0.4pt}
% Place page number in the center of the footer
\fancyfoot[C]{-- \thepage\ --}

% Redefine the 'plain' page style (used by chapters and index pages) 
% so they also get the custom footer
\fancypagestyle{plain}{
    \fancyhf{} % Clear header and footer
    \fancyfoot[C]{-- \thepage\ --} % Add the dashed page number
    \renewcommand{\headrulewidth}{0pt} % No line at top
    \renewcommand{\footrulewidth}{0pt}
}

% =====================================================================
% --- SECTION & CHAPTER FORMATTING (TITLESEC) ---
% =====================================================================
% Format for numbered chapters
\titleformat{\chapter}[display]
  {\normalfont\Huge\bfseries\raggedleft}
  {\fontsize{100}{110}\selectfont\color{chapgray}\thechapter}
  {-30pt}
  {\Huge #1}
\titlespacing*{\chapter}{0pt}{-50pt}{40pt}

% Format for unnumbered chapters (like Abstract, Acknowledgements)
\titleformat{name=\chapter,numberless}[block]
  {\normalfont\Huge\bfseries\centering}
  {}
  {0pt}
  {\Huge #1}
\titlespacing*{name=\chapter,numberless}{0pt}{-50pt}{40pt}

% Patch section to clear the header style if it starts precisely at the top of a new page
\preto\section{%
  \ifdim\pagetotal=\z@
    \thispagestyle{plain}%
  \fi
}

% Format for sections
\titleformat{\section}[block]
  {\titlerule\normalfont\Large\bfseries}
  {\thesection}
  {1em}
  {#1}
  [\titlerule]

% Format for subsections
\titleformat{\subsection}
  {\normalfont\large\bfseries}{\thesubsection}{1em}{#1}

% =====================================================================
% --- METADATA VARIABLES (TITLE PAGE INFO) ---
% =====================================================================
% Setup commands to allow user to define thesis metadata in main.tex
\newcommand{\@supervisor}{}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}}
\newcommand{\@supervisoraffiliation}{}
\newcommand{\supervisoraffiliation}[1]{\renewcommand{\@supervisoraffiliation}{#1}}

\newcommand{\@cosupervisor}{}
\newcommand{\cosupervisor}[1]{\renewcommand{\@cosupervisor}{#1}}
\newcommand{\@cosupervisoraffiliation}{}
\newcommand{\cosupervisoraffiliation}[1]{\renewcommand{\@cosupervisoraffiliation}{#1}}

\newcommand{\@coordinator}{}
\newcommand{\coordinator}[1]{\renewcommand{\@coordinator}{#1}}
\newcommand{\@coordinatoraffiliation}{}
\newcommand{\coordinatoraffiliation}[1]{\renewcommand{\@coordinatoraffiliation}{#1}}

\newcommand{\@rollno}{}
\newcommand{\rollno}[1]{\renewcommand{\@rollno}{#1}}

\newcommand{\@program}{5th Year BS-MS}
\newcommand{\program}[1]{\renewcommand{\@program}{#1}}

\newcommand{\@department}{Department of Physics}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}

\newcommand{\@degree}{Master of Science (MS)}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}

\newcommand{\@institute}{Indian Institute of Science Education and Research-Kolkata, India}
\newcommand{\institute}[1]{\renewcommand{\@institute}{#1}}

\newcommand{\@place}{IISER Kolkata, Mohanpur}
\newcommand{\place}[1]{\renewcommand{\@place}{#1}}

% =====================================================================
% --- CUSTOM TITLE PAGE (\maketitle) ---
% =====================================================================
\renewcommand{\maketitle}{
    \begin{titlepage}
        \begin{center}
            % Shift the whole title page up slightly
            \vspace*{-2cm}
            
            % Institute and DPS Logos side-by-side
            \includegraphics[height=2.5cm]{images/logos/IISERKlogo.png}
            \hspace{1.5cm}
            \includegraphics[height=2.5cm]{images/logos/dps_logo.png}
            
            \vspace{0.3cm}
            
            % Double horizontal rules
            \hrule height 0.5pt
            \vspace{2pt}
            \hrule height 0.5pt
            
            \vspace{0.8cm minus 0.4cm}
            
            % Thesis Title
            {\huge \@title \par}
            
            \vspace{0.8cm minus 0.4cm}
            
            % Double horizontal rules
            \hrule height 0.5pt
            \vspace{2pt}
            \hrule height 0.5pt
            
            \vspace{1cm minus 0.5cm}
            
            {\Large A thesis submitted in partial fulfillment of \\
            requirements for the award of the degree of\par}
            
            \vspace{0.5cm minus 0.2cm}
            
            {\Large \bfseries \@degree \par}
            
            \vspace{0.4cm minus 0.2cm}
            
            {\large by \par}
            
            \vspace{0.4cm minus 0.2cm}
            
            % Author Details
            {\Large \bfseries \@author \par}
            {\large (\@rollno) \\
            \@program \\
            \@department \\
            \@institute \par}
            
            % Flexible space to push supervisors down naturally without overflowing
            \vspace{1.5cm minus 1.2cm}
            
            % --- Supervisor Block ---
            {\large \textbf{Supervised by} \\
            \@supervisor \\
            \@supervisoraffiliation \par}
            
            \vspace{0.4cm minus 0.2cm}
            
            % --- Co-Supervisor Block (if defined) ---
            \ifx\@cosupervisor\@empty
            \else
                {\large \textbf{Co-supervised by} \\
                \@cosupervisor \\
                \@cosupervisoraffiliation \par}
                \vspace{0.4cm minus 0.2cm}
            \fi
            
            % --- Coordinator Block (if defined) ---
            \ifx\@coordinator\@empty
            \else
                {\normalsize \textbf{Coordinated by} \\
                \@coordinator \\
                \@coordinatoraffiliation \par}
            \fi
            
            \vspace{0.5cm minus 0.2cm}
            
            % Date at the very bottom
            {\normalsize \@date \par}
        \end{center}
    \end{titlepage}
}

% =====================================================================
% --- CUSTOM ENVIRONMENTS (FRONTMATTER) ---
% =====================================================================

% --- Declaration Environment ---
\newenvironment{declaration}{
    \newpage
    \chapter*{Declaration}
    \addcontentsline{toc}{chapter}{Declaration}
    I, \@author, roll number \@rollno, a student of the \@department\ of the \@program\ program of \@institute, hereby declare that this thesis is my own work and, to the best of my knowledge, it neither contains materials previously published or written by any other person, nor has it been submitted for any degree/diploma or any other academic award anywhere before. I have used the originality checking service to prevent inappropriate copying.
    
    I also declare that all copyrighted material incorporated into this thesis is in compliance with the Indian Copyright Act, 1957 (amended in 2012) and that I have received written permission from the copyright owners for my use of their work.
    
    I hereby grant permission to \@institute\ to store the thesis in a database which can be accessed by others.
    
    \vspace{2cm}
    \noindent Date: \@date \\
    Place: \@place
    
    \vspace{1cm}
    \begin{flushright}
        .............................. \\
        (Signature of author) \\
        \@author \\
        \@institute
    \end{flushright}
}{}

% --- Certificate Environment ---
\newenvironment{certificate}{
    \newpage
    \chapter*{Certificate}
    \addcontentsline{toc}{chapter}{Certificate}
    This is to certify that the thesis titled ``\@title'' submitted by \@author, a student of the \@department\ of the \@program\ program of \@institute, is based upon his own research work under our supervision. We also certify, to the best of our knowledge, that neither the thesis nor any part of it has been submitted for any degree/diploma or any other academic award anywhere before.
    
    \vspace{2cm}
    \noindent
    \begin{minipage}[t]{0.45\textwidth}
        .............................. \\
        (Signature of supervisor) \\
        \@supervisor \\
        \@supervisoraffiliation \\
        \\
        Date: \@date \\
        Place: \@place
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.45\textwidth}
        \ifx\@cosupervisor\@empty
        \else
            .............................. \\
            (Signature of co-supervisor) \\
            \@cosupervisor \\
            \@cosupervisoraffiliation \\
            \\
            Date: \@date \\
            Place: \@place
        \fi
    \end{minipage}
}{}

% --- Acknowledgements Environment ---
\newenvironment{acknowledgements}{
    \newpage
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{Acknowledgements}
}{}

% --- Abstract Environment ---
\newenvironment{abstract_thesis}{
    \newpage
    \chapter*{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
}{}
