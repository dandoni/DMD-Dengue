
function map_load( filename )

% Load a map from grayscale image file

global param;

%------------------------------------------------------------------------------%

% Load map from grayscale image file and convert to array of doubles
param.map = 1 - im2double( imread( filename ) )';

param.Nx = size( param.map, 1 );
param.Ny = size( param.map, 2 );

% Map index and support 
param.map_id = find( param.map(:) > eps );
param.N      = length( param.map_id );

%------------------------------------------------------------------------------%
