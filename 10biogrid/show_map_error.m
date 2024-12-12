
function show_map_error( X )

global param;

N = size( X, 2 );

% If there is more snapshots than maximum 
if( N > param.Smax )
  
  P = idivide( N, param.Smax, 'ceil' );
  X = X( :, fliplr( N:-P:1 ) );
  N = param.Smax;

end

A = max( abs(X(:)) );
if( A == 0 ); A = 1; end

dt = param.Tf /( N - 1 );

show_map( X, -A, A, cmap_rwb, 't=%.3f', sprintf('%.8f*(ii-1)',dt) )

%------------------------------------------------------------------------------%
