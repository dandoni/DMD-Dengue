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
latexdir = 'Dengue 100k 4 mapas';
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

 
pop = pop(ind_cod);
ind_100 = find(pop >= 30000);

X1 = arg(modo(:,1));
X1 = X1 .+ pi;
X1 = X1 ./(2*pi);
X1 = 1- X1;
X1 = X1(ind_cod_o);
Y1 = X1(ind_100);

##map.cities.code6 = map.cities.code6(indice_ordenacaao); 
##map.cities.code7 = map.cities.code7(indice_ordenacaao);
##map.cities.x =  map.cities.x(indice_ordenacaao); 
##map.cities.y =  map.cities.y(indice_ordenacaao);

##jj = indice_ordenacaao;
jj = ind_cod;
jj(ind_100) = [];
map.cities.code6(jj) =[];
map.cities.code7(jj) = [];
map.cities.x(jj) = [];
map.cities.y(jj) = [];

jet4 = jet(4);
for ii=1:4
 subplot(2,2,ii)
[j] = find(Y1 > 0.25*(ii-1) & Y1 <= 0.25*ii);
mapa = map;
mapa.cities.code6 = map.cities.code6(j);
mapa.cities.code7 = map.cities.code7(j);
mapa.cities.x     = map.cities.x(j);
mapa.cities.y     = map.cities.y(j);
Y = Y1 (j);

plot_brazil_cities_sizes(mapa,Y,0.3,2);
colormap(flipud(jet))
##colormap(summer)
colo = colorbar;
##hp4 = get(subplot(2,2,4),'Position')
##colo = colorbar
##set(colo,'Position', [hp4(1)+hp4(3)+0.01  hp4(2)  0.1  hp4(2)+hp4(3)*2.1])
set(colo,'Position', [0.9  0.11  0.031 0.8])
caxis([0,1])
set(colo,'Ytick',0:0.5:1)
##set (gca,'position',[0.0800   0.120000   0.90000   0.8700]) 
##tex = latex_add_fig(tex,"distrib fase 2", sprintf('dfase_brasil2%d',ii),'box','on');
##tex = latex_add_fig(tex,"distrib fase", sprintf('dfase_brasil%d',ii));
##clf
clear Z
if ii == 1 |ii == 2
 codigo = mapa.cities.code6
end

end
##set (gca,'position',[0.0800   0.120000   0.90000   0.8700]) 
##hp4 = get(subplot(2,2,4),'Position')
##colo = colorbar
##set(colo,'Position', [0.6+0.3+0.01  0.11  0.1  0.11+0.3*2.1])
##caxis([0,1])
##set(colo,'Ytick',0:0.5:1)
tex = latex_add_fig(tex,"distrib fase 2", "dfase_brasil1",'box','on');
tex = latex_add_fig(tex,"distrib fase", "dfase_brasil12");
clf


plot_brazil_cities( map, Y1 );
colorbar
caxis([0,1])
set (gca,'position',[0.0800   0.120000   0.90000   0.8700]) 
tex = latex_add_fig(tex,"distrib fase 2", "dfase_brasil2",'box','on');
tex = latex_add_fig(tex,"distrib fase", "dfase_brasil");
clf

colormap(flipud(jet4))

close all
latex_compile(tex,'batchmode');
endfunction