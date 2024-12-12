
function run_reconstruction_test_03

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_reconstruction_test_03';
  filename = 'reconstruction_test_03.tex'; 
  ptitle   = 'DMD Reconstruction Test -- 03'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Introduction' );

  N_places = 60;
  N_snaps  = 100;
  percent  = 0.99;
  
  content = [ 'Random Dataset' endline(2) ];
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

  rand( 'seed', 79 );

  X = rand( N_places, N_snaps );
  
  X = X / max(X(:));

end

%------------------------------------------------------------------------------%
