function plot_colorbar_lateral
clc, clear all
run '../../../startup'
close all

load pop.hdf5
load dengue_2.hdf5
load indice_ordenacao.hdf5
load indice_cod_pop.hdf5  %ind_cod com a ordem da populaçao e do map por codigo da cidade
load indice_cod_dado.hdf5 %ind_cod_o com a ordem dos modos por codigo da cidade

% Presentation information
latexdir = 'Colorbar Lateral';
filename = 'teste_100k.tex'; 
ptitle   = 'Dengue'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [1.5 8] );

 
colo = colorbar
colormap(flipud(jet))
axis('off')
set (gca,'position',[0.0800   0.120000   1   1]) 
set(colo,'Position', [0.17  0.055 0.3  .9])
caxis([0,1])
set(colo,'Ytick',0:0.5:1)
tex = latex_add_fig(tex,"distrib fase 2", "colorbar2",'box','on');
tex = latex_add_fig(tex,"distrib fase", "colorbar");
clf



close all
latex_compile(tex,'batchmode');
endfunction