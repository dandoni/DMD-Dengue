
function latex_compile_test( tex, option )

% Save and compile the LaTeX file created
%
% Usage:  latex_compile( tex, option )
%
% tex is a structure created by the latex_create
%
% option can be:
% 'saveonly'      - save only without compiling 
% 'batchmode'     - prints nothing on the terminal (default)
% 'nonstopmode'   - diagnostic message appear on the terminal but there is no user interaction
% 'scrollmod'     - only stops for missing files or keyboard input
% 'errorstopmode' - stops at each error and asks for user intervention
%
% The compilation options are passed to pdflatex. On Unix systems,
% if rubber is installed, it is used instead of pdflatex.
%

  % Parsing parameters
  %----------------------------------------------------------------------------%

  if( nargin < 1 ), error('missing parameters!'); end
  if( nargin > 2 ), error('to many parameters!'); end

  if( nargin == 1 )

    compile = true;
    option  = 'batchmode';

  else

    if( ~ismember( option, {'saveonly' 'batchmode' 'nonstopmode' 'scrollmod' 'errorstopmode'} ) )
      error('wrong option!')
    end

    compile = ( strcmp( option, 'saveonly' ) ~= 1 );

  end

  % Saving LaTeX file
  %----------------------------------------------------------------------------%

  [ fid msg ] = fopen( tex.fullfilename, 'w' );

  if( fid == -1 ), error(msg); end
  
  fputs( fid, tex.latex );
  
  fclose( fid );

  % Compiling
  %----------------------------------------------------------------------------%

  if( compile )
    if    ( isunix ), latex_compile_unix( tex, option );
    elseif( ispc   ), latex_compile_pc  ( tex, option );
    elseif( ismac  ), latex_run_pdflatex( tex, option );
    else
      error('failed to detect operating system!')
    end
  end

end

%------------------------------------------------------------------------------%
function latex_compile_unix( tex, option )

  [ status cmd ] = system( 'command -v rubber' );

  if( status == 0 )

    system( [ 'rubber --inplace --short --pdf ' tex.fullfilename ] ); 

  else

    latex_run_pdflatex( tex, option );

  end

end


%------------------------------------------------------------------------------%
function latex_compile_pc( tex, option )

   disp('where /q latexmk'); 
  [ status cmd ] = system( 'where /q latexmk' );

  if( status ~= 1 )

    try 

      old_dir = cd( tex.latexdir );
      disp( [ 'latexmk -pdf ' tex.filename ] ); 
      system( [ 'latexmk -pdf ' tex.filename ] ); 
      cd( old_dir );

    catch 

      cd( old_dir );
      error('failed to run latexmk!')

    end

  else

    latex_run_pdflatex( tex, option );

  end

end

%------------------------------------------------------------------------------%
function latex_run_pdflatex( tex, option )

  try 

    old_dir = cd( tex.latexdir );

    for ii = 1:2
##      system( [ 'pdflatex -interaction=' option ' ' tex.filename ] ); 
      disp( [ 'pdflatex -interaction=' option ' ' tex.filename ] ); 
    end

    cd( old_dir );

  catch 

    cd( old_dir );
    error('failed to run pdflatex!')

  end

end

%------------------------------------------------------------------------------%
