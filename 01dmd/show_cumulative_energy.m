
function h = show_cumulative_energy( S, pc )

  if( any( S < 0 ) )
    error('negative singular value!')
  end
  
  cla
  
  C = cumsum( S ) / sum( S );
  
  H = plot( C, 'k', 'linewidth', 1.5 );
  
  if( nargin == 2 )
  
    ii = find( C < pc );
    
    hold on
    H(2) = plot( C(ii), 'b', 'linewidth', 2 );
    hold off
  
  end
  
  ylim([0 1.1])
  grid on
  
  if( nargout > 0 ), h = H; end

end
%------------------------------------------------------------------------------%
