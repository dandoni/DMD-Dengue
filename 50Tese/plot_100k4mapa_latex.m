function plot_100k4mapa_latex
clc, clear all
run '../../../startup'
close all

load pop.hdf5
load dengue_2.hdf5
load indice_ordenacao.hdf5
load indice_cod_pop.hdf5  %ind_cod com a ordem da populaçao e do map por codigo da cidade
load indice_cod_dado.hdf5 %ind_cod_o com a ordem dos modos por codigo da cidade

% Presentation information
latexdir = 'Dengue 30k 4 mapas latex';
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
                                 'size',   [6.5 4] );

 
pop = pop(ind_cod);
ind_100 = find(pop >= 50000);
X1 = arg(modo(:,1));
X1 = X1 .+ pi;
X1 = X1 ./(2*pi);
X1 = 1- X1;
X1 = X1(ind_cod_o);
Y1 = X1(ind_100);
jj = ind_cod;
jj(ind_100) = [];
map.cities.code6(jj) =[];
map.cities.code7(jj) = [];
map.cities.x(jj) = [];
map.cities.y(jj) = [];
jet4 = jet(4);


for ii=1:4
[j] = find(Y1 > 0.25*(ii-1) & Y1 <= 0.25*ii);
mapa = map;
mapa.cities.code6 = map.cities.code6(j);
mapa.cities.code7 = map.cities.code7(j);
mapa.cities.x     = map.cities.x(j);
mapa.cities.y     = map.cities.y(j);
Y = Y1 (j);

plot_brazil_cities_sizes(mapa,Y,0.3,2);
colormap(flipud(jet))
caxis([0,1])
clear Z
set (gca,'position',[0.0100   0.080000   0.90000   0.8700]) 
tex = latex_add_fig(tex,"distrib fase 2", sprintf('dfase_faixa%d',ii),'box','on');
tex = latex_add_fig(tex,"distrib fase", sprintf('dfase_faixa%d',ii));
clf
end



 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 4] );



plot_brazil_cities( map, Y1 );
colormap(flipud(jet))
colo =  colorbar
caxis([0,1])
set(colo,'Ytick',0:0.5:1)
set (gca,'position',[0   0.120000   0.90000   0.8700]) 
tex = latex_add_fig(tex,"distrib fase 2", "dfase_brasil2",'box','on');
tex = latex_add_fig(tex,"distrib fase", "dfase_brasil");
clf



close all
latex_compile(tex,'batchmode');
endfunction