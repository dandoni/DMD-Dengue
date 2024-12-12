function plot_ex0_hdf5
clc, clear all
run '../../../startup'
close all
load 'ex0.hdf5'

% Presentation information
latexdir = 'exemplo_0';
filename = 'exemplo1.tex'; 
ptitle   = 'Exemplo 0'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
  
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
  
figure_position(1,2,2,1);
  
 


% Adding text for context
tex = latex_add_content( tex, '\clearpage\blindtext' );


% Figures that go alone  
  
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 3] );
                                 
plot(t,X)
hold on
plot(t,X1, '--', 'color', 'b')
  set (gca,'position',[0.1000   0.15000   0.85000   0.6500])  
xlabel('t')
h = legend('Original', 'Reconstruído');
set( h, 'orientation', 'horizontal',
        'position', [ 0.15 0.9 0.77 0.1 ]) 
axis('tight')
tex = latex_add_fig(tex," ", "exemplo0_cap2");
clf         

plot(t,Y)
hold on
plot(t,Y1, '--', 'color', 'b')
  set (gca,'position',[0.1000   0.15000   0.85000   0.6500])  
xlabel('t')
h = legend('Original', 'Reconstruído');
set( h, 'orientation', 'horizontal',
        'position', [ 0.15 0.9 0.77 0.1 ]) 
axis('tight')
tex = latex_add_fig(tex," ", "exemplo01_cap2");
clf   

close all
latex_compile(tex,'batchmode');
