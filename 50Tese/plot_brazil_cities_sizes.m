
function h = plot_brazil_cities_sizes( map, X,a,b )

  ish = ishold;

  H.boundary = plot( map.boundary.x, map.boundary.y, 'k', 'linewidth', a ); 

  hold on 

  H.dots = scatter( map.cities.x, map.cities.y,b, X, 'filled', 'marker', 's' );

  if( ~ish ), hold off; end

  axis off equal

  if( nargout == 1 ), h = H; end

end

%------------------------------------------------------------------------------%
