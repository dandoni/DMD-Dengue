
function h = plot_brazil_cities( map, X )

  ish = ishold;

  H.boundary = plot( map.boundary.x, map.boundary.y, 'k' ); 

  hold on 

  H.dots = scatter( map.cities.x, map.cities.y,2, X, 'filled', 'marker', 's' );

  if( ~ish ), hold off; end

  axis off equal

  if( nargout == 1 ), h = H; end

end

%------------------------------------------------------------------------------%
