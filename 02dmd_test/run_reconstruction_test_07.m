
function run_reconstruction_test_07

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_reconstruction_test_07';
  filename = 'reconstruction_test_07.tex'; 
  ptitle   = 'DMD Reconstruction Test -- 07'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Introduction' );

  N_places = 100;
  N_snaps  = 1000;
  percent  = 0.99;

  content = [ 'Random senoids with decaing amplitude' endline(2) ];
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

  X = zeros( N_places, N_snaps );
  
  t = linspace( 0, 20, N_snaps );
  
  % Minimum and maximum frequencies
  fmin = 0.1;
  fmax = 10;

  rand( 'seed', 17 );
  
  for ii = 1:N_places
  
    % Phase, frequency and amplitude
    p = 2 * pi * rand(1,1);

    f = fmin + ( fmax - fmin ) * rand(1,1);

    a = 1 + 4 * rand(1,1);
  
    % Decay
    l = 1.1 * rand(1,1) -1;

    X(ii,:) = a * sin( f*t/(2*pi) + p ) .* exp( l*t );
  
  end  

  X = X / max(X(:));

end

%------------------------------------------------------------------------------%
