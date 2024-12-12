function plot_ex2_hdf5
clc, clear all
run '../../../startup'
close all

% Presentation information
latexdir = 'exemplo_2';
filename = 'exemplo_2.tex'; 
ptitle   = 'Exemplo 2'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex',
                                    'device', '-dpdflatex' ,
                                    'size',   [15 3] );
  
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
  
% Load File

load 'ex2.hdf5'

plot(t(50:150),Y(50:150))
hold on
plot(t(50:150),imag(X)(50:150),'color','r')
plot_axis_setup()

h = legend("$(f(t))$","$(f(t))$");
set( h, 'orientation', 'horizontal',
          'position', [ 0.52 0.83 0.45 0.12 ] )  
          
tex = latex_add_fig(tex,"f(t)", "exemplo2_cap3");
clf


plot(t(50:150),Y(50:150),'linewidth',0.2)
hold on
plot(t(50:150),real(X_dmd)(50:150),'--','color','b')
plot(t(50:150),imag(X)(50:150),'color','r','linewidth',0.2)
plot(t(50:150),imag(X_dmd)(50:150),'--','color','r')
plot_axis_setup()
title("");

h =legend("$(f(t)$", " DMD ", ' $f(t)$', " DMD" )
set( h, 'orientation', 'horizontal',
 'position', [ 0.1 0.9 0.85 0.1 ]) 

tex = latex_add_fig(tex,"Rec", "rec_cap3");
clf

function plot_axis_setup()


axis([-pi,pi,-1,1])
xlabel('$t$')
yticks([-1:1:1])

set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  
    
endfunction


close all
latex_compile(tex,'batchmode');

endfunction