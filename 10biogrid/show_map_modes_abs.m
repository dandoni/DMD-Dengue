
function show_map_modes_abs( M )

global param;

N = min( param.Mmax, size( M, 2 ) );
X = abs( M(:,1:N) );

A = max(abs(X(:)));
if( A == 0 ); A = 1; end

show_map( X, 0, A, cmap_wgbm, 'abs(mode %2i)', 'ii' )

%------------------------------------------------------------------------------%
