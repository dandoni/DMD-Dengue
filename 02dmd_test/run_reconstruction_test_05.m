
function run_reconstruction_test_05

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_reconstruction_test_05';
  filename = 'reconstruction_test_05.tex'; 
  ptitle   = 'DMD Reconstruction Test -- 05'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  figure_position(1,2,2,1);

%------------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Introduction' );

  N_places = 30;
  N_snaps  = 400;
  percent  = 0.99;
  
  content = [ 'Several Pulses' endline(2) ];
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
  
  pulse_size = 100;

  pulse = zeros( 1, pulse_size );

  pulse( 1:20) = linspace(0,1,20);
  pulse(20:60) = 1;
  pulse(61:80) = linspace(1,0,20);
  
  for ii = 1:10
    pulse = filter( ones(1,3), eye(3,1), pulse ) / 3;
  end  
  
  for ii = 1:N_places
  
    jj = max( 1, round( 300*rand(1,1) ) );
  
    X( ii, jj+(1:pulse_size) ) = pulse;
  
  end  

  X = X / max(X(:));

end

%------------------------------------------------------------------------------%
