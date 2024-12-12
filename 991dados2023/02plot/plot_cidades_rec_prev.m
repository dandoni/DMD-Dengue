function plot_cidades_rec_prev
  
run '../../startup'

load 'cidadesrec2023.hdf5'
load 'cid2022.hdf5'

 % Presentation information
  latexdir = 'latex_cidades_rec_prev';
  filename = 'cidades.tex'; 
  ptitle   = 'cidades'; 
  author   = 'Daniel Moraes Barbosa e Luis D''Afonseca';
  
  % Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'pt' );
figure_position(1,2,2,1);

  
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [16 7.5] ); 

  cid1 = cid.dados / 1000;
  cid2 = cid2022 / 1000;
  cid0 = cat(2,cid1,cid2);
  rec = real(cid.rec) / 1000;


  plot_cid( 1, cid0(1,:) , rec(1,1:num_sem+52) ); 
  plot_cid( 2, cid0(2,:) , rec(2,1:num_sem+52) ); 
  plot_cid( 3, cid0(3,:) , rec(3,1:num_sem+52) ); 
  plot_cid( 4, cid0(4,:) , rec(4,1:num_sem+52) ); 
    tex = latex_add_fig( tex, 'fig' , 'recprev');
 %----------------------------------------------------------------------------%
  
  tex = latex_add_content( tex, '\blindtext' );
  
  latex_compile(tex,'batchmode');
  
  close all

end

function plot_cid( N, Y , Z)
  
  xo = 0.05;
  ww = 0.85;
  yo = 0.15;
  hh = 0.18; % 0.15251;
  dh = 0.20;

  subplot( 'position', [ xo  yo+dh*(4-N)  ww  hh ] ); 

  plot( Y , 'linewidth' , 0.5)
  hold on
  plot( Z , '--')

  xlim  ( [ 1 469] )
  xticks( [ 1     53    105    157    209    261    313  365  417 469] ) 

  if( N == 4 ), xticklabels( { '2014' '2015' '2016' '2017' '2018' '2019' '2020' '2021' '2022' '2023'} )
  else,         xticklabels( {} )
  end

  ylim  ( [ -2 9 ] )
  yticks( 0:4:8 )

  % ylabel( 'Milhares de casos' )
  grid on

  name = { ' Juiz de Fora - MG '
           ' São Paulo - SP '
           ' Rio de Janeiro - RJ '
           ' Campo Grande - MS ' };

  h = text( 150, 6.5, name{N} );
  set( h, 'horizontalalignment', 'left',
          'edgecolor',           'k',
          'backgroundcolor',     'w' )
end
