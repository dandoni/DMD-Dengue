
function figure_tile( N )


if    ( N == 1  ); ll = 1; cc = 1; pp = 0.96;
elseif( N == 2  ); ll = 1; cc = 2; pp = 0.96;
elseif( N <= 4  ); ll = 2; cc = 2; pp = 0.93;
elseif( N <= 6  ); ll = 2; cc = 3; pp = 0.93;
elseif( N <= 8  ); ll = 2; cc = 4; pp = 0.93;
elseif( N <= 9  ); ll = 3; cc = 3; pp = 0.9;
elseif( N <= 12 ); ll = 3; cc = 4; pp = 0.9;
else;              ll = 4; cc = 4; pp = 0.9;
end

S = get( 0, 'screensize' );

% New sizes
Nx = floor( S(3) / cc );
Ny = floor( S(4) / ll );

ii = 0;
jj = 0;

Py = floor( pp * Ny );

% For each figure until N
for ff = 1:N

  figure( ff, 'MenuBar', 'none', 'ToolBar', 'none',
              'position', [ 1+ii*Nx   S(4)-(jj+1)*Ny   Nx   Py ] );

  ii = ii + 1;

  if( ii == cc )
    ii = 0;
    jj = jj + 1;
  end  

end

%------------------------------------------------------------------------------%
