
function figure_tile_biogrid

S = get( 0, 'screensize' );

% Snapshot like figures
%------------------------------------------------------------------------------%

Nx = floor( S(3) / 3 );
Ny = floor( S(4) / 3 );
Py = floor( 0.9 * Ny );

ll = 3;
cc = 3;
ii = 0;
jj = 0;

for ff = 1:6

  figure( ff, 'MenuBar', 'none', 'ToolBar', 'none',
              'position', [ 1+ii*Nx   S(4)-(jj+1)*Ny   Nx   Py ] );

  jj = jj + 1;

  if( jj == 2 )
    jj = 0;
    ii = ii + 1;
  end  

end

% Plot like figures
%------------------------------------------------------------------------------%

Nx = floor( S(3) / 4 );

for ff = 0:3

  figure( 7+ff, 'MenuBar', 'none', 'ToolBar', 'none',
                'position', [ 1+ff*Nx   S(4)-3*Ny   Nx   Py ] );

end

%------------------------------------------------------------------------------%
