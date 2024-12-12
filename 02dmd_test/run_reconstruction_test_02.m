
function run_reconstruction_test_02

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_reconstruction_test_02';
  filename = 'reconstruction_test_02.tex'; 
  ptitle   = 'DMD Reconstruction Test -- 02'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Introduction' );

  N_places = 180;
  N_snaps  = 200;
  percent  = 0.99;
  
  content = [ 'Dataset construction \[x_{n+1} = H\; x_n\] where $H$ is a moving average operator with window of 3 elements' endline ];
  content = [ content '\begin{itemize}' endline];
  content = [ content '\item $x_1$ is random noise' endline(2) ];
  content = [ content '\item ' sprintf( 'The dataset has %d positions and %d snapshots', N_places, N_snaps ) endline(2) ];
  content = [ content '\end{itemize}' endline];

  tex = latex_add_content( tex, 'Dataset Model', content );

%------------------------------------------------------------------------------%

  [ H X ] = commpute_X( N_places, N_snaps );

  tex = reconstruction_test( tex, X, percent, H );

%------------------------------------------------------------------------------%

  close all; 
  latex_compile( tex );

end

%------------------------------------------------------------------------------%
function [ H X ] = commpute_X( N_places, N_snaps )

  % Build H as a smoothing operator
  %---------------------------------------------------------------------%

  H = eye(N_places) + diag( ones(N_places-1,1), 1 ) + diag( ones(N_places-1,1), -1 );
  H = H / 3;

  % Build x_1
  %---------------------------------------------------------------------%

  rand( 'seed', 13 );
  
  nn = 5;

  ti = linspace( 0, 1, nn );
  yi = 0.7 * rand( nn, 1 );
  yi([1 end]) = 0;

  t = linspace( 0, 1, N_places )';
  p = interp1( ti, yi, t, 'spline' );

  nn = 4 * nn;
  
  ti = linspace( 0, 1, nn );
  yi = 0.3 * rand( nn, 1 );
  yi([1 end]) = 0;

  p = p + interp1( ti, yi, t, 'spline' );
  p = p - min( p );
  p = p / max( p );

  % Build X using x_{n+1} = H x_n
  %---------------------------------------------------------------------%

  X = zeros( N_places, N_snaps );
  X(:,1) = p/2 +  0.3 * rand( N_places, 1 );

  for jj = 2:N_snaps
    X(:,jj) = H * X(:,jj-1);
  end

  X = X / max(X(:));

end

%------------------------------------------------------------------------------%
