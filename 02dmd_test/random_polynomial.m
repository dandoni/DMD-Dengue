
function P = random_polynomial( ss )

  N_places = 200; 
  nn = 5;
  
  rand( 'seed', ss );

  xi = linspace( 0, 1, nn );
  yi = 0.7 * rand( nn, 1 );

  x  = linspace( 0, 1, N_places )';
  P  = interp1( xi, yi, x, 'spline' );

  nn = 4 * nn;
  
  xi = linspace( 0, 1, nn );
  yi = 0.3 * rand( nn, 1 );

  P  = P + interp1( xi, yi, x, 'spline' );

  P = P - min( P );
  P = P / max( P );

