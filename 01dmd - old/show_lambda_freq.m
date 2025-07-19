
function show_lambda_freq( L, dt, mode )

  X = compute_frequency( L, dt );
  
  ii = find( X <  0 );
  jj = find( X >= 0 );

  switch( mode )

    case 'abs'
      Y = abs( L );
      plot_bar( X(ii), Y(ii), 'k', X(jj), Y(jj), 'b' ); 
      ylim( fit_axis_limits( ylim, 'smart' ) );

    case 'arg'
      Y = arg( L );
      plot_bar( X(ii), Y(ii), 'k', X(jj), Y(jj), 'b' ); 
      ylim([-pi pi])
      latex_ticklabel_radian( 'y', 1 );

    case 'real'
      Y = real( L );
      plot_bar( X(ii), Y(ii), 'k', X(jj), Y(jj), 'b' ); 
      ylim( fit_axis_limits( ylim, 'smart' ) );

    case 'imag'
      Y = imag( L );
      plot_bar( X(ii), Y(ii), 'k', X(jj), Y(jj), 'b' ); 
      ylim( fit_axis_limits( ylim, 'smart' ) );

    otherwise
      error(['invalid mode: ' mode '!'])

  end

  xlim( fit_axis_limits( xlim, 'symmetrical' ) );
  grid on
  
  hold on
  plot( xlim, [0 0], 'k' )
  hold off

end

%------------------------------------------------------------------------------%
