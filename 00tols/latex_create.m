
function tex = latex_create( latexdir, filename, doc_title, doc_author, doc_class, doc_lang )

% usage: tex = latex_create( latexdir, filename, title, author, class, lang )
% 
% Create a latex file
%
% latexdir  - Directory to save LaTeX files
% filename  - LaTeX file name, extension .tex is added if missing 
% title     - Document title
% author    - Document author
% class     - Document class, can be 'article' or 'beamer' (default)
% lang      - Document language, can be 'pt' or 'en' (default)
%

  % Parsing LaTeX class and language
  %----------------------------------------------------------------------------

  if( exist( 'doc_class' ) ~= 1 ), doc_class = 'beamer'; end
  if( exist( 'doc_lang'  ) ~= 1 ), doc_lang  = 'en';     end

  % Geting path to latex tools
  model_path = fileparts( mfilename('fullpath') );

  % Load document model
  switch( doc_class )
    case 'beamer';  latex = fileread( [ model_path '/latex_model_beamer.tex'  ] );
    case 'article'; latex = fileread( [ model_path '/latex_model_article.tex' ] );
    otherwise
      error(['invalid LaTeX class: ' doc_class '!'])
  end

  switch( doc_lang )
    case 'en'; latex = strrep( latex, '---LANG-PACKAGES---', '' );
    case 'pt'; latex = latex_create_add_pt_packages( latex );
    otherwise
      error(['invalid language: ' doc_lang '!'])
  end

  % Adding information to LaTeX string
  %----------------------------------------------------------------------------

  caller = str2latex( evalin( 'caller', 'mfilename' ) );
  latex  = latex_create_replace( latex, doc_lang, doc_title, doc_author, caller );

  % Create tex structure
  %----------------------------------------------------------------------------

  if( ~strcmp( filename(end-3:end), '.tex' ) )
    filename = [ filename '.tex' ];
  end
  
  tex.latexdir     = latexdir;
  tex.figsdir      = [ latexdir '/figs' ];
  tex.filename     = filename;
  tex.fullfilename = [ latexdir '/' filename ];
  tex.class        = doc_class;
  tex.lang         = doc_lang;
  tex.latex        = latex;
  
  % Setting default figure properties
  tex = latex_figure_properties( tex );

  % Create directories and empty LaTeX file (to check if it is possible)
  %----------------------------------------------------------------------------
  
  [ status msg msgid ] = mkdir( tex.figsdir  ); if( status ~= 1 ), error( msg ); end
  [ fid msg ] = fopen( tex.fullfilename, 'w' ); if( fid   == -1 ), error( msg ); end
  
  fclose( fid );

end

%------------------------------------------------------------------------------%
function latex  = latex_create_replace( latex, doc_lang, doc_title, doc_author, caller )

  if( strcmp( doc_lang, 'en' ) ), intro = 'Document created automatically by program';
  else,                           intro = 'Documento criado automaticamente pelo programa';
  end

  latex = strrep( latex, '---TITLE---',   doc_title  );
  latex = strrep( latex, '---AUTHOR---',  doc_author );
  latex = strrep( latex, '---DATE---',    date()     );
  latex = strrep( latex, '---INTRO---',   intro      );
  latex = strrep( latex, '---PROGRAM---', caller     );

end

%------------------------------------------------------------------------------%
function latex = latex_create_add_pt_packages( latex )

  packages = [ '% Packages to write in brazilian portuguese' endline ...
               '\usepackage[utf8]{inputenc}'                 endline ...
               '\usepackage[brazil]{babel}'                  endline ...
               '\usepackage[T1]{fontenc}'                    endline ...
               '\usepackage{ae}'                             endline ...
               '\usepackage{icomma}'                         endline ...
               '\usepackage{indentfirst}'                    endline ...
               '\usepackage[final]{microtype}'               endline ];

  latex = strrep( latex, '---LANG-PACKAGES---', packages );

end

%------------------------------------------------------------------------------%


