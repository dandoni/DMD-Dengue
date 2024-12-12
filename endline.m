
function str = endline( N )

% Return N end of line characters: char(10)
%
% usage: srt = endline( N )
%
% N - Number of end lines (default 1) 
%

  if( nargin == 0 ), str = char(10);
  else,              str = repmat( char(10), 1, N );
  end

end
