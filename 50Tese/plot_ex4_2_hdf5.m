function plot_ex4_hdf5
clc, clear all
run '../../../startup'
close all

load 'ex4_2.hdf5'

% Presentation information
latexdir = 'exemplo4_2';
filename = 'exemplo4.tex'; 
ptitle   = 'Exemplo 4'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
  
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
                                   
 
%FIGURAS DE 1 PAGINA
                                   
tex = latex_figure_properties( tex, 'type', 'tex',
                                    'device', '-dpdflatex' ,
                                    'size',   [15 4] );

                                    
plot(t(125:376),X(125:376),'linewidth',0.5)
hold on
plot(t(125:376),real(X_dmd)(125:376),'--','color','b')
plot_axis_setup();
h = legend("$f(t)$", "DMD") ;
set( h, 'position', [ 0.77 0.6 0.2 0.35 ]) 

tex = latex_add_fig(tex,"Parte Real", "ex4_2_rec");
clf      
      

function plot_axis_setup()
  set (gca,'position',[0.0700   0.30000   0.90000   0.6500])
  xlabel('$t$')  
  axis([-pi, pi,-1.1,1.1] )
  yticks([-1:1:1])

  
endfunction  

function plot_axis_setup2()
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  ;
xlabel('Frequências')
ylabel('Amplitude') 
endfunction  
close all
latex_compile(tex,'batchmode');
endfunction