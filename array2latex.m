
function tex = array2latex( A, fmt )

% Returns a string with LaTeX code for an array
%
% Usage: tex = array2latex( A, fmt )
%
% A   - An real valued array of any dimension
% fmt - Number formating string (default '%f')
%

  if( nargin == 1 ), fmt = '%f'; end
  
  [ nl nc ] = size( A );
  
  tex = ['\left[' endline '\begin{array}{' repmat( 'r', 1, nc ) '}' endline ];
  
  for   ii = 1:nl, tex = [ tex '      ' sprintf(fmt,A(ii,1 )) ' ' ];
    for jj = 2:nc, tex = [ tex '& '     sprintf(fmt,A(ii,jj)) ' ' ];
    end
    tex = [ tex '\\' endline ];
  end
  
  tex = [ tex '    \end{array}' endline '\right]' endline ];

end
