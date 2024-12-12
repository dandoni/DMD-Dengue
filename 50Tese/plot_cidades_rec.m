%------------------------------------------------------------------------------%
function plot_cidades

run '../../../startup'

load 'cidadesrec.hdf5'

%------------------------------------------------------------------------------%

  % Presentation information
  latexdir = 'latex_cidades_rec';
  filename = 'cidades.tex'; 
  ptitle   = 'cidades'; 
  author   = 'Daniel Moraes Barbosa e Luis D''Afonseca';
  
  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
  
  tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
  
  figure_position(1,1,2,2);
  clf
  
  tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 9] );
  
  tex = latex_add_content( tex, '\clearpage\blindtext' );
  
  %----------------------------------------------------------------------------%

  cid = dados.cid / 1000;
  rec = dados.rec / 1000;

  plot_cid( 1, cid(1,:) , rec(1,:)); 
  plot_cid( 2, cid(2,:) , rec(2,:) ); 
  plot_cid( 3, cid(3,:) , rec(3,:) ); 
  plot_cid( 4, cid(4,:) , rec(4,:) ); 

  tex = latex_add_fig( tex, 'Evolução da Dengue em algumas cidades em milhares de casos.', 
                            'dengue_reccid' );
  
  %----------------------------------------------------------------------------%
  
  tex = latex_add_content( tex, '\blindtext' );
  
  latex_compile(tex,'batchmode');

end

%------------------------------------------------------------------------------%
function plot_cid( N, Y , Z)

  xo = 0.05;
  ww = 0.92;
  yo = 0.10;
  hh = 0.215; % 0.15251;
  dh = 0.22;

  subplot( 'position', [ xo  yo+dh*(4-N)  ww  hh ] ); 

  plot( Y , 'linewidth' , 0.5)
  hold on
  plot( Z , '--')

  xlim  ( [ 1 313 ] )
  xticks( [ 1     53    105    157    209    261    313  ] ) 

  if( N == 4 ), xticklabels( { '2014' '2015' '2016' '2017' '2018' '2019' '2020' } )
  else,         xticklabels( {} )
  end

  ylim  ( [ -2 14 ] )
  yticks( 0:6:12 )

  % ylabel( 'Milhares de casos' )
  grid on

  name = { ' Juiz de Fora - MG '
           ' S�o Paulo - SP '
           ' Rio de Janeiro - RJ '
           ' Belo Horizonte - MG ' };

  h = text( 150, 6.5, name{N} );
  set( h, 'horizontalalignment', 'left',
          'edgecolor',           'k',
          'backgroundcolor',     'w' )
end

%------------------------------------------------------------------------------%
