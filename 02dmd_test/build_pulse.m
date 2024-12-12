
function build_pulse( latex, param )

close all
run '../startup'

  % Creating the latex directory
  tex = latex_create( latex.dir, latex.file, latex.title, latex.author, 'beamer', 'en' );

  figure_position(1,2,2,2);

%------------------------------------------------------------------------------%

  N = length( param.P );

  content = [ '\centering \begin{tabular}{cccccc} \hline' endline ];
  content = [ content 'Pulse & $x_0$ & $y_0$ & Frequency & Phase ($\times\pi$) & Grow \\ \hline' endline ]; 

  for ii = 1:N
    pp = param.P{ii}.pulse;
    xo = num2str( param.P{ii}.Xo      );
    yo = num2str( param.P{ii}.Yo      );
    ff = num2str( param.P{ii}.freq    );
    rr = rats( param.P{ii}.phase / pi );
    gg = num2str( param.P{ii}.grow    );

    content = [ content pp ' & ' xo  ' & ' yo ' & ' ff ' & ' rr  ' & ' gg ' \\' endline ]; 
  end

  content = [ content '\hline \end{tabular}' endline ];

  tex = latex_add_content( tex, ['Model Test with ' int2str(N) ' Pulses'], content );

%------------------------------------------------------------------------------%

  Tf = num2str(param.grid.Tf); 
  Nt = int2str(param.grid.Nt); 
  Nx = int2str(param.grid.Nx); 
  Ny = int2str(param.grid.Ny); 
  Lx = num2str(param.grid.Lx); 
  Ly = num2str(param.grid.Ly); 
  pc = num2str(100*param.pc); 

  content = [ '\begin{tabular}{lc}'                                   endline ];
  content = [ content 'Total time        & ' Tf ' s'            ' \\' endline ];
  content = [ content 'Snapshots         & ' Nt                 ' \\' endline ];
  content = [ content 'Grid size         & ' Nx ' $\times$ ' Ny ' \\' endline ];
  content = [ content 'Domain size       & ' Lx ' $\times$ ' Ly ' \\' endline ];
  content = [ content 'Energy Percentage & ' pc ' \%'           ' \\' endline ];
  content = [ content '\end{tabular}'                                 endline ];

  tex = latex_add_content( tex, 'Discretization', content );

%------------------------------------------------------------------------------%

  param.grid.dt = param.grid.Tf / ( param.grid.Nt - 1 );

  % Build dataset
  X = build_pulse_data( param );

  % Compute DMD and DMD reconstruction
  [ modes lambdas sigmas r ] = compute_dmd    ( X, param.pc );
  [ X_dmd E_dmd ] = compute_dmd_reconstruction( X, modes, lambdas );

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Dataset' );
  tex = show_data( tex, param.grid, X );

%------------------------------------------------------------------------------%

  if( param.maxNt > 0 )
    tex = latex_add_section( tex, 'Snapshots' );
    tex = show_snapshots( tex, param.grid, X, param.maxNt );
  end

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Eigenvalues and Singular Values' );
  tex = show_pulse_singular_values( tex, sigmas, r, param.pc );
  tex = show_pulse_eigenvalues    ( tex, param.grid, lambdas    );

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Dynamical Modes' );
  tex = show_modes_real( tex, param.grid, modes, lambdas );
  tex = show_modes_imag( tex, param.grid, modes, lambdas );
  tex = show_modes_abs ( tex, param.grid, modes, lambdas );
  tex = show_modes_arg ( tex, param.grid, modes, lambdas );

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Dataset Reconstruction' );
  tex = show_pulse_dataset_reconstruction      ( tex, X_dmd );
  tex = show_pulse_dataset_reconstruction_error( tex, E_dmd );

%------------------------------------------------------------------------------%

  if( param.maxNt > 0 )
    tex = latex_add_section( tex, 'Snapshot Reconstruction' );
    tex = show_pulse_reconstruction      ( tex, param.grid, X_dmd );
    tex = show_pulse_reconstruction_error( tex, param.grid, E_dmd );
  end

%------------------------------------------------------------------------------%

  close all; 
  latex_compile( tex );

end

%------------------------------------------------------------------------------%
function X = build_pulse_data( param )

  X = zeros( param.grid.Nx * param.grid.Ny, param.grid.Nt );

  for ii = 1:length( param.P )
    switch( param.P{ii}.pulse )
      case 'gaussian', X = X + pulse_gaussian( param.grid, param.P{ii} );
      case 'square',   X = X + pulse_square  ( param.grid, param.P{ii} );
      case 'circle',   X = X + pulse_circle  ( param.grid, param.P{ii} );
    end
  end

  X = X ./ max(abs(X(:)));

end

%------------------------------------------------------------------------------%
function A = pulse_amplitude( G, P )
  
  tt = linspace( 0, G.Tf, G.Nt );

  alpha = 2 * pi * P.freq * tt + P.phase;

  A = P.ampl * exp( P.grow * tt ) .* sin( alpha );

end

%------------------------------------------------------------------------------%
function X = pulse_gaussian( G, P )

  xx = ( linspace( 0, G.Lx, G.Nx ) - P.Xo ).^2 / P.radius^2;
  yy = ( linspace( 0, G.Ly, G.Ny ) - P.Yo ).^2 / P.radius^2;

  [ XX YY ] = meshgrid( xx, yy );

  pulse = exp( -XX-YY );
  ampl  = pulse_amplitude( G, P );

  X = repmat( ampl, G.Nx*G.Ny, 1 ) .* repmat( pulse(:), 1, G.Nt );

end

%------------------------------------------------------------------------------%
function X = pulse_square( G, P )

  xx = abs( linspace( 0, G.Lx, G.Nx ) - P.Xo ) < P.radius;
  yy = abs( linspace( 0, G.Ly, G.Ny ) - P.Yo ) < P.radius;

  [ XX YY ] = meshgrid( xx, yy );

  pulse = XX .* YY;
  ampl  = pulse_amplitude( G, P );

  X = repmat( ampl, G.Nx*G.Ny, 1 ) .* repmat( pulse(:), 1, G.Nt );

end

%------------------------------------------------------------------------------%
function X = pulse_circle( G, P )

  xx = ( linspace( 0, G.Lx, G.Nx ) - P.Xo ).^2;
  yy = ( linspace( 0, G.Ly, G.Ny ) - P.Yo ).^2;

  [ XX YY ] = meshgrid( xx, yy );

  pulse = ( XX + YY ) < P.radius^2;
  ampl  = pulse_amplitude( G, P );

  X = repmat( ampl, G.Nx*G.Ny, 1 ) .* repmat( pulse(:), 1, G.Nt );

end

%------------------------------------------------------------------------------%
function tex = show_data( tex, G, X )

  clf

  xx = linspace( 0, G.Tf, G.Nt );
  yy = 1:(G.Nx*G.Ny);

  image( xx, yy, X, 'cdatamapping', 'scaled' );
  caxis([-1 1])
  colormap( cmap_rgrayb(255) )
  colorbar
  xlabel('Time')
  ylabel('Position')

  tex = latex_add_fig( tex, 'Dataset', 'fig_dataset' );

end

%------------------------------------------------------------------------------%
function tex = show_pulse_singular_values( tex, sigmas, r, pc )

  clf
  show_singular_values( sigmas, pc );
  axis([ 1 length(sigmas) 1e-20 1e2 ])
  latex_semilogy_annotations([-20 -15 -10 -5 -1 2]);

  tex = latex_add_fig( tex, 'Singular Values', 'fig_sing_values' );

  clf
  show_cumulative_energy( sigmas, pc );

  tex = latex_add_fig( tex, 'Cumulative Energy', 'fig_cum_energy' );

end

%------------------------------------------------------------------------------%
function tex = show_snapshots( tex, G, X, maxNt )

  clf

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );
  t = linspace( 0, G.Tf, G.Nt );

  T = resample_index( G.Nt, maxNt );

  for ii = 1:length(T)

    snap = reshape( X(:,T(ii)), G.Ny, G.Nx );

    image( x, y, snap, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([-1 1])
    colormap( cmap_rgrayb(255) )
    colorbar

    tex = latex_add_fig( tex, sprintf( 'Snapshot at $t_{%d}=%.3f$', T(ii), t(T(ii)) ), 
                              sprintf( 'fig_snap_%03d', ii ) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_modes_real( tex, G, modes, lambdas )

  clf
  
  [ n_places n_modes ] = size(modes);

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );

  fr = compute_frequency( lambdas, G.dt );

  V    = real( modes );
  vmax = max( abs(V(:)) ); 
  if( vmax == 0 ), vmax = 1; end
  
  for ii = 1:n_modes

    M = reshape( V(:,ii), G.Ny, G.Nx );

    image( x, y, M, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([ -vmax vmax ])
    colormap( cmap_rgrayb(255) )
    colorbar

    title(['$\lambda_{' int2str(ii) '}=' num2str(lambdas(ii)) '\qquad\qquad \text{Freq }=' num2str(fr(ii)) '$' ]);

    tex = latex_add_fig( tex, 
               sprintf('Dynamic Mode -- Real Part $\\quad\\text{real }(\\phi_{%d})$',ii), 
	       sprintf('fig_mode_real_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_modes_imag( tex, G, modes, lambdas )

  clf
  
  [ n_places n_modes ] = size(modes);

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );

  fr = compute_frequency( lambdas, G.dt );

  V    = imag( modes );
  vmax = max( abs(V(:)) ); 
  if( vmax == 0 ), vmax = 1; end
  
  for ii = 1:n_modes

    M = reshape( V(:,ii), G.Ny, G.Nx );

    image( x, y, M, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([ -vmax vmax ])
    colormap( cmap_rgrayb(255) )
    colorbar

    title(['$\lambda_{' int2str(ii) '}=' num2str(lambdas(ii)) '\qquad\qquad \text{Freq }=' num2str(fr(ii)) '$' ]);

    tex = latex_add_fig( tex, 
               sprintf('Dynamic Mode -- Imag Part $\\quad\\text{imag }(\\phi_{%d})$',ii), 
	       sprintf('fig_mode_imag_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_modes_abs( tex, G, modes, lambdas )

  clf
  
  [ n_places n_modes ] = size(modes);

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );

  fr = compute_frequency( lambdas, G.dt );

  V    = abs( modes );
  vmax = max( abs(V(:)) ); 
  if( vmax == 0 ), vmax = 1; end
  
  for ii = 1:n_modes

    M = reshape( V(:,ii), G.Ny, G.Nx );

    image( x, y, M, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([ 0 vmax ])
    colormap( cmap_gbm(255) )
    colorbar

    title(['$\lambda_{' int2str(ii) '}=' num2str(lambdas(ii)) '\qquad\qquad \text{Freq }=' num2str(fr(ii)) '$' ]);

    tex = latex_add_fig( tex, 
               sprintf('Dynamic Mode -- Absolute Value $\\quad |\\phi_{%d}|$',ii), 
	       sprintf('fig_mode_abs_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_modes_arg( tex, G, modes, lambdas )

  clf
  
  [ n_places n_modes ] = size(modes);

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );

  fr = compute_frequency( lambdas, G.dt );

  V = arg( modes );

  % If amplitude is to small ignore argument
  V( abs(modes) < 1e-8 ) = 0;
  
  for ii = 1:1 %%%%% n_modes

    M = reshape( V(:,ii), G.Ny, G.Nx );

    image( x, y, M, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([ -pi pi ])
    colormap( cmap_rwb(255) )
    h = colorbar;
    latex_ticklabel_radian( h, 'y', 0.5 );

    title(['$\lambda_{' int2str(ii) '}=' num2str(lambdas(ii)) '\qquad\qquad \text{Freq }=' num2str(fr(ii)) '$' ]);

    tex = latex_add_fig( tex, 
               sprintf('Dynamic Mode -- Argument $\\text{arg }(\\phi_{%d})$',ii), 
	       sprintf('fig_mode_arg_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_pulse_eigenvalues( tex, G, lambdas )

  FF = compute_frequency( lambdas, G.dt );
  RR = real             ( lambdas );
  II = imag             ( lambdas );
  AA = abs              ( lambdas );
  PP = arg              ( lambdas );

  tex = show_pulse_eigenvalues_complex  ( tex, lambdas, 'DMD Eigenvalues',               'fig_eig'      );
  tex = show_pulse_eigenvalues_real_freq( tex, FF, RR,  'Eigenvalues of Reduced Matrix', 'fig_eig_real' );
  tex = show_pulse_eigenvalues_imag_freq( tex, FF, II,  'Eigenvalues of Reduced Matrix', 'fig_eig_imag' );
  tex = show_pulse_eigenvalues_abs_freq ( tex, FF, AA,  'Eigenvalues of Reduced Matrix', 'fig_eig_abs'  );
  tex = show_pulse_eigenvalues_arg_freq ( tex, FF, PP,  'Eigenvalues of Reduced Matrix', 'fig_eig_arg'  );

end

%------------------------------------------------------------------------------%
function tex = show_pulse_eigenvalues_complex( tex, L, stitle, fname )

  if( isempty(L) ); return; end

  clf

  lmax  = ceil(max(abs([L(:)]))) + 1;
  ticks = linspace( -lmax, lmax, min( 2*lmax+1, 5 ) );

  h = show_lambda_complex( L );
  set(h, 'markersize', 10*lmax )
  axis([-lmax lmax -lmax lmax])
  set(gca, 'xtick', ticks, 'ytick', ticks ); 

  N = length( find( abs(L) > eps ) );
  title( sprintf('Non-null eigenvalues: %d', N ) );

  tex = latex_add_fig( tex, stitle, fname );

end

%------------------------------------------------------------------------------%
function tex = show_pulse_eigenvalues_real_freq( tex, F, V, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );

  vlim = fit_axis_limits( V, 'smart' );
  flim = fit_axis_limits( F, 'smart' );
  
  plot_bar( F(ii), V(ii), 'b', F(jj), V(jj), 'm' );
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
function tex = show_pulse_eigenvalues_imag_freq( tex, F, V, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );

  vlim = fit_axis_limits( V, 'smart' );
  flim = fit_axis_limits( F, 'smart' );
  
  plot_bar( F(ii), V(ii), 'b', F(jj), V(jj), 'm' );
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
function tex = show_pulse_eigenvalues_abs_freq( tex, F, V, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );

  vlim = fit_axis_limits( V, 'smart' );
  flim = fit_axis_limits( F, 'smart' );
  
  plot_bar( F(ii), V(ii), 'b', F(jj), V(jj), 'm' );
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
function tex = show_pulse_eigenvalues_arg_freq( tex, F, V, stitle, fname )

  if( isempty(V) ); return; end

  clf

  ii = find( F <  0 );
  jj = find( F >= 0 );

  vlim = [-pi pi];
  flim = fit_axis_limits( F, 'smart' );
  
  plot_bar( F(ii), V(ii), 'b', F(jj), V(jj), 'm' );
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
function tex = show_pulse_dataset_reconstruction( tex, X_dmd )

  N = size( X_dmd, 3 );

  for ii = 1:N

    clf
    image( squeeze(X_dmd(:,:,ii)), 'cdatamapping', 'scaled' );
    colormap( cmap_rgrayb(255) )
    caxis([-1 1])
    colorbar;

    tex = latex_add_fig( tex, sprintf('Dataset Reconstruction with Modes $r=1:%2d$',ii),
                              sprintf('fig_dataset_recons_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_pulse_dataset_reconstruction_error( tex, E_dmd )

  N = size( E_dmd, 3 );

  for ii = 1:N

    clf
    image( squeeze(E_dmd(:,:,ii)), 'cdatamapping', 'scaled' );
    colormap( cmap_rgrayb(255) )
    caxis([-1 1])
    colorbar;

    tex = latex_add_fig( tex, sprintf('Dataset Error with Modes $r=1:%2d$',ii),
                              sprintf('fig_dataset_recons_error_%02d',ii) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_pulse_reconstruction( tex, G, X_dmd )

  clf

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );
  t = linspace( 0, G.Tf, G.Nt );

  X = squeeze( X_dmd(:,:,end) );

  for ii = 1:G.Nt

    snap = reshape( X(:,ii), G.Ny, G.Nx );

    image( x, y, snap, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([-1 1])
    colormap( cmap_rgrayb(255) )
    colorbar

    tex = latex_add_fig( tex, sprintf( 'Reconstructed Snapshot at $t=%.3f$', t(ii) ), 
                              sprintf( 'fig_snap_recons_%03d', ii ) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_pulse_reconstruction_error( tex, G, E_dmd )

  clf

  x = linspace( 0, G.Lx, G.Nx );
  y = linspace( 0, G.Ly, G.Ny );
  t = linspace( 0, G.Tf, G.Nt );

  X = squeeze( E_dmd(:,:,end) );

  for ii = 1:G.Nt

    snap = reshape( X(:,ii), G.Ny, G.Nx );

    image( x, y, snap, 'cdatamapping', 'scaled' );
    axis([ 0 G.Lx 0 G.Ly ])
    caxis([-1 1])
    colormap( cmap_rgrayb(255) )
    colorbar

    tex = latex_add_fig( tex, sprintf( 'Reconstructed Error at $t=%.3f$', t(ii) ), 
                              sprintf( 'fig_error_recons_%03d', ii ) );

  end

end

%------------------------------------------------------------------------------%
