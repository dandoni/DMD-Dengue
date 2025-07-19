
function F = compute_frequency( lambdas, dt )

if( nargin == 1 ), dt = 1; end

  F = imag( log(lambdas) / dt ) / ( 2*pi );

end



