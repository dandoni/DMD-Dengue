#teste_plot_100k

load pop.hdf5
load dengue_2.hdf5
load indice_ordenacao.hdf5

pop = pop(indice_ordenacaao);
ind_100 = find(pop >= 30000);

map.cities.code6 = map.cities.code6(indice_ordenacaao); map.cities.code7 = map.cities.code7(indice_ordenacaao);
map.cities.x =  map.cities.x(indice_ordenacaao); map.cities.y =  map.cities.y(indice_ordenacaao);

X1 = arg(modo(:,1));
X2 = arg(modo(:,2));
jj = 1:5570;
jj(ind_100) = [];


map1 = map;
map1.cities.code6(jj) = []; map1.cities.code7(jj) = [];
map1.cities.x(jj) = []; map1.cities.y(jj) = [];
Y1 = X1(ind_100);
plot_brazil_cities( map1, Y1 );
colormap(jet)
colorbar


ind_100 = find(pop >= 100000);


X1 = arg(modo(:,1));
X2 = arg(modo(:,2));
jj = 1:5570;
jj(ind_100) = [];


map1 = map;
map1.cities.code6(jj) = []; map1.cities.code7(jj) = [];
map1.cities.x(jj) = []; map1.cities.y(jj) = [];
Y1 = X1(ind_100);
plot_brazil_cities( map1, Y1 );
colormap(jet)
colorbar



map2 = map;
map2.cities.code6(1:corte(1)) = []; map2.cities.code7(1:corte(1)) = [];
map2.cities.x(1:corte(1)) = []; map2.cities.y(1:corte(1)) = [];
Y2 = X1(corte(1)+1:end);
plot_brazil_cities( map2, Y2 );