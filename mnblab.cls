%%
%%
%%
%%
%%

\NeedsTeXFormat{LaTeX2e}[2024/01/01]
\ProvidesClass{mnblab}[2024/01/10 mnblab]





\ProcessOptions\relax


\LoadClass[a4paper, book, titlepage, openany, 10pt]{jlreq}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \RequirePackage{plautopatch}
\usepackage{xparse}
\RequirePackage{expl3}
\RequirePackage{geometry}
\RequirePackage{bookmark}
\usepackage{fancyhdr}
\pagestyle{fancy}

% \RequirePackage{luatexja}
% \RequirePackage[%
% no-math,    % 数式環境に適用しない
% deluxe,     %セリフ体の適用（太字や細字も使えるようになる）
% expert,     %縦書き・横書きに合わせた仮名を使う
% haranoaji   %原ノ味フォント適用
% ]{luatexja-preset}


%% 余白のサイズ設定
\geometry{        %
	top=25truemm,   %
	bottom=20truemm,%
	left=20truemm,  %
	right=20truemm, %
    includefoot,    %
}

\def\jsc@magscale{1}

\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \jlreq@set@top@contents{#1}%
    \vskip\toclineskip
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@lnumwidth #3\relax
    \@tempcnta=#1\relax
    \advance\@tempcnta by -\jlreq@top@contents
    \@tempdima=1\jlreq@mol
    \multiply \@tempdima by \@tempcnta
    \advance\leftskip \@lnumwidth \hbox{}\hskip -\leftskip
    \advance\leftskip\@tempdima
    {#4}\nobreak
    \leaders\hbox{$\m@th\mkern \@dotsep mu$\null\inhibitglue .\inhibitglue\null$\m@th\mkern \@dotsep mu$}%
    \hfill\nobreak
    \hb@xt@\@pnumwidth{\hss\normalfont\normalcolor #5}%
    \par}%
  \fi
}
\newdimen\jsc@mpt
\newdimen\jsc@mmm
\jsc@mpt=\jsc@magscale\p@
\jsc@mmm=\jsc@magscale mm
\newif\if@english
\@englishfalse
\newcommand{\prechaptername}{\if@english Chapter~\else 第\fi}
\newcommand{\postchaptername}{\if@english\else 章\fi}
\newcommand{\@chapapp}{\prechaptername}
\newcommand{\@chappos}{\postchaptername}
\newcommand{\headfont}{\gtfamily\sffamily}
\newdimen\jsc@tocl@width
\newcommand{\appendixname}{\if@english \else 付録\fi}
\renewcommand{\tableofcontents}{%
  \settowidth\jsc@tocl@width{\headfont\prechaptername\postchaptername}%
  \settowidth\@tempdima{\headfont\appendixname}%
  \ifdim\jsc@tocl@width<\@tempdima \setlength\jsc@tocl@width{\@tempdima}\fi
  \ifdim\jsc@tocl@width<2\zw \divide\jsc@tocl@width by 2 \advance\jsc@tocl@width 1\zw\fi
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\contentsname}%
  \@mkboth{\contentsname}{}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
}
\renewcommand*{\l@chapter}[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \addvspace{1.0em \@plus\jsc@mpt}
    \begingroup
      \parindent\z@
      \rightskip\@tocrmarg
      \parfillskip-\rightskip
      \leavevmode\headfont
      % \if@english\setlength\@lnumwidth{5.5em}\else\setlength\@lnumwidth{4.683\zw}\fi
      \setlength\@lnumwidth{\jsc@tocl@width}\advance\@lnumwidth 2.5\zw
      \advance\leftskip\@lnumwidth \hskip-\leftskip
      {\large#1\nobreak\hfil\nobreak\hbox to\@pnumwidth{\hss#2}}\par\vspace*{0.5\baselineskip}
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*{\l@section}{%
  \@tempdima\jsc@tocl@width \advance\@tempdima 2.5\zw
  \@dottedtocline{1}{\@tempdima}{2\zw}}
\renewcommand*{\l@subsection}{%
  \@tempdima\jsc@tocl@width \advance\@tempdima 4.5\zw
  \@dottedtocline{2}{\@tempdima}{3\zw}}
\renewcommand*{\l@subsubsection}{%
  \@tempdima\jsc@tocl@width \advance\@tempdima 7.5\zw
  \@dottedtocline{3}{\@tempdima}{4\zw}}
\newdimen\@lnumwidth
\def\numberline#1{\hb@xt@\@lnumwidth{#1\hfil}\hspace{0pt}}
\def\jsTocLine{\leaders\hbox{%
$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill}
\def\@dottedtocline#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
\vskip \z@ \@plus.2\jsc@mpt
{\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
    \interlinepenalty\@M
    \leavevmode
    \@lnumwidth #3\relax
    \advance\leftskip \@lnumwidth \null\nobreak\hskip -\leftskip
    {#4}\nobreak
    \jsTocLine \nobreak\hb@xt@\@pnumwidth{%
        \hfil\normalfont \normalcolor #5}\par}\fi}
\renewcommand{\listoffigures}{%
\if@twocolumn\@restonecoltrue\onecolumn
\else\@restonecolfalse\fi
\chapter*{\listfigurename}%
\@mkboth{\listfigurename}{}%
\@starttoc{lof}%
\if@restonecol\twocolumn\fi
}
\renewcommand*{\l@figure}{\@dottedtocline{1}{1\zw}{3.683\zw}}
\renewcommand{\listoftables}{%
\if@twocolumn\@restonecoltrue\onecolumn
\else\@restonecolfalse\fi
\chapter*{\listtablename}%
\@mkboth{\listtablename}{}%
\@starttoc{lot}%
\if@restonecol\twocolumn\fi
}

\ExplSyntaxOn



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Declare variants %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tl_new:N \l_mnblab_title_tl
\tl_new:N \l_mnblab_english_title_tl
\tl_new:N \l_mnblab_degree_tl
\tl_new:N \l_mnblab_author_tl
\tl_new:N \l_mnblab_id_tl
\tl_new:N \l_mnblab_advisor_tl
\int_new:N \l_mnblab_publish_year_int
\int_new:N \l_mnblab_publish_month_int
\int_new:N \l_mnblab_publish_day_int
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% error message %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\msg_new:nnn { mnblab }{ invalid-month }{ Invalid~month~"\l_mnblab_publish_month_int".~Must~be~between~1~and~12. }

\msg_new:nnn { mnblab }{ invalid-day }{ Invalid~day~"\l_mnblab_publish_day_int".~Does~not~exist~for~the~given~month. }

\msg_new:nnn { mnblab }{ invalid-degree }{ Invalid~degree~"\l_mnblab_degree_tl".~Does~not~exist~for~the~given~degree. }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%# basic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\cs_new:Npn \mnblab_zero_padded:n #1
    {
        \int_compare:nNnTF { #1 } < { 10 }
            { 0 \int_to_arabic:n {#1} } % 1桁の場合は前に 0 を付ける
            { \int_to_arabic:n {#1} }   % 2桁以上の場合はそのまま出力
    }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% validation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\cs_new:Nn \mnblab_validate_year:
    {
        \int_compare:nNnTF { \l_mnblab_publish_year_int } >= { 2000 } \int_compare:nNnTF { \l_mnblab_publish_year_int } <= { 10000 }
            { }
            { \msg_fatal:nn { mnblab }{ invalid-year } }
    }
\cs_new:Nn \mnblab_validate_month:
    {
        \int_compare:nNnTF { \l_mnblab_publish_month_int } > { 0 } \int_compare:nNnTF { \l_mnblab_publish_month_int } <= { 12 }
            { }
            { \msg_fatal:nn { mnblab }{ invalid-month } }
    }
\cs_new:Nn \mnblab_validate_day:
    {
        \int_compare:nNnTF { \l_mnblab_publish_day_int } > { 0 } \int_compare:nNnTF { \l_mnblab_publish_day_int } <= { 31 }
            { }
            { \msg_fatal:nn { mnblab }{ invalid-day } }
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% コマンド用の引数を指定
\keys_define:nn { mnblab }{
    title       .tl_set:N  = \l_mnblab_title_tl,
    title_en    .tl_set:N  = \l_mnblab_english_title_tl,
    degree      .tl_set:N  = \l_mnblab_degree_tl,
    author      .tl_set:N  = \l_mnblab_author_tl,
    id          .tl_set:N  = \l_mnblab_id_tl,
    advisor     .tl_set:N  = \l_mnblab_advisor_tl,
    year        .int_set:N = \l_mnblab_publish_year_int,
    month       .int_set:N = \l_mnblab_publish_month_int,
    day         .int_set:N = \l_mnblab_publish_day_int,
    degree      .initial:n = { bachelor },
    year        .default:n = { 2000 },
    month       .default:n = { 1 },
    day         .default:n = { 13 },
}

% 学位ごとの出力分岐設定の関数
\cs_new_protected:Nn \mnblab_degree_output:
    {
        \str_case:NnF \l_mnblab_degree_tl
              {
                { bachelor } { 卒業論文 }
                { master   } { 博士前期課程~学位論文 }
                { doctor   } { 博士後期課程~学位論文 }
              }
              { \msg_fatal:nn { mnblab }{ invalid-degree }}
    }

\cs_new_protected:Nn \mnblab_affiliation_output:
    {
        \str_case:NnF \l_mnblab_degree_tl
              {
                { bachelor } { 埼玉大学~工学部~電気電子物理工学科 }
                { master   } { 埼玉大学~大学院理工学研究科\\数理電子情報専攻~電気電子物理工学~PG }
                { doctor   } { 埼玉大学~大学院理工学研究科\\数理電子情報専攻~電気電子物理工学~PG }
              }
              { \msg_fatal:nn { mnblab }{ invalid-degree }}
    }

\cs_new_protected:Nn \mnblab_publish_day_output:
    {
        \int_use:N \l_mnblab_publish_year_int/ \mnblab_zero_padded:n { \l_mnblab_publish_month_int }/\mnblab_zero_padded:n{ \l_mnblab_publish_day_int }
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% command %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NewDocumentCommand{ \titleinfo }{ m }
    {
        \keys_set:nn { mnblab } { #1 }
    }

\RenewDocumentCommand{ \maketitle }{ }{

        \setcounter{page}{0}

        \thispagestyle{empty}
        \begin{flushright}
            \LARGE
            \mnblab_publish_day_output:
        \end{flushright}
        \vspace{72bp}
        \begin{center}
        {
            \LARGE
            \int_use:N \l_mnblab_publish_year_int~年度 \hspace{1\zw} \mnblab_degree_output: \\
            \vspace{24bp}
            {\huge \textbf{ \l_mnblab_title_tl }} \\
            \vspace{20bp}
            {\huge \textbf{ \l_mnblab_english_title_tl }}

            \vfill
            \mnblab_affiliation_output: \\
            \vspace{18bp}
            指導教員\hspace{1\zw}\l_mnblab_advisor_tl\\
            \vspace{36bp}
            \l_mnblab_id_tl \hspace{1\zw} \l_mnblab_author_tl\\
            \vspace{20bp}
        }
        \end{center}
    }

\cs_set_eq:NN \old_chapter \chapter
\RenewDocumentCommand{ \chapter }{ s m }
    {
        \bool_if:NTF #1
        { \old_chapter*{#2} \addcontentsline{toc}{chapter}{#2} }
        { \old_chapter{#2} }
}
\RenewDocumentCommand{\appendix}{}{%
  \par
  \jlreq@appendix@precode
  \jlreq@appendix@counter
  \jlreq@appendix@heading
  \jlreq@appendix@postcode
  \pagestyle{mnblab_appendix}
}

% 元の thebibliography 環境を呼び出せるように保存
% \cs_new_eq:NN \original_thebibliography: \thebibliography
% \cs_new_eq:NN \original_endthebibliography: \endthebibliography
%. 文献，そのまま
\renewenvironment{thebibliography}[1]{%
  \jlreq@oldfontcommand@enable
  \chapter*{参考文献}
  \@mkboth{参考文献}{参考文献}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
      {\settowidth\labelwidth{\@biblabel{#1}}%
      \labelsep=1\jlreq@zw
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \itemindent=0pt
      \@openbib@code
      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}{%
  \def\@noitemerr{\@latex@warning{Empty~`thebibliography'~environment}}%
  \endlist
  \jlreq@oldfontcommand@disable
}
\let\@openbib@code\@empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 概要を格納するトークンリストを定義
\tl_new:N \l_mnblab_abstract_content_tl

% 概要環境の定義
\NewDocumentEnvironment{abstract}{}{
        \frontmatter
        \pagestyle{mnblab_front}
        \chapter*{概要}
        \group_begin:
    }
    {
        \tableofcontents
        \group_end:
        \mainmatter
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% excute %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\hypersetup{
    pdftitle={\l_mnblab_title_tl},
    pdfauthor={\l_mnblab_author_tl}
}

\renewcommand{\chaptermark}[1]{{\markboth{\prechaptername \thechapter \postchaptername\hspace{5pt}#1}{}}}
\renewcommand{\footrulewidth}{0.4pt}
\setlength{\headwidth}{\textwidth}
\fancypagestyle{mnblab_main}{
    \fancyhf{}
    \fancyhead[OL]{\l_mnblab_title_tl}
    \fancyhead[OR]{}
    \fancyhead[EL]{}
    \fancyhead[ER]{\leftmark}
    \setlength{\headheight}{17pt}
    \fancyfoot[C]{\textit{Saitama University}}
    \fancyfoot[OL]{\thepage}
    \fancyfoot[ER]{\thepage}
}
\fancypagestyle{mnblab_front}{
    \fancyhf{}
    \fancyhead[OL]{\l_mnblab_title_tl}
    \fancyhead[OR]{}
    \fancyhead[EL]{}
    \fancyhead[ER]{\leftmark}
    \setlength{\headheight}{17pt}
    \fancyfoot[C]{\textit{Saitama University}}
    \fancyfoot[OL]{\thepage}
    \fancyfoot[ER]{\thepage}
}
\fancypagestyle{mnblab_appendix}{
    \fancyhf{}
    \fancyhead[OL]{\l_mnblab_title_tl}
    \fancyhead[OR]{}
    \fancyhead[EL]{}
    \fancyhead[ER]{}
    \setlength{\headheight}{17pt}
    \fancyfoot[C]{\textit{Saitama University}}
    \fancyfoot[OL]{\thepage}
    \fancyfoot[ER]{\thepage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\ExplSyntaxOff
\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% To Do %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Chapter などのカスタマイズ
% 2. エンジンによるフォントの設定
% 3. abst 環境の構築
% 4. 表紙の出力
% 5. 罫線やフッターの出力（左右の設定）
