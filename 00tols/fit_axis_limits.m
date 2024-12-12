
function ax = fit_axis_limits( X, mode )

  if( nargin == 1 ), mode = 'default'; end

  xmin = floor( min( X(:) ) );
  xmax = ceil ( max( X(:) ) );

  switch( mode )

    case( 'default' )
      if( xmin < xmax ); ax = [ xmin xmax ];
      else;              ax = [ -1   1    ]; 
      end

    case( 'positive' )
      if( 0 < xmax ); ax = [ 0 xmax ];
      else;           ax = [ 0 1    ]; 
      end

    case( 'negative' )
      if( xmin < 0 ); ax = [ xmin 0 ];
      else;           ax = [ -1   0 ]; 
      end

    case( 'symmetrical' )
      xmax = max(abs([xmin xmax]));
      if( 0 < xmax ); ax = [ -xmax xmax ];
      else;           ax = [ -1    1    ]; 
      end

    case( 'smart' )
      if( xmin == 0 && xmax == 0 ), 
	ax = [ -1 1 ]; 
      elseif( xmin*xmax < 0 ), 
        xmax = max(abs([xmin xmax]));
	ax   = [ -xmax xmax ];
      elseif( xmax > 0 )
        ax = [ 0 xmax ];
      else
        ax = [ xmin 0 ];
      end

    otherwise
      error('invalidy mode');

  end

end
