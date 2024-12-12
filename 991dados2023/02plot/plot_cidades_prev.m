function plot_cidades_prev
  clc,clear all
  run '../../startup'

load 'cidadesrec2023.hdf5'
load 'cid2022.hdf5'
  % Presentation information
  latexdir = 'latex_cidades_prev';
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

  
  %----------------------------------------------------------------------------%




  cid1 = cid2022 / 1000;
  rec = real(cid.rec) / 1000;

##    plot_cid( 1, cid1(1,:) , rec(1,num_sem:end) ); 
##  plot_cid( 2, cid1(2,:) , rec(2,num_sem:end) ); 
##  plot_cid( 3, cid1(3,:) , rec(3,num_sem:end) ); 
##  plot_cid( 4, cid1(4,:) , rec(4,num_sem:end) ); 

  plot_cid( 1, cid1(1,:) , rec(1,num_sem:num_sem+52) ); 
  plot_cid( 2, cid1(2,:) , rec(2,num_sem:num_sem+52) ); 
  plot_cid( 3, cid1(3,:) , rec(3,num_sem:num_sem+52) ); 
  plot_cid( 4, cid1(4,:) , rec(4,num_sem:num_sem+52) ); 
  

  

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
  
##
##  xlim  ( [ 1 156 ] )
##  xticks( [ 1     52    104   156] ) 
##
##  if( N == 4 ), xticklabels( {  '2021' '2022' '2023' '2024'} )

  xlim  ( [ 1 52 ] )
  xticks( [ 1     52  ] ) 

  if( N == 4 ), xticklabels( {  '2022' '2023'} )
  else,         xticklabels( {} )
  end

  ylim  ( [ -2 5 ] )
  yticks( 0:2.5:5 )

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


##function plot_cid( N, Y , Z)
##  
##  xo = 0.05;
##  ww = 0.85;
##  yo = 0.15;
##  hh = 0.18; % 0.15251;
##  dh = 0.20;
##
##  subplot( 'position', [ xo  yo+dh*(4-N)  ww  hh ] ); 
##
##  plot( Y , 'linewidth' , 0.5)
##  hold on
##  plot( Z , '--')
##
##  xlim  ( [ 1 417 ] )
##  xticks( [ 1     53    105    157    209    261    313  365  417] ) 
##
##  if( N == 4 ), xticklabels( { '2014' '2015' '2016' '2017' '2018' '2019' '2020' '2021' '2022' } )
##  else,         xticklabels( {} )
##  end
##
##  ylim  ( [ -2 9 ] )
##  yticks( 0:4:8 )
##
##  % ylabel( 'Milhares de casos' )
##  grid on
##
##  name = { ' Juiz de Fora - MG '
##           ' São Paulo - SP '
##           ' Rio de Janeiro - RJ '
##           ' Campo Grande - MS ' };
##
##  h = text( 150, 6.5, name{N} );
##  set( h, 'horizontalalignment', 'left',
##          'edgecolor',           'k',
##          'backgroundcolor',     'w' )
##end



%endfunction
