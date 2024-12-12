
function h = show_singular_values( S, pc )
  
  if( any( S < 0 ) )
    error('negative singular value!')
  end

  cla
  
  S( S == 0 ) = NaN;
  
  H = semilogy( S, 'k', 'linewidth', 1.5 );
  
  if( nargin == 2 )
  
    C  = cumsum( S ) / sum( S );
    ii = find( C < pc );
    
    hold on
    H(2) = plot( S(ii), 'b', 'linewidth', 2 );
    hold off
  
  end
  
  if( nargout > 0 ), h = H; end

end
%------------------------------------------------------------------------------%
