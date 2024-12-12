
function run_pulse_02

  % Presentation information
  id = '02';
  latex.dir    = [ 'latex_pulse_' id       ];
  latex.file   = [ 'pulse_' id '.tex'      ]; 
  latex.title  = [ 'DMD Pulse Test -- ' id ]; 
  latex.author = 'Luis D''Afonseca';

  % Grid parameters
  param.grid.Lx =  4; % Length in x direction
  param.grid.Ly =  2; % Length in y direction
  param.grid.Tf =  2; % Total time
  param.grid.Nx = 80; % Number of grid points in x direction
  param.grid.Ny = 60; % Number of grid points in y direction
  param.grid.Nt = 40; % Number of snapshots

  param.maxNt = 0; % Maximum number of snapshots to be added to presentation

  % Percentage of Energy 
  param.pc = 0.95;

  % 1 - Pulse parameters
  param.P{1}.pulse  = 'gaussian';
  param.P{1}.Xo     = 1.5;
  param.P{1}.Yo     = 1.3;
  param.P{1}.radius = 0.7;
  param.P{1}.freq   = 2;
  param.P{1}.phase  = pi/3;
  param.P{1}.ampl   = 1;
  param.P{1}.grow   = 0;

  % 2 - Pulse parameters
  param.P{2}.pulse  = 'square';
  param.P{2}.Xo     = 2.5;
  param.P{2}.Yo     = 1.5;
  param.P{2}.radius = 0.3;
  param.P{2}.freq   = 4;
  param.P{2}.phase  = pi/5;
  param.P{2}.ampl   = 1;
  param.P{2}.grow   = -2;

  build_pulse( latex, param );

%------------------------------------------------------------------------------%
