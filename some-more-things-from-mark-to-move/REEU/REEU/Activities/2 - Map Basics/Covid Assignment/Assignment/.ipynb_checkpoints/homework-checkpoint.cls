%% ============================================================
\NeedsTeXFormat{LaTeX2e}[2021/02/01]
\ProvidesClass{honr490}[Purdue University]

\LoadClass[a4paper, oneside, 11pt]{article}[2005/09/16]
%% ============================================================

%%
%% Margins of Text Pages
%%
\RequirePackage[head=2cm, bottom=2.5cm, left=2.5cm, right=2.5cm]{geometry}
%%
%% ============================================================

%%
%% Authors and Partners
%%
% \HWauthor{Name}{e-mail}: your name and school e-mail.
% \HWno:                   which homework is it?
% \HWcourse:               the course you are submitting to (honr-490).
\RequirePackage{ifthen}
\makeatletter
\newcommand{\HWauthor}[2]{%
  \ifthenelse{\isundefined{\theHWauthors}}{%
    \def\theHWauthors{#1\\#2}
  }%
  {%
    \g@addto@macro\theHWauthors{\and #1\\#2}
  }
  \ifthenelse{\isundefined{\theHWauthorsatheader}}{%
    \def\theHWauthorsatheader{#1}
  }%
  {%
    \g@addto@macro\theHWauthorsatheader{, #1}
  }
}
\newcommand{\HWno}[1]{%
  \ifthenelse{\isundefined{\theHWno}}{%
    \def\theHWno{#1}
  }%
  {%
    \let\theHWno{#1}
  }
}
\newcommand{\HWcourse}[1]{%
  \ifthenelse{\isundefined{\theHWcourse}}{%
    \def\theHWcourse{#1}
  }%
  {%
    \let\theHWcourse{#1}
  }
}
\newcommand{\HWextension}{%
  \def\theHWextension{Yes}
}
\makeatother
% \HWpartner{Name}: Declare somebody you worked with on the homework.
%                   For multiple partners, just use the \partner command 
%                   multiple times. Relative ordering is preserved.
\makeatletter
\newcommand{\HWpartner}[1]{%
  \ifthenelse{\isundefined{\theHWpartners}}{%
    \def\theHWpartners{#1}
  }%
  {%
    \g@addto@macro\theHWpartners{, #1}
  }
}
\makeatother
%%
%% ============================================================

%%
%% Problem Numbering and Sectioning
%%

\RequirePackage{titlesec}

\newcounter{theHWproblem}
\setcounter{theHWproblem}{1}
\newcounter{theHWsubproblem}[theHWproblem]

\newcommand{\HWproblem}{%
  \subsection*{Problem \arabic{theHWproblem}}
  \addtocounter{theHWproblem}{1}
  \setcounter{theHWsubproblem}{1}
}

\titleformat{\subsubsection}[runin]{\bfseries}{}{}{}[)]

\newcommand{\HWsubproblem}{%
  \subsubsection*{\alph{theHWsubproblem}}
  \addtocounter{theHWsubproblem}{1}
}
%%
%% ============================================================

%%
%% Headers and Footers of Text Pages
%%
\RequirePackage{fancyhdr}

\pagestyle{fancy}
\fancyhead[R]{\theHWauthorsatheader}
\fancyhead[C]{\theHWcourse}
\fancyhead[L]{Homework \theHWno}
\fancyfoot[R]{}
\fancyfoot[C]{\thepage}
\fancyfoot[L]{}
%%
%% ============================================================

%%
%% Title
%%
\let\oldmaketitle\maketitle
\renewcommand{\maketitle}{%
  \author{\theHWauthors}
  \title{\theHWcourse{} -- Homework \theHWno}
  \oldmaketitle
  \begin{center}
    \ifthenelse{\isundefined{\theHWextension}}{}{%
      {\Large Using Extension.}

    }
    \ifthenelse{\isundefined{\theHWpartners}}{}{%
      {Partners: \theHWpartners.}
    }
  \end{center}
}
%%
%% ============================================================
