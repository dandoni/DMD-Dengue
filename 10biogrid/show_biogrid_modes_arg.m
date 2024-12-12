
function show_biogrid_modes_arg( M )

global param;

N = min( param.Mmax, size( M, 2 ) );
X = arg( M(:,1:N) );

A = max(abs(X(:)));
if( A == 0 ); A = 1; end

show_biogrid( X, -A, A, cmap_rwb, 'arg(mode %2i)', 'ii' )

%------------------------------------------------------------------------------%
