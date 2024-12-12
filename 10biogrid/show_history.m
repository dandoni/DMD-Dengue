
function show_history( X, Tf, Cmax )

N = size( X, 1 );

% If there is more cities than maximum 
if( N > Cmax )
  
  ii = round( linspace( 1, N, Cmax+2 ) );
  X = X( ii(2:end-1), : );

end

T = linspace( 0, Tf, size(X,2) );

plot( T, X', 'b' )
xlim( [0 Tf ] );

grid on

%------------------------------------------------------------------------------%
