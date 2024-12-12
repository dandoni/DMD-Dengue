
function tex = latex_add_preamble( tex, content )

% Add content to preamble of LaTeX file
%
% Usage:  tex = latex_add_preamble( tex, content )
%

  if( nargin <  2 )
    error( 'missing parameters!' );
  end

  if( ischar( content ) )

    new_content = [ content endline(2) ];

  elseif( iscellstr( content ) && isvector( content ) )

    new_content = [ var2latex( content ) endline ];
  
  else
    error('content must be a string or a cell string with only one dimension!')
  
  end

  tex.latex = strrep( tex.latex, '\begin{document}', [ new_content '\begin{document}' ] );

end
