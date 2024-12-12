
function C = cmap_rwb( N )

% Produces a color map from red to white and blue

if( nargin == 0 ), N = 64; end;

R = [ 1     0.3   0.3 ]; % Red
W = [ 1     1     1   ]; % White
B = [ 0.1   0.1   1   ]; % Blue

C = zeros( N, 3 );

H = floor( N / 2 );

C(      1:  H,:) = linspace( R, W, H )';
C(end-H+1:end,:) = linspace( W, B, H )';

if( rem( N, 2 ) ), C(H+1,:) = W; end

