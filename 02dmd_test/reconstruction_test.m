
function tex = reconstruction_test( tex, X, pc, H )

% Create a presentation showing the DMD reconstruction of a data set
%
% Usage:
%   tex = reconstruction_test( tex, X, pc, H )
%
% tex - LaTeX presentation
% X  - Dataset
% pc - Percentage of information to select sigular values
% H  - Optional - Marix used to create X
%

  % Is H matrix has been provided
  if( nargin == 4 ); H_lambdas = eig(H); 
  else;              H_lambdas = [];
  end

  %------------------------------------------------------------------------------%

  content = [ '\begin{itemize}'                                                                                                     endline    ];
  content = [ content '\item $X  =[\;x_1\; x_2\; \dots\; x_{n-1}\;]$'                                                               endline(2) ];
  content = [ content '\item $X''=[\;x_2\; x_2\; \dots\; x_n    \;]$'                                                               endline(2) ];
  content = [ content '\item $U \Sigma V^{*}\quad$ is the SVD decomposition of $X$'                                                 endline    ];
  content = [ content '\item $\tilde{U} \tilde{\Sigma} \tilde{V}^{*}\quad$ is the $r\times r$ truncated SVD of $X$'                 endline    ];
  content = [ content '\item $\tilde{A}_{r\times r} = \tilde{U}^{*} A \tilde{U} = \tilde{U}^{*} X'' \tilde{V} \tilde{\Sigma}^{-1}$' endline    ];
  content = [ content '\item $\phi_i = X'' \tilde{V} \tilde{\Sigma}^{-1} \omega_i\quad\,$ are the dynamic modes'                    endline    ];
  content = [ content '\item $\tilde{A}\omega_i = \lambda_i\omega_i$'                                                               endline    ];
  content = [ content '\end{itemize}'                                                                                               endline    ];

  tex = latex_add_content( tex, 'DMD', content );

  % Computing DMD 
  %------------------------------------------------------------------------------%

  [ N_places N_snaps ] = size( X );

  [ modes A_lambdas sigmas r ] = compute_dmd( X, pc );

  [ X_dmd E_dmd ] = compute_dmd_reconstruction( X, modes, A_lambdas );

  %------------------------------------------------------------------------------%

  X_dmd_full = squeeze( X_dmd(:,:,end) );
  E_dmd_full = squeeze( E_dmd(:,:,end) );
  E_snap = max( abs( E_dmd_full ) );
  slim = [ max([1e-15 min(E_snap(:))]) min([1e15 max(E_snap(:))]) ];

  xlim = [ 0 1 ];
  elim = 0.2 * max(abs( E_dmd(:) )) * [-1 1];

  xmap = jet(256); % cmap_gtex;
  emap = cmap_rgrayb;

  %------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Dataset' );

  tex = show_reconstruction_snapshots( tex, X, xlim );
  tex = show_reconstruction_history  ( tex, X );

  tex = latex_add_section( tex, 'Reconstruction' );

  tex = show_reconstruction_X( tex, X,          xlim, xmap, 'Dataset',                  'fig_X'     );
  tex = show_reconstruction_X( tex, X_dmd_full, xlim, xmap, 'DMD Reconstruction',       'fig_X_dmd' );
  tex = show_reconstruction_X( tex, E_dmd_full, elim, emap, 'DMD reconstruction Error', 'fig_E_dmd' );

  tex = show_reconstruction_E_snap( tex, E_snap, slim, 'Error by Snapshot', 'fig_E_snap' );

  tex = latex_add_section( tex, 'Singular Values and Eigenvalues' );

  tex = show_reconstruction_singular_values( tex, sigmas, r, pc );

  tex = show_reconstruction_eigenvalues( tex, A_lambdas, H_lambdas, N_snaps );

  tex = latex_add_section( tex, 'Dynamical Modes' );

  tex = show_reconstruction_modes( tex, modes );

  %------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Mode by Mode Reconstruction' );

  content = [ 'Projection of fisrt snapshot on dynamic modes' endline ];
  content = [ content '\[ x_1 \approx \sum_{i=1}^{r} a_i\,\phi_i \]' endline ];
  content = [ content 'Reconstruction by dynamic modes' endline ];
  content = [ content '\[ x_n \approx \sum_{i=1}^{r} a_i\, \lambda_i^n\, \phi_i \]' endline ];
  content = [ content 'Partial Reconstructions by dynamic modes' endline ];
  content = [ content '\[ x_n \approx \sum_{i=1}^{R} a_i\, \lambda_i^n\, \phi_i \qquad\qquad R=1,\dots,r \]' endline ];

  tex = latex_add_content( tex, 'DMD Reconstruction', content );

  elim = max(abs( E_dmd(:) )) * [-1 1];
  tex = show_reconstruction           ( tex, X_dmd, xlim, xmap );
  tex = show_reconstruction_error     ( tex, E_dmd, elim, emap );
  tex = show_reconstruction_error_snap( tex, E_dmd );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_snapshots( tex, X, xlim )

  [ N_places N_snaps ] = size( X );
  nn = resample_index( N_snaps, 5 );

  tt = linspace( 0, 1, N_places );
  
  for ii = nn 

    clf
    plot( tt, X(:,ii), 'b' ); axis([ 0 1 xlim ]); grid on;

    xlabel('Position')
    ylabel( sprintf( '$x_{%d}$', ii ) )

    tex = latex_add_fig( tex, sprintf( 'Snapshot %3d',  ii ), sprintf( 'fig_snap_%03d', ii ) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_history( tex, X )

  clf

  [ N_places N_snaps ] = size( X );

  show_history( X, N_snaps, 9 );
  ylabel('Data on some places')
  xlabel('Snapshots')

  tex = latex_add_fig( tex, 'History', 'fig_hist' );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_X( tex, X, clim, cmap, stitle, fname )

  clf
  image( X, 'cdatamapping', 'scaled' );
  colormap( gca, cmap );
  caxis( clim )
  colorbar;

  xlabel('Snapshot')
  ylabel('Position')

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_E_snap( tex, E, slim, stitle, fname )
  
  clf

  E( E <=0 ) = NaN;

  semilogy( E, 'linewidth', 1.5 ) 
  latex_semilogy_annotations;

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_singular_values( tex, S, r, pc )

  clf

  show_singular_values( S, pc );
  axis([1 length(S) 1e-20 2e2])
  latex_semilogy_annotations([-20 -15 -10 -5 -1 2]);

  title( sprintf( '%d singular value(s) selected to obtain %.2f\\%% of energy', r, 100*pc ) );

  tex = latex_add_fig( tex, 'Singular Values', 'fig_sing_values' );

  clf
  show_cumulative_energy( S, pc );
  tex = latex_add_fig( tex, 'Cumulative Energy', 'fig_cum_energy' );

end 

%------------------------------------------------------------------------------%
function tex = show_reconstruction_eigenvalues( tex, A_lambdas, H_lambdas, N_snaps )

  % Selecting non-negative imaginary egenvalues
  H_l = H_lambdas( find( imag(H_lambdas) > -eps ) );
  A_l = A_lambdas( find( imag(A_lambdas) > -eps ) );

  lmax = ceil(max(abs([ A_l; H_l ]))) + 1;
 
  tex = show_reconstruction_eigenvalues_complex( tex, H_l, lmax, 'Eigenvalues of Model Matrix',   'fig_eig_H' );
  tex = show_reconstruction_eigenvalues_complex( tex, A_l, lmax, 'Eigenvalues of Reduced Matrix', 'fig_eig_A' );

  dt = 1 / N_snaps;

  H_freq = compute_frequency( H_l, dt );
  A_freq = compute_frequency( A_l, dt );
  L_freq = fit_axis_limits([ H_freq; A_freq ]);

  H_real = real( H_l );
  A_real = real( A_l );
  L_real = fit_axis_limits([ H_real; A_real ]);

  tex = show_reconstruction_eigenvalues_real_freq( tex, H_real, H_freq, L_real, L_freq, 'Eigenvalues of Model Matrix',   'fig_eig_H_real' );
  tex = show_reconstruction_eigenvalues_real_freq( tex, A_real, A_freq, L_real, L_freq, 'Eigenvalues of Reduced Matrix', 'fig_eig_A_real' );

  H_imag = imag( H_l );
  A_imag = imag( A_l );
  L_imag = fit_axis_limits([ H_imag; A_imag ]);

  tex = show_reconstruction_eigenvalues_imag_freq( tex, H_imag, H_freq, L_imag, L_freq, 'Eigenvalues of Model Matrix',   'fig_eig_H_imag' );
  tex = show_reconstruction_eigenvalues_imag_freq( tex, A_imag, A_freq, L_imag, L_freq, 'Eigenvalues of Reduced Matrix', 'fig_eig_A_imag' );
  
  H_abs = abs( H_l );
  A_abs = abs( A_l );
  L_abs = fit_axis_limits([ 0; H_abs; A_abs ]);

  tex = show_reconstruction_eigenvalues_abs_freq( tex, H_abs, H_freq, L_abs, L_freq, 'Eigenvalues of Model Matrix',   'fig_eig_H_abs' );
  tex = show_reconstruction_eigenvalues_abs_freq( tex, A_abs, A_freq, L_abs, L_freq, 'Eigenvalues of Reduced Matrix', 'fig_eig_A_abs' );
  
  H_arg = arg( H_l );
  A_arg = arg( A_l );
  L_arg = [ -pi pi ];

  tex = show_reconstruction_eigenvalues_arg_freq( tex, H_arg, H_freq, L_arg, L_freq, 'Eigenvalues of Model Matrix',   'fig_eig_H_arg' );
  tex = show_reconstruction_eigenvalues_arg_freq( tex, A_arg, A_freq, L_arg, L_freq, 'Eigenvalues of Reduced Matrix', 'fig_eig_A_arg' );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_eigenvalues_complex( tex, lambdas, lmax, stitle, fname )

  if( isempty(lambdas) ); return; end

  clf

  show_lambda_complex( lambdas, 10 );

  ticks = linspace( -lmax, lmax, min( 2*lmax+1, 5 ) );
  axis([-lmax lmax -lmax lmax])
  set(gca, 'xtick', ticks, 'ytick', ticks ); 

  N = length( find( abs(lambdas) > eps ) );
  title( sprintf('Non-null eigenvalues: %d', N ) );

  tex = latex_add_fig( tex, stitle, fname );

end


%------------------------------------------------------------------------------%
function tex = show_reconstruction_eigenvalues_real_freq( tex, V, F, vlim, flim, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );
  
  plot_bar( F(ii), V(ii), 'k', F(jj), V(jj), 'b' );
  hold on
  plot( flim, [ 0 0 ], 'k' ); 
  hold off
  grid on
  axis([ flim vlim ])
  title('$\text{real}(\lambda_i)$'); 
  xlabel('Frequency') 

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_eigenvalues_imag_freq( tex, V, F, vlim, flim, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );
  
  plot_bar( F(ii), V(ii), 'k', F(jj), V(jj), 'b' );
  hold on
  plot( flim, [ 0 0 ], 'k' ); 
  hold off
  grid on
  axis([ flim vlim ])
  title('$\text{imag}(\lambda_i)$'); 
  xlabel('Frequency') 

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_eigenvalues_abs_freq( tex, V, F, vlim, flim, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );
  
  plot_bar( F(ii), V(ii), 'k', F(jj), V(jj), 'b' );
  hold on
  plot( flim, [ 0 0 ], 'k' ); 
  hold off
  grid on
  axis([ flim vlim ])
  title('$|\lambda_i|$'); 
  xlabel('Frequency') 

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_eigenvalues_arg_freq( tex, V, F, vlim, flim, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );
  
  plot_bar( F(ii), V(ii), 'k', F(jj), V(jj), 'b' );
  hold on
  plot( flim, [ 0 0 ], 'k' ); 
  hold off
  grid on
  axis([ flim vlim ])
  latex_ticklabel_radian( 'y', 0.5 );
  title('$\text{arg}(\lambda_i)$'); 
  xlabel('Frequency') 

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_modes( tex, modes )

  clf

  [ n_places n_snaps ] = size(modes);

  m_real = real( modes );  rmax   = max( m_real(:) );  rmin = min( m_real(:) );
  m_imag = imag( modes );  imax   = max( m_imag(:) );  imin = min( m_imag(:) );
  m_abs  = abs ( modes );  absmax = max( m_abs (:) );
  m_arg  = arg ( modes );  argmin = min( m_arg (:) );
  
  if( rmin < rmax ), rlim   = [ rmin rmax 1 n_places ]; else, rlim   = [ rmax-1 rmax+1 1 n_places ]; end
  if( imin < imax ), ilim   = [ imin imax 1 n_places ]; else, ilim   = [ imax-1 imax+1 1 n_places ]; end
  if( argmin < 0  ), arglim = [ -pi  pi   1 n_places ]; else, arglim = [      0     pi 1 n_places ]; end

  abslim = [ 0 absmax 1 n_places ];
  
  tt = 1:n_places;
  
  for ii = 1:n_snaps

    subplot( 1, 4, 1 )
    plot( m_real(:,ii), tt );
    axis( rlim )
    grid on
    title( sprintf('$\\text{real}(\\phi_{%d})$',ii) );
    xtick = get( gca, 'xtick' );
    aa = xtick(1);
    bb = xtick(end);
    if( aa*bb < 0 ), xtick = [ aa 0 bb ]; else, xtick = [ aa bb ]; end 
    set( gca, 'ydir', 'reverse', 'xtick', xtick );

    subplot( 1, 4, 2 )
    plot( m_imag(:,ii), tt )
    axis( ilim )
    grid on
    title( sprintf('$\\text{imag}(\\phi_{%d})$',ii) );
    xtick = get( gca, 'xtick' );
    aa = xtick(1);
    bb = xtick(end);
    if( aa*bb < 0 ), xtick = [ aa 0 bb ]; else, xtick = [ aa bb ]; end 
    set( gca, 'ydir', 'reverse', 'xtick', xtick );

    subplot( 1, 4, 3 )
    plot( m_abs(:,ii), tt )
    axis( abslim )
    grid on
    title( sprintf('$\\text{abs}(\\phi_{%d})$',ii) );
    xtick = get( gca, 'xtick' );
    set( gca, 'ydir', 'reverse', 'xtick', xtick([1 end]) );

    subplot( 1, 4, 4 )
    plot( m_arg(:,ii), tt )
    axis( arglim )
    grid on
    title( sprintf('$\\text{arg}(\\phi_{%d})$',ii) );
    latex_ticklabel_radian( 'y', 0.5 );
    set( gca, 'ydir', 'reverse' );

    tex = latex_add_fig( tex, sprintf('Dynamic Mode %02d',ii), sprintf('fig_mode_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction( tex, X, clim, cmap )

  N = size( X, 3 );

  for ii = 1:N

    clf
    image( squeeze(X(:,:,ii)), 'cdatamapping', 'scaled' );
    colormap( gca, cmap );
    caxis( clim )
    colorbar;

    tex = latex_add_fig( tex, sprintf('Reconstruction with Modes $r=1:%2d$',ii), sprintf('fig_recons_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_error( tex, E, clim, cmap )

  N = size( E, 3 );

  for ii = 1:N

    clf
    image( squeeze(E(:,:,ii)), 'cdatamapping', 'scaled' );
    colormap( gca, cmap );
    caxis( clim )
    colorbar;

    tex = latex_add_fig( tex, sprintf('Error with Modes $r=1:%2d$',ii), sprintf('fig_recons_error_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_reconstruction_error_snap( tex, E_dmd )

  E = max( abs( E_dmd ), [], 1 );
  clim = [ max([1e-15 min(E(:))]) min([1e15 max(E(:))]) ];

  N = size( E, 3 );

  for ii = 1:N

    clf

    E_snap = squeeze(E(:,:,ii));

    tex = show_reconstruction_E_snap( tex, E_snap, clim, sprintf('Error by Snapshot with Modes $r=1:%2d$',ii), sprintf('fig_recons_error_snap_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%

