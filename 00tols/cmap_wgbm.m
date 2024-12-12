
function C = cmap_wgbm( N )

% Produces a color map from white to gray to blue and magenta

if( nargin == 0 ), N = 64; end;

C = zeros( N, 3 );

W = [ 1     1     1   ]; % White
G = [ 0.5   0.5   0.8 ]; % Gray
B = [ 0.1   0.1   1   ]; % Blue
K = [ 0.9   0.0   0.9 ]; % Magenta

A = floor( N / 5 );  H = N - 5 * A;
P = floor( H / 2 );  Q = H - P + 1;

C(      1 : (2*A+P), : ) = linspace( W, G, 2*A+P )';
C( (2*A+P): (4*A+H), : ) = linspace( G, B, 2*A+Q )';
C( (4*A+H): end,     : ) = linspace( B, K,   A+1 )';

%------------------------------------------------------------------------------%
