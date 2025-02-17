
function latex_ticklabel_radian( A, B, C )

% Set axis id ticklabels to multiples of pi 
% 
% Usage: latex_ticklabel_radian( h, id, step )
%
% h    - axis handle, if not provided uses handle to the current axes object
% id   - Axis id, 'x', 'y', or 'z'
% step - Increment in fraction of pi, recomended values 1/4, 1/2, 1, 2
%

  if( ishandle( A ) )
    if( nargin < 3 ), error('missing parameters!'); end
    h    = A; 
    id   = B;
    step = C;
  else
    if( nargin < 2 ), error('missing parameters!'); end
    h    = gca;
    id   = A;
    step = B;
  end

  if( ~ismember( id, { 'x' 'y' 'z' } ) ), error(['invalid axis id: ' id ]); end

  ll = get( h, [ id 'lim' ] ) / ( step*pi );

  T = step * ( floor(ll(1)):ceil(ll(end)) );

  [ N D ] = rat( T );

  ticks  = pi*T;
  labels = latex_write_pi( N, D );

  set( h, [ id 'tick' ], ticks, [ id 'ticklabel' ], labels );

end

% Write LaTeX string for ( a pi / b )
%------------------------------------------------------------------------------%
function label = latex_write_pi( numerator, denominator )
 
  nn = length( numerator );

  label = cell(1,nn);

  for ii = 1:nn

    N = numerator  (ii);
    D = denominator(ii);
    
    if( D == 1 )

      if    ( N ==  0 ), label{ii} =      '0';
      elseif( N ==  1 ), label{ii} =  '$\pi$';
      elseif( N == -1 ), label{ii} = '$-\pi$';
      else,              label{ii} = sprintf( '$%d \\pi$', N );
      end

    else

      if    ( N ==  0 ), label{ii} = '0';
      elseif( N ==  1 ), label{ii} = sprintf(    '$\\pi / %d$',    D );
      elseif( N == -1 ), label{ii} = sprintf(   '$-\\pi / %d$',    D );
      else,              label{ii} = sprintf( '$%d \\pi / %d$', N, D );
      end

    end

  end

end

%------------------------------------------------------------------------------%
