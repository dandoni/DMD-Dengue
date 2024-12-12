
function run_reconstruction_test_08

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_reconstruction_test_08';
  filename = 'reconstruction_test_08.tex'; 
  ptitle   = 'DMD Reconstruction Test -- 08'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Introduction' );

  N_places = 100;
  N_snaps  = 1000;
  percent  = 0.99;

  content = [ 'Senoidal function on x and t' endline(2) ];
  content = [ content '\[ X = \sin( a x )\sum b_i \sin( f_i t )\]' endline(2) ];
  content = [ content sprintf( '%d positions and %d snapshots', N_places, N_snaps ) endline(2) ];

  tex = latex_add_content( tex, 'Dataset Model', content );

%------------------------------------------------------------------------------%

  X = commpute_X( N_places, N_snaps );

  tex = reconstruction_test( tex, X, percent );

%------------------------------------------------------------------------------%

  close all; 
  latex_compile( tex );

end

%------------------------------------------------------------------------------%
function X = commpute_X( N_places, N_snaps )

  % Frequencies and amplitudes
  F = [ 1.0  5.0  7.0  13.0  17.0 ];
  A = [ 1.0  0.7  0.5   0.3   0.1 ];

  t = linspace( 0, 2*pi, N_snaps );
  p = zeros(size(t));

  for ii = 1:length(F)
    p = p + A(ii) * sin( t * F(ii) );
  end

  x = linspace( 0, 2*pi, N_places )';
  q = sin( 2 * x );

  P = repmat( p, N_places, 1 );
  Q = repmat( q, 1, N_snaps  );

  X = P .* Q;

  xmin = min( X(:) );
  xmax = max( X(:) );

  X = ( X - xmin ) / ( xmax - xmin );

end

%------------------------------------------------------------------------------%
