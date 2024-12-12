function plot_ex3_hdf5
clc, clear all
run '../../../startup'
close all

% Presentation information
latexdir = 'exemplo_3';
filename = 'exemplo_3.tex'; 
ptitle   = 'Exemplo 3'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex',
                                    'device', '-dpdflatex' ,
                                    'size',   [15 4] );
  
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
% Load File

load 'ex3.hdf5'

plot(t,X)
hold on
plot(t,real(X_dmd),'--','color','b')

set (gca,'position',[0.0700   0.30000   0.90000   0.6500])    
axis([-2*pi, 2*pi,-1,1] )
xlabel("$t$")
h = legend("$\cos(t)$", "DMD") ;
set( h, 'orientation', 'horizontal',
          'position', [ 0.52 0.83 0.45 0.12 ] )  
       

tex = latex_add_fig(tex,"Parte Real", "ex3_rec3_cap3");
clf


close all
latex_compile(tex,'batchmode');
endfunction