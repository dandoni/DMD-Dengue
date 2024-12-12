
function save_biogrid( filename )

global param;

type = 'biogrid';

X = evalin( 'base', 'X' );

save( '-hdf5', [ '../04-data/' filename '.hdf5' ], 'X', 'param', 'type' )

%------------------------------------------------------------------------------%
