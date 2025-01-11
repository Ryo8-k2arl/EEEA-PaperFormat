%%
%%
%%
%%
%%

\LoadClass[a4paper, report, titlepage]{jlreq}
\NeedsTeXFormat{LaTeX2e}[2024/01/01]
\ProvidesClass{mnblab}[2024/01/10 mnblab]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{expl3}
\RequirePackage{geometry}
\RequirePackage{luatexja}
\RequirePackage[%
no-math,    % 数式環境に適用しない
deluxe,     %セリフ体の適用（太字や細字も使えるようになる）
expert,     %縦書き・横書きに合わせた仮名を使う
% haranoaji   %原ノ味フォント適用
]{luatexja-preset}




%% 余白のサイズ設定
\geometry{        %
	top=25truemm,   %
	bottom=20truemm,%
	left=20truemm,  %
	right=20truemm, %
    includefoot,    %
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
                { master   } { 埼玉大学~大学院理工学研究科\\数理電子情報専攻~電気電子物理工学プログラム }
                { doctor   } { 埼玉大学~大学院理工学研究科\\数理電子情報専攻~電気電子物理工学プログラム }
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
        \restoregeometry % 余白設定戻し
    }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
