
function tex = least_squares_comparison( tex, D1, D2 );

%------------------------------------------------------------------------------%

  N1 = D1.N_places;
  N2 = D2.N_places;

  tex = show_ls_comp_X  ( tex, N1, N2, D1.X,   D2.X   );
  tex = show_ls_comp_Xls( tex, N1, N2, D1.Xls, D2.Xls );
  tex = show_ls_comp_E  ( tex, N1, N2, D1.Els, D2.Els );

  tex = show_ls_comp_singular_values( tex, N1, N2, D1.S, D2.S );

  Lmax = ceil( max(abs( [ D1.H_lambda; D2.H_lambda; D1.A_lambda; D2.A_lambda ] ) ) ) + 1;

  tex = show_ls_comp_eigenvalues( tex, 'H', N1, N2, D1.H_lambda, D2.H_lambda, Lmax );
  tex = show_ls_comp_eigenvalues( tex, 'A', N1, N2, D1.A_lambda, D2.A_lambda, Lmax );

end

%------------------------------------------------------------------------------%
function tex = show_ls_comp_X( tex, N1, N2, X1, X2 )

  clf

  clim = [ 0 1 ];
  cmap = cmap_gbm;
  
  subplot(1,2,1)
  image( X1, 'cdatamapping', 'scaled' );
  colormap( cmap );
  colorbar;
  caxis( clim )
  title([ int2str(N1) ' Places' ])
  
  subplot(1,2,2)
  image( X2, 'cdatamapping', 'scaled' );
  colormap( cmap );
  colorbar;
  caxis( clim )
  title([ int2str(N2) ' Places' ])

  tex = latex_add_fig( tex, 'Dataset', 'fig_X' );

  % Snapshots

  [ N1 N_snaps ] = size( X1 );
  N2             = size( X2, 1 );
  nn = round( linspace( 1, N_snaps, 5 ) );

  t1 = linspace( 0, 1, N1 );
  t2 = linspace( 0, 1, N2 );
  
  for ii = nn 

    clf
    subplot(1,2,1); plot( t1, X1(:,ii), 'b' ); axis([ 0 1 0 1 ]); grid on;
    subplot(1,2,2); plot( t2, X2(:,ii), 'b' ); axis([ 0 1 0 1 ]); grid on;

    tex = latex_add_fig( tex, sprintf( 'Snapshot $n=%3d$', ii ),
                              sprintf( 'fig_snap_%03d',    ii ) );

  end

end

%------------------------------------------------------------------------------%
function tex = show_ls_comp_Xls( tex, N1, N2, X1, X2 )

  clf

  clim = [ 0 1 ];
  cmap = cmap_gbm;
  
  subplot(1,2,1)
  image( X1, 'cdatamapping', 'scaled' );
  colormap( cmap );
  colorbar;
  caxis( clim )
  title([ int2str(N1) ' Places' ])
  
  subplot(1,2,2)
  image( X2, 'cdatamapping', 'scaled' );
  colormap( cmap );
  colorbar;
  caxis( clim )
  title([ int2str(N2) ' Places' ])

  tex = latex_add_fig( tex, 'Least Square Reconstruction of Dataset', 'fig_X_ls' );

end

%------------------------------------------------------------------------------%
function tex = show_ls_comp_E( tex, N1, N2, E1, E2 );

  clf

  clim = [ -1 1 ] * max( abs([ E1(:) ; E2(:) ]) );
  cmap = cmap_rgrayb;
  
  subplot(1,2,1)
  image( E1, 'cdatamapping', 'scaled' );
  colormap( cmap );
  colorbar;
  caxis( clim )
  title([ int2str(N1) ' Places' ])
  
  subplot(1,2,2)
  image( E2, 'cdatamapping', 'scaled' );
  colormap( cmap );
  colorbar;
  caxis( clim )
  title([ int2str(N2) ' Places' ])

  tex = latex_add_fig( tex, 'Reconstruction Error', 'fig_E' );
  
  clf

  E1 = max( 1e-20, max( abs(E1) ) );
  E2 = max( 1e-20, max( abs(E2) ) );

  Emin = max( 1e-15, min([ E1(:); E2(:) ]) );
  Emax = min(  1e15, max([ E1(:); E2(:) ]) );

  Pmin = floor( log10(Emin) );
  Pmax = ceil ( log10(Emax) );
  P    = round( linspace( Pmin, Pmax, 5 ));

  subplot(1,2,1)
  semilogy( E1, 'linewidth', 2 ) 
  ylim([ 10^Pmin 10^Pmax])
  latex_semilogy_annotations(P);
  title([ int2str(N1) ' Places Error' ])
  
  subplot(1,2,2)
  semilogy( E2, 'linewidth', 2 ) 
  ylim([ 10^Pmin 10^Pmax])
  latex_semilogy_annotations(P);
  title([ int2str(N2) ' Places Error' ])

  tex = latex_add_fig( tex, 'Reconstruction Error by Snapshot', 'fig_E_snap' );

end

%------------------------------------------------------------------------------%
function tex = show_ls_comp_singular_values( tex, N1, N2, S1, S2 )

  S1( S1 == 0 ) = NaN;
  S2( S2 == 0 ) = NaN; 

  ll = min( length(S1), length(S2) );

  D = abs(S1(1:ll) - S2(1:ll));
  D( D == 0 ) = NaN;


  clf
  semilogy( S1, 'k-', S2, 'b-' ) 
  ylim([1e-20 2e2])
  latex_semilogy_annotations([-20 -15 -10 -5 -1 2]);

  h = legend( [ int2str(N1) ' Places' ], [ int2str(N2) ' Places' ] );
  set( h, 'position', [0.742 0.758 0.16 0.16] )

  tex = latex_add_fig( tex, 'Singular Values', 'fig_sing_values' );

  clf
  semilogy( D, 'r-' ) 
  ylim([1e-20 2e2])
  latex_semilogy_annotations([-20 -15 -10 -5 -1 2]);

  tex = latex_add_fig( tex, 'Singular Values Difference', 'fig_sing_values_diff' );

end 

%------------------------------------------------------------------------------%
function tex = show_ls_comp_eigenvalues( tex, name, N1, N2, lambda1, lambda2, Lmax )

  clf

  ticks = linspace( -Lmax, Lmax, min( 2*Lmax+1, 5 ) );

  subplot(1,2,1)
  h = show_lambda_complex( lambda1 );
  set(h, 'markersize', 10 )
  title([ int2str(N1) ' Places' ])
  axis([-Lmax Lmax -Lmax Lmax])
  set(gca, 'xtick', ticks, 'ytick', ticks ); 
  
  subplot(1,2,2)
  h = show_lambda_complex( lambda2 );
  set(h, 'markersize', 10 );
  title([ int2str(N2) ' Places' ])
  axis([-Lmax Lmax -Lmax Lmax])
  set(gca, 'xtick', ticks, 'ytick', ticks ); 

  tex = latex_add_fig( tex, sprintf( 'Eigenvalues of $%s$', name ), ['fig_' name '_eigen'] );

end
%------------------------------------------------------------------------------%

