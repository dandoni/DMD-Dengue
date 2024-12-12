
function C = cmap_cyan2red( N )

% CYAN2BLACK Colormap function ranges from cyan to black
%
% Luis Alberto D'Afonseca
% since: Nov, 17, 2003

%------------------------------------------------------------------------------%

if( nargin == 0 ), N = 64; end;

a = floor( N / 2 );
b = N - a;

A = linspace( 1, 0, a )';
B = linspace( 1, 0, b )';

C = zeros( N ,3 );

% From cyan to blue
C( 1:a, 2 ) = A;
C( 1:a, 3 ) = 1;

% From blue to red
C( a+1:N, 1 ) = flipud(B);
C( a+1:N, 3 ) = B;

%------------------------------------------------------------------------------%
