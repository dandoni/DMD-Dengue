function plot_ex1_hdf5_beamer
clc, clear all
run '../../../startup'
close all
load 'ex1.hdf5'


% Presentation information
latexdir = 'exemplo_1_beamer';
filename = 'exemplo1.tex'; 
ptitle   = 'Exemplo 1'; 
author   = 'Daniel Moraes Barbosa';


% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'pt' );

figure_position(1,2,2,1);

% Figures that go alone  
  
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 3] );
endfunction
