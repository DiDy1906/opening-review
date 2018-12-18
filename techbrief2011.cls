\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{techbrief2011}[2011/10/21]

\RequirePackage{ifthen}

% globale Makros
\def\ffsbb@name{Technische Fakult\"at}

% default-Werte für die gesamte Fakultät
\def\ffsbb@logotext{\ffsbb@name}
\def\ffsbb@sphone{\empty}
\def\ffsbb@telefax{\empty}
\def\ffsbb@maildomain{@TechFak.Uni-Bielefeld.DE}
\def\ffsbb@homepage{http://www.TechFak.Uni-Bielefeld.DE/}
\def\ffsbb@lang{german}

% Optionen, die eventuell defaults überschreiben
\DeclareOption{english}{
  \def\ffsbb@lang{english}
  \def\ffsbb@name{Faculty of Technology}
  \PassOptionsToClass{english}{unibi-brief}
}

\DeclareOption{bm}{
  \ifthenelse{\equal{\ffsbb@lang}{english}}%
  {\def\ffsbb@logotext{\normalfont\ffsbb@name \\ Biomathematics and Theoretical
      Bioinformatics}}%
  {\def\ffsbb@logotext{\normalfont\ffsbb@name \\ Biomathematik und Theoretische
      Bioinformatik}}
  \def\ffsbb@sphone{6953}
  \def\ffsbb@telefax{6411}
  \def\ffsbb@homepage{http://www.TechFak.Uni-Bielefeld.DE/ags/bm/}
}

\DeclareOption{gi}{
  \ifthenelse{\equal{\ffsbb@lang}{english}}%
  {\def\ffsbb@logotext{\normalfont\ffsbb@name \\ Genome Informatics}}%
  {\def\ffsbb@logotext{\normalfont\ffsbb@name \\ Genominformatik}}%\includegraphics{Genominformatik.pdf}}}%
  \def\ffsbb@sphone{3793}
  \def\ffsbb@telefax{6495}
  \def\ffsbb@homepage{http://gi.CeBiTec.Uni-Bielefeld.DE/}
}

\DeclareOption{pi}{
  \ifthenelse{\equal{\ffsbb@lang}{english}}%
  {\def\ffsbb@logotext{\normalfont\ffsbb@name \\ Practical Informatics}}%
  {\def\ffsbb@logotext{\normalfont\ffsbb@name \\ Praktische Informatik}}
  \def\ffsbb@sphone{6953}
  \def\ffsbb@telefax{6411}
  \def\ffsbb@homepage{http://www.TechFak.Uni-Bielefeld.DE/ags/pi/}
}

\DeclareOption{nohp}{
	\def\ffsbb@homepage{}
}
\ProcessOptions

% ####################################################
\LoadClass{unibi-brief}%##############################
% ####################################################

\ubb@setlogotext{\ffsbb@logotext}
\ifthenelse{\equal{\ffsbb@sphone}{\empty}}{}{%
  \sphone{\ffsbb@sphone}}
\ifthenelse{\equal{\ffsbb@telefax}{\empty}}{}{%
  \telefax{\ffsbb@telefax}
}
\homepage{\ffsbb@homepage}
\ubb@setmaildomain{\ffsbb@maildomain}
