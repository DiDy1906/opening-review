%
% $Id: unibi-brief.cls,v 1.11 2009/03/11 12:05:04 joern Exp joern $
%

%
% Bitte keine Änderungen an dieser Datei vornehmen. Für alle vom
% Benutzer änderbaren Werte gibt es Befehle. Lokale Anpassungen erfolgen
% durch eine abgeleitete Dokument-Klasse, die diese Basis-Klasse
% einbindet. Die vollständige Distribution dieser Klasse enthält ein
% Beispiel für dieses Vorgehen. Siehe
%
%    http://www.uni-bielefeld.de/corporatedesign/
%
% für weitere Informationen.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{unibi-brief}[2009/03/11]

% Da der neue Briefstil nur bedingt der DIN-Norm 676 für Geschäftsbriefe
% entspricht, baut diese Dokumentklasse nicht auf dinbrief.cls auf.
% Stattdessen werden die einzelnen Bestandteile des Briefkopfes (Logo,
% Anschrift, Absender, usw.) als Kästen definiert, und anschließend mit
% Hilfe des Pakets textpos an die vorgesehene Stelle geschoben. Für den
% Satz des eigentlichen Brieftextes wird die Klasse scratcl verwendet.

\LoadClass{scrartcl}

\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage[absolute]{textpos}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\setlength{\unitlength}{1mm}
% \RequirePackage{paratype}
\RequirePackage[T1]{fontenc}
\RequirePackage{calc}
% Schriften
\newcommand{\ubb@fontfamily}{PTSansNarrow-TLF} % phv=helvetica, cmss, dnh (devanagari), bch=bitrsteamCharter
\renewcommand{\sfdefault}\ubb@fontfamily{}
\renewcommand{\familydefault}{\sfdefault}

% der Briefstil verwendet einen relativ großen Durchschuß
\newcommand{\ubb@ten}{\fontfamily{\ubb@fontfamily}\fontsize{10}{15}\selectfont}
% Rückadresse
\newcommand{\ubb@seven}{\fontfamily{\ubb@fontfamily}\fontsize{7}{8}\selectfont}
% Absender
\newcommand{\ubb@nine}{\fontfamily{\ubb@fontfamily}\fontsize{9}{10.8}\selectfont}
% Freitext im Logo
\newcommand{\ubb@eleven}{\fontfamily{\ubb@fontfamily}%
  \bfseries\fontsize{11}{13.2}\selectfont}

% das Seitenlayout des Briefs
\RequirePackage[lmargin=30mm,textwidth=160mm,%
                tmargin=25mm,bmargin=30mm]{geometry}
\setlength{\parindent}{0mm}

% Globale Vorgaben. Diese werden eventuell weiter unten überschrieben.
\def\ubb@phonetext{Telefon}
\def\ubb@sphonetext{Sekretariat}
\def\ubb@telefaxtext{Telefax}
\def\ubb@defphoneprefix{0521 106-}
\def\ubb@rueckadresse{Universit\"at Bielefeld $|$ Postfach 10\,01\,31 $|$ 33501 Bielefeld}
\def\ubb@postscriptum{PS}
\def\ubb@anlagen{Anlage(n)}
\def\ubb@verteiler{Verteiler}

% der frei definierbare Text neben dem Logo
\newcommand{\ubb@setlogotext}[1]{\def\ubb@logotext{#1}}
\ubb@setlogotext{\empty}
\newcommand{\ubb@setmaildomain}[1]{\def\ubb@maildomain{#1}}
\ubb@setmaildomain{@uni-bielefeld.de}

% Die eigentlichen Brief-Befehle. Die Syntax ist teilweise aus den
% Klassen letter und dinbrief übernommen.
\newcommand{\from}[1]{\def\ubb@from{#1}}\from{\empty}
\newcommand{\signature}[1]{\def\ubb@signature{#1}}\signature{\empty}
\newcommand{\phone}[2][\ubb@defphoneprefix]{\def\ubb@phone{#1#2}}\phone[]{\empty}
\newcommand{\sphone}[2][\ubb@defphoneprefix]{\def\ubb@sphone{#1#2}}\sphone[]{\empty}
\newcommand{\telefax}[2][\ubb@defphoneprefix]{\def\ubb@telefax{#1#2}}\telefax[]{\empty}
\newcommand{\email}[2][\ubb@maildomain]{\def\ubb@email{#2#1}}\email[]{\empty}
\newcommand{\homepage}[1]{\def\ubb@homepage{#1}}\homepage{http://www.uni-bielefeld.de/}
\newcommand{\place}[1]{\def\ubb@place{#1}}\place{Bielefeld}
\renewcommand{\date}[1]{\def\ubb@date{#1}}
\newcommand\datum{den\ }

% Optionen, im Augenblick nur Wahl der Sprache
\def\ubb@logocolor{gruen}
\def\ubb@footercolor{gruen}
\DeclareOption{grey}{
  \def\ubb@logocolor{grau}
  \def\ubb@footercolor{schwarz}
}

\def\ubb@fusszeile{unibi-brief-fusszeile-\ubb@footercolor}

\def\ubb@lang{german}
\DeclareOption{english}{
  \def\ubb@lang{english}
  \def\ubb@phonetext{Tel.}
  \def\ubb@sphonetext{Office}
  \def\ubb@telefaxtext{Fax}
  \def\ubb@defphoneprefix{+49 521 106-}
  \def\ubb@rueckadresse{Bielefeld University $|$ P.O. Box 10\,01\,31 $|$ 33501 Bielefeld $|$ GERMANY}
  \def\ubb@anlagen{Enclosures}
  \def\ubb@verteiler{Distribution}
  \def\ubb@fusszeile{unibi-brief-footer-\ubb@footercolor}
  \newcommand\datum{}
}
\ProcessOptions
\RequirePackage[\ubb@lang]{babel}
\date{\today}

% laengendefinition ohne Einheiten
\newcommand*{\getmm}[1]{\strip@pt\dimexpr0.35146\dimexpr#1\relax\relax}
% \newcommand*{\getpt}[1]{\strip@pt#1}

% Die letter-Umgebung beginnt einen neuen Brief. Alle festen Elemente
% werden durch diese Umgebung gesetzt (nicht durch \opening, wie in den
% bisherigen Brief-Klassen).
\newenvironment{letter}[1]{%
  \clearpage%
  \setcounter{page}{1}%
  \thispagestyle{empty}%
  \begin{textblock}{40}(30,12)% Logo
    \begin{picture}(40,18.67)%
			\put(-8,0){\includegraphics{unibi-brief-logo-\ubb@logocolor}}
			\put(42.33,3){\parbox[b]{114mm}{\ubb@eleven\ubb@logotext}}
		\end{picture}
  \end{textblock}
  \begin{textblock}{50}(30,270)% Fußzeile
		\ifthenelse{\equal{\ffsbb@lang}{english}}%
		{\begin{picture}(36.6,16.3)%
      \put(0,0){\includegraphics{\ubb@fusszeile}}%
    \end{picture}}%
    {\begin{picture}(36.6,21.5)%
      \put(0,0){\includegraphics{\ubb@fusszeile}}%
    \end{picture}}%
  \end{textblock}
  \begin{textblock}{5}(10,105)% Falzmarke
    \rule{5mm}{.5pt}
  \end{textblock}
  \begin{textblock}{100}(30,48.5)% Rücksendeadresse
    \ubb@seven\ubb@rueckadresse
  \end{textblock}
  \begin{textblock}{100}(30,55)% Anschrift
    \parbox[t]{100mm}{\ubb@ten#1}
  \end{textblock}
		%% dient nur der Berechnung der Breite der Box
		\newlength\phonelength\setlength\phonelength{\widthof{\ubb@nine{\ \ubb@sphone}}}
		\addtolength\phonelength{19mm}
		\newlength\datelength\setlength\datelength{\widthof{\ubb@ten\ubb@place, \datum\ubb@date}}
		\newlength\emaillength\setlength\emaillength{\widthof{\ubb@email}}
		\newlength\longest\setlength\longest\emaillength
		\ifnum\longest<\datelength \setlength\longest\datelength\fi
		\ifnum\longest<\phonelength \setlength\longest\phonelength\fi
		\newlength\position\setlength\position{190mm}
		\addtolength\position{-\longest}
		%%% Ende der Berechnung
  \begin{textblock}{\getmm\longest}(\getmm\position,48.5)% Absender, coordinaten in mm
    \parbox[t]{\longest}{%
			\ubb@nine\textbf{\ubb@from}%
      \vspace{\baselineskip}%
      \ifthenelse{\equal{\ubb@phone}{\empty}}{}{\newline\makebox[19mm][l]{\ubb@phonetext:} \hfill\ubb@phone}
      \ifthenelse{\equal{\ubb@sphone}{\empty}}{}{\newline\makebox[19mm][l]{\ubb@sphonetext:} \hfill\ubb@sphone}
      \ifthenelse{\equal{\ubb@telefax}{\empty}}{}{\newline\makebox[19mm][l]{\ubb@telefaxtext:} \hfill\ubb@telefax}%
      \vspace{.3em}
      \ifthenelse{\equal{\ubb@email}{\empty}}{}{\newline\hfill\ubb@email}
      \ifthenelse{\equal{\ubb@homepage}{\empty}}{}{\newline\ubb@homepage}
      \vspace{\baselineskip}%
      \newline%
      {\ubb@ten\ubb@place, \datum\ubb@date}
    }
  \end{textblock}
  \vspace*{80mm}%
}{}

% Betreff
\renewcommand{\subject}[1]{\textbf{#1}\vspace{1.5\baselineskip}\par}

% Anrede
\newcommand{\opening}[1]{#1\vspace{\baselineskip}\par}

% Grußformel, eventuell mit alternativer Unterschrift
\newcommand{\closing}[2][\ubb@signature]{\vspace{\baselineskip}\par#2%
  \vspace{3\baselineskip}\par#1}

% Postscriptum
\newcommand{\ps}[1]{\vspace{\baselineskip}\par\ubb@postscriptum\newline#1}

% Anlagen
\newcommand{\encl}[1]{\vspace{\baselineskip}\par\ubb@anlagen\newline#1}

% Verteiler
\newcommand{\cc}[1]{\vspace{\baselineskip}\par\ubb@verteiler\newline#1}