\ProvidesClass{MyBook}[2026/01/15 v0001]
\NeedsTeXFormat{LaTeX2e}
\newcommand{\@baseclass}{ctexbook}

% Set the default options
\PassOptionsToClass{a4paper}{\@baseclass}
\PassOptionsToClass{fontsize=12pt}{\@baseclass}
\PassOptionsToClass{parskip=half}{\@baseclass}
% Pass through any other options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\@baseclass}} 

\ProcessOptions\relax % Process the options

\LoadClass{\@baseclass} % Load the base class


\RequirePackage[margin=2.45cm,top=3cm]{geometry}
\RequirePackage{varwidth}
\RequirePackage{amssymb} % Must be loaded before unicode-math
\RequirePackage[force]{filehook} % Fixes an error
\RequirePackage{unicode-math} % Math fonts in xetexorluatex
\RequirePackage{fontspec}
\setromanfont[Scale=1.04]{Libertinus Serif}
\setsansfont[Scale=1]{Libertinus Sans}
\setmathfont{Libertinus Math}



\RequirePackage[dvipsnames]{xcolor}
%定制一些常用颜色
\definecolor{maincolor}{RGB}{0,33,71}        % Oxford Blue
\definecolor{accentcolor}{RGB}{140,45,25}    % Oxford Red
\definecolor{highlightcolor}{RGB}{255,205,0} % Gold accent
\definecolor{codebg}{RGB}{240,240,245}       % Light blue-tinted code background
\definecolor{codefg}{RGB}{30,30,60}          % Dark blue code foreground
\definecolor{softgray}{RGB}{190,190,200}     % Blue-tinted grey
\definecolor{titlepagebg}{RGB}{230,235,245}  % Soft blue background
\definecolor{inlinecodebg}{RGB}{230,235,245} % Slightly richer blue background for inline code
\definecolor{inlinecodefg}{RGB}{110,30,20}   % Oxford red for inline code text (using accent colour)
\definecolor{outermarginfgcolor}{RGB}{0,139,139} % foregroundcolor 较深的前景色
\definecolor{outermarginbgcolor}{RGB}{43,43,43} % backgroundcolor 较浅的背景色
% Color palette from https://flatuicolors.com/palette/us
\definecolor{amzchaptercolor}{HTML}{0984e3}
\definecolor{amzdfnboxcolor}{HTML}{0984e3}
\definecolor{amzthmboxcolor}{HTML}{6c5ce7}
\definecolor{amzexboxcolor}{HTML}{fdcb6e}
\definecolor{amzgenboxcolor}{HTML}{00b894}
\definecolor{amztecboxcolor}{HTML}{e17055}
\definecolor{amzcodeboxcolor}{HTML}{2d3436}
\definecolor{amznoteboxcolor}{HTML}{d63031}

\RequirePackage{calc}
\RequirePackage{tikz}
\usetikzlibrary{cd,calc,shadows,shadows.blur,hobby,intersections, decorations.markings, decorations.pathreplacing,spy,arrows,shapes,fadings,trees,mindmap,patterns,shapes.arrows,shapes.symbols,tikzmark,shapes.geometric,graphs, quotes, angles,decorations.pathmorphing,through,shadings,backgrounds,positioning,fit,arrows.meta,shapes.misc,decorations.shapes}

% /* -------------------------------------------------------------------------- */
% /*                                 设置pgflayers                                */
% /* -------------------------------------------------------------------------- */
\pgfdeclarelayer{background} %背景%底层
\pgfdeclarelayer{foreground} %上层
\pgfdeclarelayer{top} %顶部
\pgfdeclarelayer{bottom} %底部
\pgfsetlayers{bottom,background,main,foreground,top}

\RequirePackage[explicit]{titlesec}
\RequirePackage[most]{tcolorbox}
\tcbuselibrary{skins,breakable,hooks}

% 定制章节
%\newfont{\font@chapnum}{eurb10 scaled 5000} %
%\def\@chap@image{} % 章背景图片文件名，默认为空
%
%\newcommand{\setchapterimage}[1]{\def\@chap@image{#1}}%
%% 定制chapter%
%
%% /* -------------------------------- Chatper样式 ------------------------------- */
%\titleformat{\chapter}{\huge\bfseries\filcenter}{}{1em}{
%	\makebox[0pt][l]{\def\rad{7pt}%
%		\begin{tikzpicture}[remember picture, overlay]%
%			\begin{pgfonlayer}{bottom}
%					\shade[top color=gray,middle color=gray!40,bottom color=white] (current page.north west) rectangle ++(\paperwidth,-.2\paperheight+0.3cm); % background odd
%			\end{pgfonlayer}
%				\begin{pgfonlayer}{top}
%					\fill[opacity=.3,rounded corners=5pt,color=maincolor]node[append after command={([yshift=2cm,opacity=1]chapnum.north west) rectangle (chapnum.south east)},right,text=white,minimum width=2cm,align=center,font=\font@chapnum,color=white] (chapnum) at ([shift={(1.5cm,-2.5cm)}]current page.north west) {\thechapter};
%					\begin{pgfonlayer}{foreground}
%						\pattern[pattern=sixpointed stars,pattern color=gray,opacity=1.0,rounded corners=5pt]
%						(chapnum.north west) rectangle (chapnum.south east);
%					\end{pgfonlayer}
%					\node[font=\font@chapnum,color=highlightcolor] at (chapnum) {\thechapter};%重新在同一位置绘制
%					%\fill [outermarginfgcolor,path fading=north,rounded corners=5pt]%
%					%([yshift=2cm]chapnum.north west) rectangle (chapnum.south east);
%					\node[right,font=\bfseries\fontsize{32pt}{32pt}\selectfont,align=center] (contents name) at ([shift={(4ex,0)}]chapnum.east) {\begin{varwidth}{.85\linewidth}\baselineskip=2ex  #1\end{varwidth}};
%				\end{pgfonlayer}
%				\ifx\@chap@image\@empty
%				\else
%					\begin{pgfonlayer}{bottom}
%						\node[right] (image) at ([shift={(-0.5cm,-2.8cm)}]current page.north west) {\includegraphics[width=7cm]{\@chap@image}};
%					\end{pgfonlayer}
%				\fi
%	\end{tikzpicture}}
%}
%\titleformat{name=\chapter,numberless}{\bfseries\huge\filcenter}{}{1em}{
%	\makebox[0pt][l]{\def\rad{7pt}%
%		\begin{tikzpicture}[remember picture, overlay]%
%			\begin{pgfonlayer}{bottom}
%				\shade[right color=outermarginbgcolor!30,middle color=outermarginbgcolor!50,left color=outermarginfgcolor!30] (current page.north west) rectangle ++(\paperwidth,-.2\paperheight); % background odd
%				\fill[outermarginfgcolor,opacity=.5]([shift={(0,-4.45cm)}]current page.north west) rectangle ++(\paperwidth,-2mm); % line
%			\end{pgfonlayer}
%			\begin{pgfonlayer}{top}
%				\node[above left,font=\sc\fontsize{25pt}{25pt}\selectfont,align=center] (contents name) at ([shift={(0cm,-4.45cm)}]current page.north east) {\begin{varwidth}{.7\linewidth}\baselineskip=25pt  #1\end{varwidth}};
%			\end{pgfonlayer}
%			\ifx\@chap@image\@empty
%			\else\begin{pgfonlayer}{bottom}
%				\node[right] (image) at ([shift={(-0.5cm,-2.8cm)}]current page.north west) {\includegraphics[width=7cm]{\@chap@image}};
%			\end{pgfonlayer}
%			\fi
%			\path[fill=outermarginbgcolor]node[append after command={
%				([xshift=-2*\rad]pagenumber.south west)  to[out=0,in=180,looseness=1] ([xshift=\rad]pagenumber.north west) --([xshift=-\rad]pagenumber.north east) to[out=0,in=-180,looseness=1] ([xshift=2*\rad]pagenumber.south east) --cycle},
%			text=outermarginfgcolor,font=\sffamily\fontsize{15}{15}\selectfont\bfseries,align=center,minimum height=0.4cm,minimum width=1.3cm,inner sep=1.5mm] (pagenumber) at ([shift={(0,0.3cm)}]current page.south) {\thepage};
%	\end{tikzpicture}}
%}
%\titlespacing{\chapter}{0pt}{0pt}{70pt}
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
	%\chap@calc@bgheight
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
				boxrule=0pt,
				% 使用预计算的不透明度参数
				opacityfill=\chap@opacityfill,
				interior style={left color=amzchaptercolor,right color=amzchaptercolor!30!white},
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
% Section: 模仿章节样式，左侧实心序号盒子，右侧标题
\titleformat{\section}[hang]{\Large\heiti}{%
	\begin{tikzpicture}[baseline=(node.base)]
		\node[
		fill=amzchaptercolor,%maincolor,
		draw=maincolor,
		line width=1pt,
		rounded corners=4pt,
		text=white,
		inner sep=4pt,
		%font=\bfseries,
		font=\bfseries\fontsize{18pt}{18pt}\selectfont,
		blur shadow
		] (node) {\thesection};
	\end{tikzpicture}%
}{0.5em}{\color{maincolor}#1}

%\sectin* 自定义
\titleformat{name=\section,numberless}{}{}{-.5em}{\mysectionnonumformat{#1}}
\newcommand{\mysectionnonumformat}[1]{%
	\makebox[0pt][l]{\def\rad{7pt}%
		\begin{tikzpicture}[remember picture]
			\path[fill=amzchaptercolor,drop shadow={opacity=0.3,shadow xshift=.05cm,shadow yshift=-.05cm}]node[append after command={
				(sec.north west) --(sec.south west) --(sec.south east) -- (sec.north east) --cycle},
			text=white,rounded corners=4pt,font=\sffamily\large\bfseries,align=center,inner ysep=1mm,inner xsep =2mm] (sec) at (0,0) {\begin{varwidth}{.9\linewidth}\setlength\baselineskip{18pt}\hspace{0cm}#1\end{varwidth}};
\end{tikzpicture}}}%最后一个选项为 [<after code>]
\titlespacing{\section}{0pt}{0.5ex plus 0.2ex minus .2ex}{1ex plus .2ex}


% Subsection: 左侧空心序号盒子，右侧标题
\titleformat{\subsection}[hang]{\rmfamily\large\bfseries}{%
	\begin{tikzpicture}[baseline=(node.base)]
		\node[
		fill=maincolor,
		draw=amzchaptercolor,
		line width=1pt,
		rounded corners=3pt,
		text=white,
		inner sep=4pt,
		font=\bfseries,
		blur shadow
		] (node) {\thesubsection};
	\end{tikzpicture}%
}{0.5em}{\textcolor{maincolor!80!black}{#1}}
\titlespacing{\subsection}{0pt}{0.25ex plus 0.2ex minus .2ex}{1ex plus .2ex}

% ----------------------------脚注样式 ----------------------------
%脚注使用带圈数字
\RequirePackage{footmisc}
%%定义带圈数字命令
\newfontfamily{\nmfont}{circlenumber}[%
	Extension=.otf,Path=./fonts/]

\newcommand{\quan}[1]{{\nmfont \symbol{#1}}}
\newcommand{\kk}[1]{\quan{\numexpr32+#1}}%\kk{<参数范围1-95>}96、97、98、99分别用\quan{196} \quan{197} \quan{199} \quan{201}

%脚注使用带圈数字
\newcommand*\kkctr[1]{%
\protect\kk{\number\numexpr\value{#1}\relax}%
}%
\renewcommand*\thefootnote{\textcolor{black}{\kkctr{footnote}}}

%%无悬挂脚注格式
\renewcommand\@makefntext[1]{\setlength\parindent{2\ccwd}\selectfont\@thefnmark\ #1}%

%修改\part，使其不分页
\def\@endpart{%
\vskip40\p@%
\@afterheading}

% 定制enumerate环境
\RequirePackage{enumitem}
\setlist[enumerate,1]{label=\small\textcolor{maincolor}{\protect\kk{\arabic*}},leftmargin=*,noitemsep}
\setlist[enumerate,2]{label=\textcolor{accentcolor}{\bfseries\alph*.},leftmargin=*,noitemsep}
\setlist[enumerate,3]{label=\textcolor{highlightcolor}{\bfseries\roman*.},leftmargin=*,noitemsep}

\setlist[itemize]{noitemsep}



%\newenvironment{myenum}{\begin{enumerate}[label=\protect\kk{\arabic*}]\small}{\end{enumerate}}%

%页脚
\RequirePackage{lastpage}               % "X of Y" footer
\newcommand{\print@page}{第~\textcolor{amzchaptercolor}{$\dfrac{\thepage}{\pageref{LastPage}}$}~页}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\let\headrule\relax
\fancyhead[OL]{\textsc{\sffamily\nouppercase\leftmark}}
\fancyhead[OR]{}
\fancyhead[ER]{\textsc{\sffamily\nouppercase\rightmark}}
\fancyhead[EL]{}
\lfoot{}\cfoot{\print@page}\rfoot{\footnotesize\sffamily\textcolor{lightgray}{高二数学自学指导：} \textbf{\color{darkgray}\chinese{chapter}}}


% ----------------------------代码样式 ----------------------------
\RequirePackage{listings}
\renewcommand*{\lstlistingname}{示例}
\renewcommand*{\lstlistingnamestyle}{\bfseries}
% Configure the listings
\definecolor{listingkeywords}{HTML}{569CD6}
\definecolor{listingidentifiers}{HTML}{000000}
\definecolor{listingcomments}{HTML}{57A64A}
\definecolor{listingstrings}{HTML}{D69D85}
\definecolor{listingnumbers}{rgb}{0.25, 0.25, 0.25}
\definecolor{ueemph}{HTML}{bd63c5}
% Define a fancy style
\lstnewenvironment{code}[1][]
{
    \lstset{
        language=[11]C++,
        columns=fullflexible,%fixed
        aboveskip=0.7\topskip,
        belowskip=0.7\topskip,
        basicstyle=\ttfamily\small,
        commentstyle=\color{listingcomments}\itshape,
        keywordstyle=\color{listingkeywords}\bfseries,
        numberstyle=\scriptsize\color{listingnumbers}\ttfamily,
        stringstyle=\color{listingstrings},
        identifierstyle=\color{listingidentifiers},
        backgroundcolor=\color{white},
        breakatwhitespace=false,
        breaklines=true,
        captionpos=t,
        keepspaces=true,
        showspaces=false,
        showstringspaces=false,
        showtabs=false,
        %numbers=left,
        %numbersep=1em,
        %frame=lines,
        %frame=l,   
        frame=none,
        framerule=.7pt,
        emph=[2]{override,final},
        emphstyle=[2]{\color{blue}\bfseries},       
        emph=[3]{UPROPERTY,UFUNCTION,UENUM,UCLASS,USTRUCT,DOREPLIFETIME},
        emphstyle=[3]{\color{ueemph}\bfseries},
        emph=[4]{BlueprintType,EditDefaultsOnly,BlueprintReadOnly},
        emphstyle=[4]{\color{cyan!70!blue}},
        tabsize=2,
        numbers=none,
        escapeinside=``,
        captionpos=b,%标题的位置
        #1
    }
}{}

\newcommand{\ci}[1]{
    \lstinline[language=C++,breakatwhitespace=false,breaklines,basicstyle=\ttfamily,identifierstyle=\color{blue!75!black},keywordstyle=\color{blue}\bfseries]{#1}%
}

\newcommand{\cppsign}{$C^{++}$}
\newcommand{\cpp}[1][11]{$C^{++ \mathbf{#1}}$}

% Improved inline code style
\newtcbox{\inlinecode}{
    nobeforeafter,
    colback=inlinecodebg,
    colframe=maincolor,%inlinecodefg!50,
    boxrule=0.1pt,
    arc=1.0mm,
    left=2pt, right=2pt, top=1.5pt, bottom=1.5pt,
    boxsep=0.7pt,
    on line,
    fontupper=\small\ttfamily\color{maincolor},
    enlarge left by=0mm,
    enlarge right by=0mm
}


% ----------------------------一些盒子 ----------------------------
% --- ENHANCED TCOLORBOX STYLES ---
\newtcolorbox{notebox}[1][注意]{
    enhanced, % Use enhanced features
    colback=maincolor!10,
    colframe=maincolor,
    fonttitle=\sffamily\bfseries,
    coltitle=white, % White text on coloured background
    title=#1,
    left=2mm, right=2mm, top=2mm, bottom=2mm,
    arc=1mm,
    breakable % Allow box to break across pages
}

\newtcolorbox{examplebox}[1][示例]{
    enhanced,
    colback=accentcolor!10,
    colframe=accentcolor,
    fonttitle=\sffamily\bfseries,
    coltitle=white,
    title=#1,
    left=2mm, right=2mm, top=2mm, bottom=2mm,
    arc=2mm,
    breakable
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

%一些锦上添花的盒子，未完全测试
\RequirePackage{xkeyval}
\RequirePackage{framed}
\pgfmathsetseed{1} % To have predictable results



\define@key{boxedtheorem}{thcounter}{\def\thcounter{#1}}
\define@key{boxedtheorem}{size}{\def\size{#1}}
\define@key{boxedtheorem}{small box style}{\def\smallboxstyle{#1}}
\define@key{boxedtheorem}{big box style}{\def\bigboxstyle{#1}}
\define@key{boxedtheorem}{spanning style}{\def\spanningstyle{#1}}
\define@key{boxedtheorem}{headfont}{\def\headfont{#1}}
\define@key{boxedtheorem}{image}{\def\image{#1}}
\define@key{boxedtheorem}{upshift}{\def\upshift{#1}}
\define@key{boxedtheorem}{rightshift}{\def\rightshift{#1}}
\define@key{boxedtheorem}{broken edges}{\def\tornstyle{#1}}
\define@key{boxedtheorem}{other edges}{\def\otheredges{#1}}
\presetkeys{boxedtheorem}{headfont=, image=logo-tex, thcounter=, small box style=,%
	big box style=, spanning style=, size = .9\textwidth,%
	broken edges=, other edges=,rightshift=-1.95cm,upshift=-.3cm}{}


%To expand properly \smallboxstyle, \bigboxstyle and \spanningstyle in \tikset.
\tikzset{
	execute style/.style={#1},
	execute macro/.style={execute style/.expand once=#1},
}
\newcommand{\couleurs}[1][]{%
	\setkeys{boxedtheorem}{#1}
	\tikzset{fancytitle/.style={draw=black, rectangle,right=10pt}}
	\tikzset{fancytitle/.append style={execute macro=\smallboxstyle}}
	\tikzset{mybox/.style={draw=black, rectangle, inner sep=10pt, inner ysep=20pt}}
	\tikzset{mybox/.append style={execute macro=\bigboxstyle}}
	\tikzset{formulabox/.style={draw=black, rectangle}}
	\tikzset{formulabox/.append style={execute macro=\bigboxstyle}}
	\tikzset{span/.style={black}}
	\tikzset{span/.append style={execute macro=\spanningstyle}}
	\tikzset{torn/.style={execute macro=\tornstyle}}
	\tikzset{other edges/.style={execute macro=\otheredges}}
}

%Hand drawn style : http://tex.stackexchange.com/questions/39296/simulating-hand-drawn-lines
\pgfdeclaredecoration{penciline}{initial}{%
	\state{initial}[width=+\pgfdecoratedinputsegmentremainingdistance,auto corner on length=1mm,]{%
		\pgfpathcurveto%
		{% From
			\pgfqpoint{\pgfdecoratedinputsegmentremainingdistance}%
			{\pgfdecorationsegmentamplitude}%
		}%
		{%  Control 1
			\pgfmathrand
			\pgfpointadd{\pgfqpoint{\pgfdecoratedinputsegmentremainingdistance}{0pt}}%
			{\pgfqpoint{-\pgfdecorationsegmentaspect\pgfdecoratedinputsegmentremainingdistance}%
				{\pgfmathresult\pgfdecorationsegmentamplitude}%
			}%
		}%
		{% To 
			\pgfpointadd{\pgfpointdecoratedinputsegmentlast}{\pgfpoint{1pt}{1pt}}%
		}%
	}%
	\state{final}{}%
}



% To create a nice looking box 
% http://www.texample.net/tikz/examples/boxes-with-text-and-math/
\newsavebox{\boiboite}
\newcommand{\titre}{Titre}
\newenvironment{boite}[2][]%
{%
	\renewcommand{\titre}{#2}
	\couleurs[#1]
	\begin{lrbox}{\boiboite}%
		\begin{minipage}[!h]{\size}
		}%
		{%
		\end{minipage}
	\end{lrbox}
	\begin{center}
		\begin{tikzpicture}
			\node[mybox] (box) {\usebox{\boiboite}};
			\node[fancytitle] at (box.north west) {\titre};
		\end{tikzpicture}
	\end{center}
}


\newcommand{\newboxedtheorem}[4][]{%
	\couleurs[#1]
	\@ifnotempty{#4}{%
		\@ifundefined{the#4}{\@ifundefined{\thcounter}{\newcounter{#4}}{%
				\newcounter{#4}[\thcounter ]}}{}%
	}
	\newenvironment{#2}[1][]{%
		\@ifnotempty{#4}{\refstepcounter{#4}}
		\begin{boite}[#1]{{\headfont#3\@ifnotempty{#4}{ \csname the#4\endcsname}}\@ifnotempty{##1}{ \headfont(##1)}}
		}%
		{%
		\end{boite}
	}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Boxes with no title

\newsavebox{\boiboitedeux}
\newenvironment{notitlebox}[1][]%
{%
	\couleurs[#1]
	\begin{lrbox}{\boiboitedeux}%
		\begin{minipage}[!h]{\size}
		}%
		{%
		\end{minipage}
	\end{lrbox}
	\begin{center}
		\begin{tikzpicture}
			\node [formulabox] (box){\usebox{\boiboitedeux}};
		\end{tikzpicture}
	\end{center}
}

\newcommand{\newboxedequation}[2][]{%
	\couleurs[#1]
	\newenvironment{#2}[1][]{%
		\begin{notitlebox}[#1]
		}%
		{%
		\end{notitlebox}
	}
}    

%%%%%%%%%%%%%%%%%%%%%% Spanning environment (line in the margin + image)
% Macro to draw the shape behind the text, when it fits completly in the page

\def\spanframe#1{%
	\tikz{%
		\node[inner xsep=1.1em] (A) {#1};% Draw the text of the node
		\begin{pgfonlayer}{background}% Draw the shape behind
			\draw[span] (A.north west) -- (A.south west);%
\end{pgfonlayer}}}%

% Macro to draw the shape, when the text will continue in next page
\def\spanframetop#1{%
	\tikz{%
		\node[inner xsep=1.1em] (A) {#1};%    % Draw the text of the node
		\begin{pgfonlayer}{background}%    
			\draw[span] (A.north west) -- (A.south west);%
\end{pgfonlayer}}}%

% Macro to draw the shape, when the text continues from previous page
\def\spanframebottom#1{%
	\tikz{%
		\node[inner xsep=1.1em] (A) {#1};%   % Draw the text of the node
		\begin{pgfonlayer}{background}%   
			\draw[span] (A.north west) -- (A.south west);%
	\end{pgfonlayer}}%
}%

% Macro to draw the shape, when both the text continues from previous page
% and it will continue in next page
\def\spanframemiddle#1{%
	\tikz{%
		\node[inner xsep=1.1em] (A) {#1};%   % Draw the text of the node
		\begin{pgfonlayer}{background}%   
			\draw[span] (A.north west) -- (A.south west);%
\end{pgfonlayer}}}%

% Define the environment which puts the frame
% In this case, the environment also accepts an argument with an optional
% title (which defaults to ``Example'', which is typeset in a box overlaid
% on the top border

\newcommand{\newspanning}[4][]{%
	\couleurs[#1]%
	\@ifnotempty{#4}{%
		\@ifundefined{the#4}{\@ifundefined{\thcounter}{\newcounter{#4}}{%
				\newcounter{#4}[\thcounter ] }}{}%
	}
	\newenvironment{#2}[1][]{%
		\couleurs[#1]
		\@ifnotempty{#4}{\refstepcounter{#4}}
		\def\FrameCommand{\spanframe}%
		\def\FirstFrameCommand{\spanframetop}%
		\def\LastFrameCommand{\spanframebottom}%
		\def\MidFrameCommand{\spanframemiddle}%
		\vskip 1.3\baselineskip%
		\MakeFramed {\FrameRestore}%
		\noindent\tikz\node[inner sep=1ex,,fill=white, %
		anchor=west, overlay] at (-2em, 2em) {\headfont#3%
			\@ifnotempty{#4}{ \csname the#4\endcsname}\@ifnotempty{##1}{ \headfont(##1)}};%
		\tikz\node[anchor=west, overlay] at (\rightshift,\upshift)%
		{\includegraphics[width=1cm]{\image}};%
		\ignorespaces%    
	}%
	{%
		\endMakeFramed%
	}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%  Breakable boxes
%%%%%%%%%%%%% http://www.texample.net/tikz/examples/framed-tikz/
% Macro to draw the shape behind the text, when it fits completly in the page
\def\someframe#1{
	\tikz{
		\node[inner sep=8pt] (A) {#1};  % Draw the text of the node
		\noindent
		\begin{pgfonlayer}{background}  % Draw the shape behind
			\draw[mybox, other edges]
			(A.south east) -- (A.south west) -- (A.north west) -- (A.north east) -- cycle;      
\end{pgfonlayer}}}

% Macro to draw the shape, when the text will continue in next page
\def\someframetop#1{
	\tikz{
		\node[inner sep=5pt] (A) {#1};    % Draw the text of the node
		\begin{pgfonlayer}{background}    
			\draw[mybox]              % Draw the ``complete shape'' behind
			(A.south east) decorate[torn] {-- (A.south west)} 
			decorate[other edges] {-- (A.north west) -- (A.north east) -- cycle};
\end{pgfonlayer}}}

% Macro to draw the shape, when the text continues from previous page
\def\someframebottom#1{
	\tikz{
		\node[inner sep=5pt] (A) {#1};   % Draw the text of the node
		\begin{pgfonlayer}{background}   
			\draw[mybox]              % Draw the ``complete shape'' behind
			decorate[other edges] {(A.south east) -- (A.south west) -- (A.north west)}
			decorate[torn] {-- (A.north east)} decorate[other edges] {-- cycle};
\end{pgfonlayer}}}

% Macro to draw the shape, when both the text continues from previous page
% and it will continue in next page
\def\someframemiddle#1{
	\tikz{
		\node[inner sep=5pt] (A) {#1};   % Draw the text of the node
		\begin{pgfonlayer}{background}   
			\draw[mybox]              % Draw the ``complete shape'' behind
			(A.south east) decorate[torn] {-- (A.south west)} 
			decorate[other edges]{-- (A.north west)}
			decorate[torn] {-- (A.north east)} 
			decorate[other edges]{-- cycle};
\end{pgfonlayer}}}


% Command to define a new environment that can span over multiple pages
\newcommand{\newbreakabletheorem}[4][]{%
	\couleurs[#1]%
	\@ifnotempty{#4}{%
		\@ifundefined{the#4}{\@ifundefined{\thcounter}{\newcounter{#4}}{%
				\newcounter{#4}[\thcounter ] }}{}%
	}
	\newenvironment{#2}[1][]{%
		\couleurs[#1]%
		\@ifnotempty{#4}{\refstepcounter{#4}}
		\def\FrameCommand{\someframe}%
		\def\FirstFrameCommand{\someframetop}%
		\def\LastFrameCommand{\someframebottom}%
		\def\MidFrameCommand{\someframemiddle}%
		\vskip 1.2\baselineskip
		\MakeFramed{\hsize\size\FrameRestore}
		\noindent  \tikz  \node[inner sep=1ex,anchor=west, overlay, fancytitle] at (0pt,6pt) %
		{\headfont#3 \@ifnotempty{#4}{\csname the#4\endcsname}\@ifnotempty{##1}{ \headfont(##1)}}; \par \noindent
		\ignorespaces%    
	}%
	{%
		\endMakeFramed%
	}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%  Parchment boxes
%%%%%%%%%%%%% http://www.texample.net/tikz/examples/framed-tikz/
% Macro to draw the shape behind the text, when it fits completly in the
% page

\def\parchmentframe#1{
	\tikz{
		\node[inner sep=8pt] (A) {#1};  % Draw the text of the node
		\noindent
		\begin{pgfonlayer}{background}  % Draw the shape behind
			\draw[mybox,other edges]
			(A.south east) -- (A.south west) -- (A.north west) -- (A.north east) -- cycle;      
\end{pgfonlayer}}}

% Macro to draw the shape, when the text will continue in next page
\def\parchmentframetop#1{
	\tikz{
		\node[inner sep=8pt] (A) {#1};    % Draw the text of the node
		\begin{pgfonlayer}{background}
			\draw[torn,overlay]               % Add the torn lower border
			($(A.south east)-(0,.3)$) -- ($(A.south west)-(0,.3)$) -- 
			($(A.south west)+(0,.4)$) -- ($(A.south east)+(0,.4)$);
			\draw[mybox,overlay]              % Draw the ``complete shape'' behind
			($(A.south east)+(0,.1)$) decorate[torn] {-- ($(A.south west)+(0,.1)$)}
			decorate[other edges] {-- (A.north west) -- (A.north east) -- cycle};
\end{pgfonlayer}}}

% Macro to draw the shape, when the text continues from previous page
\def\parchmentframebottom#1{
	\tikz{
		\node[inner sep=8pt] (A) {#1};   % Draw the text of the node
		\begin{pgfonlayer}{background}
			\draw[torn,overlay]               % Add the torn upper border
			($(A.north east)-(0,.4)$) -- ($(A.north west)-(0,.4)$) -- 
			($(A.north west)+(0,.3)$) -- ($(A.north east)+(0,.3)$) -- cycle;
			\draw[mybox,overlay]              % Draw the ``complete shape'' behind
			(A.south east) decorate[other edges] {-- (A.south west) -- (A.north west) }
			decorate[torn] {-- (A.north east)} decorate[other edges] {-- cycle};
\end{pgfonlayer}}}

% Macro to draw the shape, when both the text continues from previous page
% and it will continue in next page
\def\parchmentframemiddle#1{
	\tikz{
		\node[inner sep=8pt] (A) {#1};   % Draw the text of the node
		\begin{pgfonlayer}{background}
			\draw[torn,overlay]               % Add the torn upper border
			($(A.north east)-(0,.4)$) -- ($(A.north west)-(0,.4)$) -- 
			($(A.north west)+(0,.3)$) -- ($(A.north east)+(0,.3)$) -- cycle;
			\draw[torn,overlay]               % Add the torn lower border
			($(A.south east)-(0,.3)$) -- ($(A.south west)-(0,.3)$) -- 
			($(A.south west)+(0,.4)$) -- ($(A.south east)+(0,.4)$);
			\draw[mybox,overlay]              % Draw the ``complete shape'' behind
			(A.south east) decorate[torn] { -- (A.south west)}
			decorate[other edges]{-- (A.north west)}
			decorate[torn] {-- (A.north east)} 
			decorate[other edges]{-- cycle};
\end{pgfonlayer}}}


% Command to define a new environment that can span over multiple pages
\newcommand{\newparchment}[4][]{%
	\couleurs[#1]%
	\@ifnotempty{#4}{%
		\@ifundefined{the#4}{\@ifundefined{\thcounter}{\newcounter{#4}}{%
				\newcounter{#4}[\thcounter ] }}{}%
	}
	\newenvironment{#2}[1][]{%
		\couleurs[#1]%
		\@ifnotempty{#4}{\refstepcounter{#4}}
		\def\FrameCommand{\parchmentframe}%
		\def\FirstFrameCommand{\parchmentframetop}%
		\def\LastFrameCommand{\parchmentframebottom}%
		\def\MidFrameCommand{\parchmentframemiddle}%
		\vskip 1.2\baselineskip
		\MakeFramed{\hsize\size\FrameRestore}
		\noindent  \tikz  \node[inner sep=1ex,anchor=west, overlay, fancytitle] at (0pt,10pt) %
		{\headfont#3 \@ifnotempty{#4}{\csname the#4\endcsname}\@ifnotempty{##1}{ \headfont(##1)}}; \par \noindent
		\ignorespaces%    
	}%
	{%
		\endMakeFramed%
	}
}


\newbreakabletheorem[small box style={draw=orange!30!black!20,rounded corners,%
	fill=orange!10!black!2,decoration=penciline, decorate, thick},
headfont=\bfseries\large,
big box style={color=orange!30!black!20,fill=yellow!10,thick},
broken edges={draw=orange!30!black!20,thick,fill=orange!20!black!5,
	decoration={random steps, segment length=.5cm,%
		amplitude=1.3mm},decorate},%
other edges={decoration=penciline,decorate,thick}]%
{exer}{例题}{exer}