
function C = cmap_extension( cmap, L, N )

% Extends a color map
%
% Usage:  C = cmap_extension( cmap, L, N )
%
% cmap - Function handle to colormap
% L    - Vector with four elements defining the limits, [ min start end max ]
%        min   - minimum value of color axis
%        start - start of actual color map
%        end   - end of actual color map
%        max   - maximum value of color axis
% N    - Number of points on the new colormap (optional, detault = 128)
%

  if( nargin == 2 ), N = 128; end;
  
  if( ~isvector( L )   ), error( 'L must be a vector of 4 elements!' ); end
  if( length( L ) ~= 4 ), error( 'L must be a vector of 4 elements!' ); end
  if( ~issorted( L )   ), error( 'Vector L must be sorted!'          ); end
  
  % Normalization of vector L
  L = L - L(1);
  L = L / L(4);
  
  L_start = L(2);
  L_end   = L(3);
  
  % Computing indeces
  N_start = max( 1, ceil ( N * L_start ) );
  N_end   = floor( N * L_end );
  N_cmap  = N_end - N_start + 1;
  
  if( N_cmap < 3  ), error( 'The start and end values are too close!' ); end
  
  C = zeros( N, 3 );
  
  % Building the original colormap
  C( N_start:N_end, : ) = feval( cmap, N_cmap );
  
  % Extending the colormap
  if( N_start > 1 ), C(1:N_start-1,:) = repmat( C(N_start,:), N_start-1, 1 ); end
  if( N_end   < N ), C(N_end+1:end,:) = repmat( C(N_end,  :), N-N_end,   1 ); end

end

