
function show_biogrid( X, Amin, Amax, cmap, label, val )

global param;

N = min( 16, size( X, 2 ) );

if    ( N == 1  ); ll = 1; cc = 1;
elseif( N == 2  ); ll = 1; cc = 2;
elseif( N == 3  ); ll = 1; cc = 3;
elseif( N == 4  ); ll = 2; cc = 2;
elseif( N <= 6  ); ll = 2; cc = 3;
elseif( N <= 8  ); ll = 2; cc = 4;
elseif( N <= 9  ); ll = 3; cc = 3;
elseif( N <= 12 ); ll = 3; cc = 4;
else;              ll = 4; cc = 4;
end

clf

if( Amin == Amax )
  Amin = Amin -1;
  Amax = Amin +1;
end

for ii = 1:N

  I = reshape( X(:,ii), param.Nx, param.Ny )';
  if( param.interpolate ); I = interp2( I, 2 ); 
  end

  if( N > 1 ), subplot( ll, cc, ii ); end

  colormap( cmap );
  image( I, 'cdatamapping', 'scaled' );
  set( gca, 'xtick', [], 'ytick', [] )
  axis square
  caxis([ Amin Amax ])
  xlabel( sprintf( label, eval(val) ) )
  
end

if( param.colorbar ) 
  P = get( gca, 'position' );
  colorbar
  set( gca, 'position', P );
end

%------------------------------------------------------------------------------%
