
function show_biogrid_data( X )

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

dt = param.Tf / ( N - 1 );

show_biogrid( X, 0, A, cmap_wgbm, 't=%s', sprintf('%.8f*(ii-1)',dt) )

%------------------------------------------------------------------------------%
