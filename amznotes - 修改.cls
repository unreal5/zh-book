% ------------------------------------------------------------
% amznotes - Alex M Zhang notes
% Credit to David Zhang for the original template

% To fix header for unnumbered chapters, do:
% \chapter*{Chapter Title}
% \markboth{Chapter Title}{Chapter Title}

% TODO:
%   - make math in box titles bold
%   - make macro for lower case namerefs
%   - macro \chapter* as the unnumbered chapter fix above

\ProvidesClass{amznotes}[2023/04/23 amznotes]
\NeedsTeXFormat{LaTeX2e}
\newcommand{\@baseclass}{ctexbook}

% Set the default options
\PassOptionsToClass{a4paper}{\@baseclass}
\PassOptionsToClass{fontsize=10pt}{\@baseclass}
\PassOptionsToClass{parskip=half}{\@baseclass}
% Pass through any other options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}} 

\ProcessOptions\relax % Process the options

\LoadClass{\@baseclass} % Load the base class

% ------------------------------------------------------------
% PROCESS OPTIONS

\RequirePackage{kvoptions}
\DeclareBoolOption{math}        % enables thmbox and math macros
\DeclareBoolOption{code}        % enables codebox, amzcode, and \amzinputcode

\ProcessKeyvalOptions{amznotes}

% ------------------------------------------------------------
% LOAD REQUIRED PACKAGES

\RequirePackage[margin=1in]{geometry}   % set margins
\RequirePackage{fontspec}               % set main font
\RequirePackage{unicode-math}           % set math font; replaces amssymb
\RequirePackage[dvipsnames]{xcolor}     % pretty colors
\RequirePackage{calc,varwidth}
\RequirePackage{tikz}
\usetikzlibrary{backgrounds,intersections,positioning,fit,shapes,fadings,decorations.pathmorphing,graphs,quotes,angles,calc,through}
\pgfdeclarelayer{background}
\pgfdeclarelayer{foreground}
\pgfsetlayers{background,main,foreground}

\RequirePackage{hyperref}               % hyperlinks in pdf viewers; will appear underlined only in pdf viewer
\RequirePackage{fancyhdr}               % fancy headers
\RequirePackage{lastpage}               % "X of Y" footer
\RequirePackage{parskip}                % new line after each paragraph w/o indent
\RequirePackage{setspace}               % 1.5 line spacing
\RequirePackage[explicit]{titlesec}     % chapter styling
\RequirePackage[most]{tcolorbox}        % pretty boxes
\tcbuselibrary{xparse,hooks,skins,breakable,theorems}
\RequirePackage{ifthen}                 % disable index entries not being used
\RequirePackage{multicol}
\RequirePackage{enumitem}                           % customize itemize spacing
\RequirePackage{xfrac}                              % small fractions
\RequirePackage[textsize=scriptsize]{todonotes}     % todo notes
\RequirePackage{tabularx}

\ifamznotes@math
    \RequirePackage{mathtools}          % for math macros; also loads amsmath
    \RequirePackage{amsthm}
    \renewcommand\qedsymbol{$\squoval$}
    \RequirePackage{derivative}
\fi

\ifamznotes@code
    \RequirePackage{minted}             % syntax coloring for code
    \tcbuselibrary{minted}
\fi

% ------------------------------------------------------------
% FONTS

\setmainfont{STIXTwoText}[
	Path=./fonts/STIXTwoText/,
  Extension = .otf,
  UprightFont = STIXTwoMath-Regular,
  BoldFont = STIXTwoText-SemiBold,
  ItalicFont = STIXTwoText-Italic,
  BoldItalicFont = STIXTwoText-BoldItalic,
]
\setmathfont{STIXTwoMath-Regular.otf}
%\setmathfon{STIXTwoMath-Regular.otf}[range={scr,bfscr},StylisticSet=01]
%\setmonofont{Inconsolata}

% ------------------------------------------------------------
% PAGE LAYOUT

\onehalfspacing
\renewcommand{\arraystretch}{1.25}

% ------------------------------------------------------------
% COLORS

% Color palette from https://flatuicolors.com/palette/us
\definecolor{amzchaptercolor}{HTML}{0984e3}
\definecolor{amzdfnboxcolor}{HTML}{0984e3}
\definecolor{amzthmboxcolor}{HTML}{6c5ce7}
\definecolor{amzexboxcolor}{HTML}{fdcb6e}
\definecolor{amzgenboxcolor}{HTML}{00b894}
\definecolor{amztecboxcolor}{HTML}{e17055}
\definecolor{amzcodeboxcolor}{HTML}{2d3436}
\definecolor{amznoteboxcolor}{HTML}{d63031}

% ------------------------------------------------------------
% LINKS

%\hypersetup{
%    colorlinks=false,
%    linkbordercolor=black,
%    urlbordercolor=blue,
%    %pdfborderstyle={/S/U/W 1}   % Underline links; only appears in pdf viewer, not printed
%}
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
% ------------------------------------------------------------
% CHAPTER STYLING
\def\chap@image{} % 章节背景图片文件名
\newcommand{\setchapterimage}[1]{\def\chap@image{#1}}%

\newlength{\chap@bg@height} %如果有背景图，则为图高，否则为0
\newsavebox{\chap@bgbox}

% 章节标题框填充不透明度（根据是否设置了背景图动态决定）
\newcommand{\chap@opacityfill@withimage}{0.25} % 有背景图时
\newcommand{\chap@opacityfill@noimage}{1.0}    % 无背景图时
\newcommand{\chap@opacityfill}{1.0}            % 实际使用的值

% 计算背景图在以 width=\paperwidth 缩放后的高度
\newcommand{\chap@calc@bgheight}{%
  \ifx\chap@image\@empty\def\chap@opacityfill{\chap@opacityfill@noimage}
    \setlength{\chap@bg@height}{0pt}% 无图
  \else
    \def\chap@opacityfill{\chap@opacityfill@withimage}%
    \sbox{\chap@bgbox}{\includegraphics[width=\paperwidth]{\chap@image}}%
    \setlength{\chap@bg@height}{\dimexpr\ht\chap@bgbox+\dp\chap@bgbox\relax}% 盒子高度+深度
  \fi
}


\newfont{\Chap@Num}{eurb10 scaled 8000}




%%|标题后间距可调：改 \titlespacing*{\chapter}{0pt}{-40mm}{12mm} 的最后一个值即可。
%%|背景裁剪范围要微调时，改 \clip (...) rectangle (...); 中的上下锚点（例如把底部从 chapbox.south 换成稍微下移的偏移点）。
%%|若只想铺满正文宽度，可把左右锚点从 current page.* 换成文本区域对应的点并做适配。
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries\thispagestyle{empty}}
{}
{20pt}
{
    % 计算背景图高度
    \chap@calc@bgheight
    \begin{tikzpicture}[remember picture]
        % 1. 绘制 tcolorbox (前景)
        % 这个 node 没有 overlay，所以它会占据空间并决定 tikzpicture 的位置
        \node[inner sep=0pt, text width=\textwidth] (chapbox) {
            \begin{tcolorbox}[
                enhanced,
                left=23mm,
                right=25mm,
                top=2mm,
                spread sidewards,
                sharp corners,
                colback=amzchaptercolor,
                colframe=amzchaptercolor,
                boxrule=1mm,
                % 使用预计算的不透明度参数
                opacityfill=\chap@opacityfill,
                interior style={left color=amzchaptercolor,right color=white},
                title=\Chap@Num\thechapter,
                attach boxed title to top right={xshift=-15mm, yshift=-4mm},
                boxed title style={
                    size=small,
                    colback=amzchaptercolor,
                    colframe=white,
                    drop fuzzy shadow
                },
                drop fuzzy shadow
            ]
            \strut \textcolor{white}{#1}
            \end{tcolorbox}
        };
        % 2. 绘制背景图片 (背景，裁剪到 tcolorbox 高度)
        \ifx\chap@image\@empty
        \else
            \begin{pgfonlayer}{background}
                \begin{scope}[overlay]
                    % 从纸张顶端到 chapbox 底部的裁剪区域，水平铺满整页
                    \clip (current page.north west) rectangle (current page.east |- chapbox.south);
                    \node[inner sep=0pt, anchor=north] at (current page.north) {\includegraphics[width=\paperwidth]{\chap@image}};
                \end{scope}
            \end{pgfonlayer}
        \fi
    \end{tikzpicture}%
}

\titleformat{name=\chapter,numberless}[display]{\normalfont\huge\bfseries}
{}
{20pt}
{
    % 计算章节盒子填充不透明度（无编号章节同样使用）
    \chap@computeopacityfill
    \begin{tcolorbox}[
        enhanced,
        left=23mm,
        right=25mm,
        top=2mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
    boxrule=1mm,
    opacityfill=\chap@opacityfill,
    ]
        \strut \textcolor{white}{#1}
    \end{tcolorbox}
}

% 调整章节标题后的间距，避免正文与背景/标题重叠
\titlespacing*{\chapter}{0pt}{-40mm}{4ex}


% ------------------------------------------------------------
% SECTION STYLING

% \sectionfont{\color{amzchaptercolor}}  % sets colour of sections

% ------------------------------------------------------------
% HEADER STYLING
\newcommand{\print@page}{第~\thepage~页，共~\pageref{LastPage}~页}

\pagestyle{fancy}
\lhead{\footnotesize\nouppercase{\leftmark}}
\rhead{\footnotesize\nouppercase{\rightmark}}
\cfoot{\print@page}

\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}
    \cfoot[C]{\print@page}
}



% ------------------------------------------------------------
% COLOR BOXES
\newcommand{\amzcolorboxtitlesep}{\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}}}

\tcbset{
    amzdefaultstyle/.style={
        enhanced,
        drop fuzzy shadow,
        fonttitle=\strut\bfseries,  % strut for uniform title height
        boxrule=0pt,
        frame hidden,
        separator sign=\amzcolorboxtitlesep,
        % parbox=false,               % normal paragraph spacing
        breakable,
    },
    genboxstyle/.style={
        amzdefaultstyle,
        frame style={fill=amzgenboxcolor!85!black},
        interior style={fill=amzgenboxcolor!5!white},
        segmentation style={solid,draw=amzgenboxcolor!50!black,opacity=0.25,line width=1pt}
    },
    noteboxstyle/.style={
        enhanced,
        boxrule=0pt,
        frame hidden,
        borderline west={4pt}{0pt}{amznoteboxcolor},
        colback=amznoteboxcolor!7!white,
        sharp corners,
    },
    codeboxstyle/.style={
        %overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        left=0pt,
        right=0pt,
        top=0pt,
        bottom=0pt,
        boxrule=0pt,
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}


% Give the index numbers some more space
\renewcommand{\l@tcolorbox}{\@dottedtocline{1}{0pt}{3em}}
\setlength{\columnsep}{3em}

\newcommand{\amzindex}{
    \addcontentsline{toc}{chapter}{索引}
    \chapter*{索引}

    % Remove header for index
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}

    \begin{multicols}{2}
        \amzindexbody
    \end{multicols}
}

\newcommand{\amzindexbody}{}

\newcommand{\addindexentry}[2]{%
    \appto\amzindexbody{
        \iftoggle{#2}{
            \tcblistof[\section*]{#2}{#1}
        }{}
    }
}

%\newamzbox{environment name}{title}{ref label}{color}[tcolorbox style]
\newcounter{amzboxcounter}
\NewDocumentCommand{\newamzbox}{m m m m O{}}{
    \newtcbtheorem[use counter=amzboxcounter,number within=section,list inside={#3}]{tc#1}{#2}{
        amzdefaultstyle,
        frame style={fill=#4!85!black},
        interior style={fill=#4!5!white},
        segmentation style={solid,draw=#4!50!black,opacity=0.25,line width=1pt},
        #5
    }{#3}

    \providetoggle{#3}
    \settoggle{#3}{false}

    \newenvironment{#1}[2]{
        \global\settoggle{#3}{true}
        \begin{tc#1}{##1}{##2}
    }{
        \end{tc#1}
    }

    \newenvironment{#1*}[1]{
        \begin{tc#1*}{##1}
    }{
        \end{tc#1*}
    }

    \addindexentry{#2}{#3}
}

\newamzbox{dfnbox}{定义}{dfn}{amzdfnboxcolor}
\newamzbox{exbox}{例}{ex}{amzexboxcolor}
\newamzbox{tecbox}{技术}{tec}{amztecboxcolor}

\newtcolorbox{genbox}[1]{amzdefaultstyle, genboxstyle, title={#1}}
\newtcolorbox{notebox}{noteboxstyle}

\ifamznotes@math
    \newamzbox{lembox}{引理}{lem}{amzthmboxcolor}
    \newamzbox{thmbox}{定理}{thm}{amzthmboxcolor}
\fi

\ifamznotes@code
    \renewcommand{\theFancyVerbLine}{\ttfamily\scriptsize{\arabic{FancyVerbLine}}}

    \newamzbox{codebox}{代码}{code}{amzcodeboxcolor}[codeboxstyle]

    \newenvironment{amzcode}[2][]{
        \VerbatimEnvironment
        \begin{minted}[
        %linenos,            % Display line numbers
        fontsize=\footnotesize,
        breaklines,         % Allow line breaks
        breakanywhere,
        autogobble,         % Collapse extra white spaces
        %xleftmargin=0mm,
        bgcolor=yellow!10,
        ]{#2}}
    {\end{minted}}

    \newcommand{\amzinputcode}[2]{\inputminted[
        linenos,            % Display line numbers
        breaklines,         % Allow line breaks
        autogobble,         % Collapse extra white spaces
        xleftmargin=3.75mm,
    ]{#1}{#2}}
\fi

% ------------------------------------------------------------
% TEXT MACROS

\newcommand{\dfntxt}[1]{\textit{\textbf{#1}}}

% from https://tex.stackexchange.com/a/150650
\newcommand{\tabitem}{~~\llap{\textbullet}~~}

% ------------------------------------------------------------
% MATH MACROS

\ifamznotes@math
    \newcommand{\rel}[1]{\mathrel{\mathcal{#1}}}

    \newcommand{\N}{\mathbb{N}}
    \newcommand{\Z}{\mathbb{Z}}
    \newcommand{\Q}{\mathbb{Q}}
    \newcommand{\R}{\mathbb{R}}
    \newcommand{\C}{\mathbb{C}}
    \newcommand{\F}{\mathbb{F}}

    \DeclareMathOperator{\laplace}{\mathscr{L}}
    \DeclareMathOperator{\proj}{proj}
    \DeclareMathOperator{\comp}{comp}
    \DeclareMathOperator{\TIME}{TIME}


    \newcommand{\id}{\text{id}}
    \newcommand{\bigO}{\mathcal{O}}
    \newcommand{\symdiff}{\bigtriangleup}

    \newcommand{\alg}[1]{{\left\langle {#1} \right\rangle}}

    \DeclarePairedDelimiter\abs{\lvert}{\rvert}    \DeclarePairedDelimiter\norm{\lVert}{\rVert}
    \DeclarePairedDelimiter\ceil{\lceil}{\rceil}
    \DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

    % Function Restriction
    % From https://tex.stackexchange.com/a/22255
    \newcommand\restrict[2]{{
        \left.\kern-\nulldelimiterspace
        #1
        \vphantom{\big|}
        \right|_{#2}
    }}
\fi %\ifamznotes@math


%补充内容
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