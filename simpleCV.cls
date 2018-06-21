\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simpleCV}[1970/01/01 provides simple CV class]
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load Packages 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[T1]{fontenc}
\RequirePackage[quiet]{fontspec}
\RequirePackage[quiet]{polyglossia}
\setdefaultlanguage{english} % Note: Set language
\RequirePackage{datetime2,datetime2-calc} % Note: Load after 'polyglossia'
\RequirePackage{xcolor} % Note: Load before 'tikz'
\RequirePackage{tikz}
\RequirePackage[hmargin=1.0cm,vmargin={3cm,0.5cm},noheadfoot,nomarginpar,driver=xetex]{geometry} % Note: 'showframe' display borders
\RequirePackage[pdftoolbar=false,pdfmenubar=false,hidelinks]{hyperref}
\RequirePackage[document]{ragged2e}
\usetikzlibrary{shapes.geometric,calc,positioning} % Note: Load tikz libraries

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{background}{HTML}{3A4750}
\definecolor{shadow}{HTML}{6F797F}
\definecolor{foreground}{HTML}{FFFFFF}
\definecolor{color1}{HTML}{A2E1E4}
\definecolor{color1light}{HTML}{EEF9FA}
\definecolor{color2}{HTML}{00D7E2}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setmainfont[Color=background]{Roboto-Regular}
\newfontfamily\bodyfont{Roboto-Medium}
\newfontfamily\thinfont{Roboto-Thin}
\newfontfamily\headingfont{Roboto-Bold}
\RequirePackage[Color=background]{icons}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Global Config
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Disable parindent and parskip for whole document
\setlength{\parindent}{0em} % Disable indent for whole document
\setlength{\parskip}{0em}

% Set date format
\DTMnewdatestyle{Myyyy}{%
    \renewcommand*{\DTMdisplaydate}[4]{\DTMshortmonthname{##2}~##1}%
        \renewcommand*{\DTMDisplaydate}{\DTMdisplaydate}%
}
\DTMsetdatestyle{Myyyy}

% Add symbol to href
\let\oldhref\href
\renewcommand*{\href}[2]{\oldhref{#1}{#2~\tiny{\color{shadow}\FAlink}}}

% Prevent word breaks and overfull boxes
\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000

% Ignore linebreak (used to prevent new line to break float)
\newcommand\gobblepars{%
    \@ifnextchar\par%
        {\expandafter\gobblepars\@gobble}%
        {}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title Header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\titleHeader}[3]{
    \begin{tikzpicture}[remember picture,overlay]
        \node [rectangle,fill=background,anchor=north,minimum width=\paperwidth,minimum height=3cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {\fontsize{40pt}{72pt}\color{foreground}{\thinfont #1}{\bodyfont #2}};
    \node [below=-2.1mm of name] {\fontsize{14pt}{24pt}\color{foreground}\thinfont #3};
    \end{tikzpicture}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Personal Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\@about}[1]{
        \begin{minipage}[t]{0.3\textwidth}
        {\large\textbf{about}}
#1
        \end{minipage}
        \egroup\gobblepars
}
\newcommand\about{\bgroup\obeylines\@about}

\newcommand{\@skills}[2]{
    \begin{minipage}[t]{.4\textwidth}
        {\large\textbf{skills}}
#1
        \vspace{1mm}
#2
        \end{minipage}
        \egroup\gobblepars
}
\newcommand\skills{\bgroup\obeylines\@skills}

\newcommand{\@languages}[1]{
        \begin{minipage}[t]{0.18\textwidth}
        {\large\textbf{languages}}
#1
        \end{minipage}
        \egroup\gobblepars
}
\newcommand\languages{\bgroup\obeylines\@languages}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Skill Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\addSkill}[3]{
    \begin{tikzpicture}[overlay,baseline=-1mm]
        \node [right,rectangle,fill=color1light,minimum width=.95\textwidth,rounded corners=1.2pt,minimum height=11pt] {};
        \node [right,rectangle,fill=color1,minimum width=#3*.95\textwidth,rounded corners=1.2pt,minimum height=11pt] {};
        \node (symbol) [anchor=west] {{\textcolor{background}{#1}}};
        \node [right=-1.5mm of symbol,text depth=0] {\textcolor{background}{\texttt{#2}\hfill}};
    \end{tikzpicture}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Language Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\addLanguage}[2]{
    \begin{tikzpicture}[overlay,square/.style={regular polygon,regular polygon sides=4}, baseline=-1mm]
        \draw [rounded corners=1.2pt,fill=color1] (0, 0.19) rectangle (0.42,-0.19);
    \node (langCode) at (0.21,0) {\textcolor{background}{\texttt{#1}}};
    \node [right=-1.5mm of langCode,text depth=0] {#2};
    \end{tikzpicture}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main CV Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@sectioncolor#1#2#3{{\color{color2} #1#2#3}}

\renewcommand{\section}[1]{
    \par\vspace{\parskip}
    {
        \LARGE\headingfont\color{background}
            \@sectioncolor #1
    }
    \par\vspace{0.5em}
}

\newcommand{\entry}[4]{
    \begin{minipage}[t]{0.21\textwidth}
        #1
    \end{minipage}
    \begin{minipage}[t]{0.78\textwidth}
        \textbf{\color{background}{#2}}\hfill
        {\footnotesize\thinfont{\color{shadow}#3}}\\
        #4
    \end{minipage}\vspace{0.2em}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Cover Letter Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% read about problems with obeylines here:
% https://tex.stackexchange.com/questions/65010/command-obeylines-in-a-macro

% some info on bgroup and endgroup
% https://tex.stackexchange.com/questions/1930/when-should-one-use-begingroup-instead-of-bgroup

\newcommand{\@sender}[2]{
    \begin{flushright}
        {\large\textbf{#1}}
        #2
    \end{flushright}\endgroup
}
\newcommand\sender{\begingroup\obeylines\@sender}

\newcommand{\@recipient}[2]{
    \begin{flushleft}
        {\textbf{#1}}
        #2
    \end{flushleft}\endgroup
    \vspace{0.5cm}
}
\newcommand\recipient{\begingroup\obeylines\@recipient}

\newcommand{\subject}[1]{{\large\textbf{#1}}\vspace{0.2cm}}

\newcommand{\letter}[1]{\setlength{\parskip}{1em}#1}

\newcommand{\attached}[1]{\vspace{1em}{\thinfont{\textit{Attached: #1}}}}
