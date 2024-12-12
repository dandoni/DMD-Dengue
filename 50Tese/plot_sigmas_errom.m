%------------------------------------------------------------------------------%
function plot_cidades
clc, clear all, close all
run '../../../startup'

load 'dengue_rotina.hdf5'


%------------------------------------------------------------------------------%

  % Presentation information
  latexdir = 'simgas e erro';
  filename = 'sigerro.tex'; 
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
                                 'size',   [15 6] );
  
  tex = latex_add_content( tex, '\clearpage\blindtext' );
  
  %----------------------------------------------------------------------------%

##  cid = dados.cid / 1000;
##  rec = dados.rec / 1000;
  t = 1:length(sigmas);
  
  plot_cid( 1, t , sigmas); 
  hold on 
  plot([0,313],[1e-16,1e-16],'-.','color', 'b');
  hold off
  plot_cid( 2, t , erro_max ); 
  hold on
  plot([0,313],[1e-16,1e-16],'-.','color', 'b');

  tex = latex_add_fig( tex, 'teste', 'teste', 'box', 'on' );
  
  %----------------------------------------------------------------------------%
  
##  tex = latex_add_content( tex, '\blindtext' );
  
 latex_compile(tex,'batchmode');

end

%------------------------------------------------------------------------------%
function plot_cid( N, Y, Z)

  xo = 0.15;
  ww = 0.82;
  yo = 0.20;
  hh = 0.355; % 0.15251;
  dh = 0.42;

  subplot( 'position', [ xo  yo+dh*(2-N)  ww  hh ] ); 

 semilogy(Y, Z ,'color', 'black')
  
  xlim  ( [ 1 313 ] )
  xticks( [ 1     53    105    157    209    261    313  ] ) 

if (N == 1)
  ylim  ( [10^(-20) 1  ] )
  yticks( 10.^[0:-6:-18])
  ylabel('Valor Singular')
  xticklabels( {} )
end
if (N == 2)
  ylim  ( [ 10^(-10) 10^5  ] )
  yticks( 10.^[4:-4:-9])
  ylabel('Erro Máximo')
  xlabel('Número de valores singulares usado')
end
  
  set(gca,'yminortick', 'off')
  grid on
  set (gca,'yminorgrid', 'off')


##  name = { ' Juiz de Fora - MG '
##           ' São Paulo - SP '
##           ' Rio de Janeiro - RJ '
##           ' Belo Horizonte - MG ' };
##
##  h = text( 150, 6.5, name{N} );
##  set( h, 'horizontalalignment', 'left',
##          'edgecolor',           'k',
##          'backgroundcolor',     'w' )
end

%------------------------------------------------------------------------------%
