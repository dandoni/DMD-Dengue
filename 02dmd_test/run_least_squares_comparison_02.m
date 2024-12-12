
function run_least_squares_comparison_02

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_least_squares_comparison_02';
  filename = 'least_squares_comparison_02.tex'; 
  ptitle   = 'DMD Least Squares Comparison -- 02'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  N_snaps = 200;
  N1 = 180;
  N2 = 200;

  D1 = commpute_X( N1, N_snaps );
  D2 = commpute_X( N2, N_snaps );

  tex = least_squares_comparison( tex, D1, D2 );

  close all; 
  latex_compile( tex );

end

%------------------------------------------------------------------------------%
function D = commpute_X( N_places, N_snaps )

  D.N_places = N_places;
  D.N_snaps  = N_snaps;

  % Creating data using a smoothing operator
  %------------------------------------------------------------------%

  H = eye(N_places) + diag( ones(N_places-1,1), 1 ) + diag( ones(N_places-1,1), -1 );
  H = H / 3;

  D.H_lambda = eig( H );
  
  nn = 5;
  ss = 31;
  
  rand( 'seed', ss );

  xi = linspace( 0, 1, nn );
  yi = 0.7 * rand( nn, 1 );
  yi([1 end]) = 0;

  x  = linspace( 0, 1, N_places )';
  p  = interp1( xi, yi, x, 'spline' );

  nn = 4 * nn;
  
  xi = linspace( 0, 1, nn );
  yi = 0.3 * rand( nn, 1 );
  yi([1 end]) = 0;

  p = p + interp1( xi, yi, x, 'spline' );
  p = p - min( p );
  p = p / max( p );

  D.X      = zeros( N_places, N_snaps );
  D.X(:,1) = p';
  
  for jj = 2:N_snaps
    D.X(:,jj) = H * D.X(:,jj-1);
  end
  
  % Computing Least Square approximation
  %------------------------------------------------------------------%
  
  D.pc = 0.99;

  [ D.Xls D.Els A D.S D.r ] = compute_least_squares( D.X, D.pc );

  D.A_lambda = eig( A );

end

%------------------------------------------------------------------------------%
