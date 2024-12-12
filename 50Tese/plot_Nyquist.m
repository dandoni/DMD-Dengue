%------------------------------------------------------------------------------%
function plot_Nyquist

run '../../../startup'

clear all
close all

load Nyquist.mat

%------------------------------------------------------------------------------%

  % Presentation information
  latexdir = 'Nyquist_final';
  filename = 'Nyquist.tex'; 
  ptitle   = 'Nyquist'; 
  author   = 'Daniel Moraes Barbosa';
  
  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
  
  tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
  
  figure_position(1,2,2,1);
  
  tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 3] );  %figuras geradas direto em pdf
  
  ## set( 0, 'DefaultAxesFontSize', 6 );
   
  % Adding text for context
  tex = latex_add_content( tex, '\clearpage\blindtext' );
  
  %----------------------------------------------------------------------------%
  
  plot( t,       x_c,  'b', 
        t,       x_c2, 'm--',
        n1*T(1), x1,   'ko' )
  
  plot_Nyquist_axis_setup();
  
  h = legend( ' Original', ' 10 Hz', 'Amostras' );

  set( h, 'orientation', 'horizontal',
          'position', [ 0.3 0.36 0.45 0.12 ] )  %default normalized (eixo 0 a 1)
  

  tex = latex_add_fig( tex, 'undersampling', 'fig_undersampling' );
  
  %----------------------------------------------------------------------------%
  
  clf
  plot( t,       x_c, 'b', 
        n2*T(2), x2,  'ko' )

 
  plot_Nyquist_axis_setup();
  
  tex = latex_add_fig( tex, 'undersampling2', 'fig_undersampling2' );
  
  %----------------------------------------------------------------------------%
  
  clf
  plot( t,       x_c, 'b',
        n3*T(3), x3,  'ko')
  
  plot_Nyquist_axis_setup();
  
  tex = latex_add_fig( tex, 'undersampling3', 'fig_undersampling3' );
  
  %----------------------------------------------------------------------------%
  
  close all
  
  tex = latex_add_content( tex, '\blindtext' );
  
  latex_compile(tex,'batchmode');

end

%------------------------------------------------------------------------------%
function plot_Nyquist_axis_setup

% Criei essa função para garantir que todos os gráficos tenham as mesmas 
% caracteristicas

  axis( [ -0.05 0.05 -1.2 1.2 ] )
  set( gca, 'ytick', -1:1 )
  grid on
  
  set (gca,'position',[0.0700   0.30000   0.90000   0.6500])
  
  xlabel( '$t$ (segundos)', 'position' , [ 0 -1.8 0 ] );
  ylabel( '$f(t)$' )

end

%------------------------------------------------------------------------------%
