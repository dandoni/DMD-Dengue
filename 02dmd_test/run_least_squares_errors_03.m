
function run_least_squares_errors_03

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_least_squares_errors_03';
  filename = 'least_squares_errors_03.tex'; 
  ptitle   = 'DMD Least Squares Errors -- 03'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  pc = 0.999;

  % Number of snapshots
  N_snaps = 200;

  % Number of places  
  N = 10:10:400;
  
  nn = length(N);
  
  % Maximum reconstruction error
  E = zeros(nn,1);

  % Largest and smallest eigenvalues
  H_L_max = zeros(nn,1);
  H_L_min = zeros(nn,1);
  A_L_max = zeros(nn,1);
  A_L_min = zeros(nn,1);
  
  for ii = 1:nn
  
    N_places = N(ii);
    
    % Smoothing
    H = eye(N_places) + diag( ones(N_places-1,1), 1 ) + diag( ones(N_places-1,1), -1 );
    H = H / 3;

    L = eig( H );
    H_L_max(ii) = max( abs(L) );
    H_L_min(ii) = min( abs(L) );
    
    X      = zeros( N_places, N_snaps );
    X(:,1) = 1 - linspace(-1,1,N_places).^2;
    
    for jj = 2:N_snaps
      X(:,jj) = H * X(:,jj-1);
    end
  
    % Computing Least Square approximation
    %------------------------------------------------------------------%
    
    [ X_ls E_ls A S r ] = compute_least_squares( X, pc );

    % Eigenvalues
    L = eig( A );
    A_L_max(ii) = max( abs(L) );
    A_L_min(ii) = min( abs(L) );
    
    % Error
    E(ii) = max( 1e-20, max( abs( E_ls(:) ) ) );
  
  end
  
%------------------------------------------------------------------------------%

  clf

  semilogy( N, E ) 
  latex_semilogy_annotations;

  xlabel( 'Number of places' )
  ylabel( 'Maximum Error'    )
  title ( sprintf( 'pc = %.5f', pc ) )

  tex = latex_add_fig( tex, 'Maximum Reconstruction Error', 'fig_E' );
  
%------------------------------------------------------------------------------%

  H_L_max( H_L_max <= 0 ) = NaN;
  H_L_min( H_L_min <= 0 ) = NaN;
  A_L_max( A_L_max <= 0 ) = NaN;
  A_L_min( A_L_min <= 0 ) = NaN;

  clf
  semilogy( N, H_L_min, 'b', N, H_L_max, 'b' ) 
  ylim([ 1e-20 10 ])
  latex_semilogy_annotations([-15 -10 -5 1 0 1]);

  tex = latex_add_fig( tex, 'Smallest and Largest Eigenvalues of $H$', 'fig_H_L' );

  clf
  semilogy( N, A_L_min, 'b', N, A_L_max, 'b' ) 
  ylim([ 1e-20 10 ])
  latex_semilogy_annotations([-15 -10 -5 1 0 1]);

  tex = latex_add_fig( tex, 'Smallest and Largest Eigenvalues of $A$', 'fig_A_L' );

%------------------------------------------------------------------------------%

  close all; 
  latex_compile( tex );

end
%------------------------------------------------------------------------------%
