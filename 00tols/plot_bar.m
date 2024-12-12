
function plot_bar( A, B, C, D, E, F )

  two = false;
  C1 = 'b';
  C2 = [ .5 .5 .5 ]; 
  
  if    ( nargin == 1 ); X1 = []; Y1 = A;
  elseif( nargin == 2 )
    if( isnumeric(B) );  X1 =  A; Y1 = B;
    else;                X1 = []; Y1 = A; C1 = B;
    end
  elseif( nargin == 3 ); X1 = A; Y1 = B; C1 = C;
  elseif( nargin == 4 ); 
     two = true;
     X1 = A; Y1 = B;
     X2 = C; Y2 = D;
  elseif( nargin == 6 ); 
     two = true;
     X1 = A; Y1 = B; C1 = C;
     X2 = D; Y2 = E; C2 = F;
  else 
    error('Input error')
  end
  
  hold_off = ~ishold();

  if( hold_off ); cla; hold on; end
  
  plot_bar_1( X1, Y1, C1 );
  
  if( two ) 
    if( ~exist( 'X2', 'var' ) ); X2 = 1:length(Y2); end
    plot_bar_1( X2, Y2, C2 );
  end

  plot( xlim, [0 0], 'k' )
  
  if( hold_off ); hold off; end

end

%------------------------------------------------------------------------------%
function plot_bar_1( X, Y, C )

  if( isempty( X ) ); X = 1:length(Y); end
  
  plot( X, Y, '.', 'markersize', 10, 'color', C )
  
  for ii = 1:length(X)
    plot( [ X(ii) X(ii) ], [ 0 Y(ii) ], '-', 'linewidth', 1.5, 'color', C ) 
  end

end

%------------------------------------------------------------------------------%
