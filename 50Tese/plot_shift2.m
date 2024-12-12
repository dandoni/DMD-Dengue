function plot_shift2
clc, clear all
run '../../../startup'
close all
load 'ex_shift2.hdf5'

% Presentation information
latexdir = 'exemplo shift 2';
filename = 'exemplo_s2.tex'; 
ptitle   = 'Exemplo s'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex',
                                    'device', '-dpdflatex' ,
                                    'size',   [15 4] );
  
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
                                   
                                   
plot(t(1:end-1),X(1,:))
hold on
plot(t(1:end-1),real(X_dmd(1,:)),'--','color','b')

set (gca,'position',[0.0700   0.30000   0.90000   0.6500])    
axis([-2*pi, 2*pi,-1.1,1.1] )
yticks([-1:1:1])
xlabel("$t$")
h = legend("$\cos (t)$", "DMD - Shift") ;
set( h, 'orientation', 'horizontal',
          'position', [ 0.52 0.83 0.45 0.12 ] )  
       

tex = latex_add_fig(tex," ", "ex_shift2");
clf


close all
latex_compile(tex,'batchmode');
endfunction