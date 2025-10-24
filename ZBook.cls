%%% Class Information %%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ZBook}[2025/10/20 zhong wei book class v0.0.1]
\newcommand{\@baseclass}{ctexbook} % Base class name

% Set the default options
\PassOptionsToClass{a4paper}{\@baseclass}
\PassOptionsToClass{fontsize=10pt}{\@baseclass}
\PassOptionsToClass{parskip=half}{\@baseclass}

% Pass through any other options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}} 

%\ProcessKeyvalOptions*
\ProcessOptions\relax % Process the options


\LoadClass[a4paper,11pt,twoside]{\@baseclass}

%\RequirePackage[a4paper,inner=2cm,outer=2cm,top=2.45cm,bottom=3cm]{geometry}
\RequirePackage[a4paper,lmargin=2.5cm,rmargin=3cm,top=3cm,bottom=2.5cm,headheight=2.5cm,headsep=0.5cm]{geometry}%

\RequirePackage[dvipsnames,svgnames,x11names,table]{xcolor}

\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{graphicx}
\RequirePackage{calc}
\RequirePackage{tikz}
\usetikzlibrary{calc,shapes.geometric, arrows,arrows.meta,shadows.blur,positioning}

\RequirePackage[most]{tcolorbox}
\tcbuselibrary{xparse,hooks,skins,breakable,theorems}

%定制章节
\RequirePackage[explicit]{titlesec} %指定explicit选项，标题名以#1形式传递。
\definecolor{color@chap@num}{RGB}{192,192,192}      %chapter序号颜色
\definecolor{color@chap@title}{RGB}{0,0,0}          %chapter标题颜色
\definecolor{color@sec}{RGB}{0,128,128}             %section颜色
\definecolor{color@subsec}{RGB}{0,128,128}          %subsection颜色
\definecolor{color@subsubsec}{RGB}{0,128,128}       %subsubsection颜色

%定义章节序号使用的字体
\newfont{\Chap@Num}{eurb10 scaled 16000}
\newfont{\Sec@Num}{cmb10 scaled 1500}%pplr9d D:\texlive\2018\texmf-dist\fonts\type1\public\amsfonts\cm cmb10
\newfont{\Subsec@Num}{cmb10 scaled 1000}
\newsavebox{\box@chap@num}
\newsavebox{\box@chap@title}
\newcommand{\chap@format}[1]{\Huge{\bfseries\color{color@chap@title} #1}}%前方，附录，正文都有一个统一的格式。

%\titleformat{command}[shape]{format}{label}{sep}{before-code}[after-code]
\newcommand{\print@chapter}[1]{
\sbox{\box@chap@num}{\itshape\Chap@Num\color{color@chap@num}\thechapter}
\sbox{\box@chap@title}{\parbox[c]{\textwidth-1cm}{\raggedright\chap@format{#1}}} %保存标题盒子
\hfill\parbox{\wd\box@chap@num}{\usebox{\box@chap@num}}%
\llap{\usebox{\box@chap@title}}
}
\titleformat{\chapter}[block]{\thispagestyle{empty}}{}%
          {0pt}
          {%输出章节标题及序号
            \print@chapter{#1}
          }
          [%
            \vspace{1.5pc}
            %\hrule height 2pt%\vspace{1pt}%\hrule height 0.5pt%\vspace{1pc}
          ]
%对应 带*号的chapter
\titleformat{name=\chapter,numberless}
[block]
{}
{}
{0pt}
{\centering\chap@format{#1}}
[%
\vspace{2.5pc}
]


\titleformat{\section}
  {\color{color@sec}\bfseries}
  {\Large \thesection}
  {0.5em}
  {\Large {#1}}
  []
 
\titleformat{\subsection}
  {\color{color@subsec}\bfseries}
  {\thesubsection}
  {0.5em}
  {#1}
  []

\titleformat{\subsubsection}
  {\color{color@subsubsec}\bfseries}
  {\thesubsubsection}
  {0.5em}
  {#1}
  []

\titleformat{\paragraph}[runin]{\bfseries}{}{0em}{#1}%

\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{5pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{0pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{0pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{10pt}


%开始定制代码
\RequirePackage{listings}
\lstnewenvironment{code}[1][]
{
\lstset{
    language=[11]c++,
    basicstyle=\footnotesize\color{black}\ttfamily,
    framesep=0pt,
    %rulecolor=\color{black},
    backgroundcolor=\color{yellow!10},
    commentstyle=\color{green!40!black}\itshape,
    keywordstyle=\color{blue}\bfseries,
    stringstyle=\color{red},
    identifierstyle=\color{black},
    columns=fullflexible,
    keepspaces=true,
    showstringspaces=false,
    tabsize=2,
    showtabs=false,
    %tab=$\dashv$,
    upquote=true,
    xleftmargin=0pt,  % \parindent
    framexleftmargin=0pt,
    prebreak={},
    postbreak={},
    breaklines=true,
    breakatwhitespace=false,
		captionpos=b,
    escapeinside=``,
    aboveskip=\medskipamount,
    belowskip=\medskipamount,
    #1,
}
}{}

\newcommand{\ci}[1]{\lstinline[language=c++,breaklines=true,basicstyle=\color{blue}\ttfamily]|#1|}
%自定义环境
\RequirePackage{pifont}
%使用带圈的数字0-10，过多则会出错
\newcommand{\makenum}[1]{{\ding{\numexpr171+#1}}}%
\renewcommand{\texttt}[1]{\textcolor{blue}{#1}}

\newenvironment{myenum}{%
\begin{dingautolist}{182}%
}
{\end{dingautolist}}


%定义c++符号
\newcommand{\cppsign}{{\fontfamily{lmr}\selectfont$C$\raisebox{4pt}{\scalebox{0.75}{$++$}}}}
\newcommand{\cpp}[1]{{\fontfamily{lmr}\selectfont$C$\raisebox{4pt}{\scalebox{0.75}{$\mathbf{++#1}$}}}}
\newcommand{\csharpsign}{{\fontfamily{lmr}\selectfont$C$\raisebox{2pt}{\scalebox{0.8}{$\#$}}}}

%辅助
\newcommand{\cg}[2][width=.618\textwidth]{
\begin{figure}[H]
\centering
\includegraphics[#1]{#2}
\end{figure}
}%
\newcommand{\cgc}[3][width=.618\textwidth]{
\begin{figure}[H]
\centering
\includegraphics[#1]{#2}
\caption{#3}
\end{figure}
}%
\newcommand{\cgcl}[4][width=.618\textwidth]{
\begin{figure}[H]
\centering
\includegraphics[#1]{#2}
\caption{#3}
\label{#4}
\end{figure}
}%

\RequirePackage{awesomebox}
\RequirePackage{fontawesome5}
\RequirePackage{longtable,booktabs,array}
\RequirePackage{float}






%%设置新字体
%%定义带圈数字命令
\newfontfamily{\nmfont}{circlenumber}
[%
Extension=.otf,
Path=./fonts/]

\newcommand{\quan}[1]{{\nmfont \symbol{#1}}}
\newcommand{\kk}[1]{\quan{\numexpr32+#1}}%\kk{<参数范围1-95>}96、97、98、99分别用\quan{196} \quan{197} \quan{199} \quan{201}

%脚注使用带圈数字
\newcommand*\kkctr[1]{%
  \protect\kk{\number\numexpr\value{#1}\relax}}
\renewcommand*\thefootnote{\textcolor{black}{\kkctr{footnote}}}

%%无悬挂脚注格式
\renewcommand\@makefntext[1]{%
  \setlength\parindent{2\ccwd}\selectfont
  \@thefnmark\ #1}

%修改\part，使其不分页
\def\@endpart{%
	\thispagestyle{empty}
  \vskip40\p@%
   \@afterheading}



\RequirePackage{enumitem}
%\newenvironment{myenum}{\begin{enumerate}[label=\protect\kk{\arabic*}]\small}{\end{enumerate}}%
\setlist{noitemsep}
\setlist[enumerate, 1]{label=\protect\kk{\arabic*},itemsep=0.5ex}


%\RequirePackage{xurl}
\PassOptionsToPackage{hyphens}{url} % Break long URLs and use hyphens to separate the pieces
\RequirePackage{xurl}
\RequirePackage{hyperref}
% Color settings should be done in the next \hypersetup
\hypersetup{ % Set up hyperref options
    unicode, % Use unicode for links
    pdfborder={0 0 0}, % Suppress border around pdf
    %xetex,
    %pagebackref=true,
    %hyperfootnotes=false, % We already use footmisc
    bookmarksdepth=section,
    bookmarksopen=true, % Expand the bookmarks as soon as the pdf file is opened
    %bookmarksopenlevel=4,
    linktoc=all, % Toc entries and numbers links to pages
    breaklinks=true,
    colorlinks=true,
    linkcolor=teal,
    urlcolor=blue
}


%%%marker环境
\newtcolorbox{marker}[1][]{enhanced,before skip=2mm,
    after skip=3mm,fontupper=\rmfamily,
    boxrule=0.4pt,left=5mm,right=2mm,top=1mm,bottom=1mm,
    colback=yellow!50,colframe=yellow!20!black,
    sharp corners,rounded corners=southeast,
    arc is angular,arc=3mm,underlay={%
        \path[fill=tcbcolback!80!black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
        \path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
        \path[fill=yellow!50!black,draw=none] (interior.south west) rectangle node[white]{\Huge\bfseries !} ([xshift=4mm]interior.north west);
    },
    drop fuzzy shadow,#1
}

\tcbset{
    common/.style={
      fontupper=\rmfamily,
      lower separated=true,
      coltitle=black,
      colback=gray!5,
      boxrule=0.5pt,
      fonttitle=\bfseries,
      enhanced,
      breakable,
      top=8pt,
      before skip=8pt,
      attach boxed title to top left={yshift=-0.11in,xshift=0.15in},
      boxed title style={
      	boxrule=0pt,
        colframe=white,
        arc=0pt,
        outer arc=0pt
     	},
      separator sign={.},
      drop fuzzy shadow
     },
     litistyle/.style={  %例题风格
     	common,
      colframe=gray,% 
      colback=white,
      colbacktitle=yellow,
      sharp corners,rounded corners=southeast,
      overlay unbroken and last={
      \node[anchor=south east, outer sep=0pt] at (\linewidth-width,0){\textcolor{black!60}{$\blacksquare$}};}
		 },
		 BreakableBox@title/.code n args={2}
		      {
		        \ifblank{#2}
		          {\tcbset{title={\csname #1name\endcsname~\thetcbcounter}}}
		          {\tcbset{title={\csname #1name\endcsname~\thetcbcounter\ (#2)}}}
		      },
}      
  % define an internal control sequence \newbreakablebox for fancy mode's newtheorem
  % #1 is the environment name, #2 is the prefix of label, #3 is the style
  % style: thmstyle, defstyle, prostyle
  % e.g. \newbreakablebox{theorem}{thm}{thmstyle}
  % will define two environments: numbered ``theorem'' and no-numbered ``theorem*''
  % WARNING FOR MULTILINGUAL: this cs will automatically find \theoremname's definition,
  % WARNING FOR MULTILINGUAL: it should be defined in language settings.
  \newcommand{\newbreakablebox}[3]{
    \ifcsundef{#1name}{%
      % define a default name if not defined before
      \tcbset{BreakableBox@title/.code n args={2}{\tcbset{title={use newcommand define #1name}}} }
    }{\relax}
    \DeclareTColorBox[auto counter,number within=section]{#1}{ g o t\label g }{
        common,#3,
        IfValueTF={##1}
          {BreakableBox@title={#1}{##1}}
          {
            IfValueTF={##2}
            {BreakableBox@title={#1}{##2}}
            {BreakableBox@title={#1}{}}
          },
        IfValueT={##4}
          {
            IfBooleanTF={##3}
              {label={##4}}
              {VIVID@label={#2}{##4}}
          }
      }
    \DeclareTColorBox{#1*}{ g o }{
        common,#3,
        IfValueTF={##1}
          {BreakableBox@title={#1}{##1}}
          {
            IfValueTF={##2}
            {BreakableBox@title={#1}{##2}}
            {BreakableBox@title={#1}{}}
          },
      }
  }
% define several environment 
% we define headers like \definitionname before
\newcommand{\litiname}{例题}
\newbreakablebox{liti}{def}{litistyle}