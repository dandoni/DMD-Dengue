function plot_100k_latex
clc, clear all
run '../../../startup'
close all

load pop.hdf5
load dengue_2.hdf5
load indice_ordenacao.hdf5

% Presentation information
latexdir = 'Dengue 100k';
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
                                 'size',   [15 4] );


pop = pop(indice_ordenacaao);
ind_100 = find(pop >= 100000);
jj = 1:5570;
jj = jj(indice_ordenacaao);
jj(ind_100) = [];
X1 = arg(modo(:,1));
X1 = X1 .+ pi;
X1 = X1 ./(2*pi);
X1 = 1- X1;
map1 = map;
map1.cities.code6(jj) = []; 
map1.cities.code7(jj) = [];
map1.cities.x(jj) = [];
 map1.cities.y(jj) = [];
Y1 = X1(ind_100);
plot_brazil_cities( map1, Y1 );
colormap(flipud(jet))
colorbar
caxis([0,1])
set (gca,'position',[0.0800   0.120000   0.90000   0.8700]) 
tex = latex_add_fig(tex,"distrib fase 2", "dfase_brasil2",'box','on');
tex = latex_add_fig(tex,"distrib fase", "dfase_brasil");
clf

close all
latex_compile(tex,'batchmode');
endfunction
