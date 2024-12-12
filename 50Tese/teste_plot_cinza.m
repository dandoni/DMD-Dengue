load dengue_2.hdf5

modo(:,1) = coef(:,152); % 1 ano
modo(:,2) = coef(:,2);   % 3 anos
X1 = arg(modo(:,1));
X2 = arg(modo(:,2));

corte = [1500, 253];

map1 = map;
map1.cities.code6(corte(1)+1:end) = []; map1.cities.code7(corte(1)+1:end) = [];
map1.cities.x(corte(1)+1:end) = []; map1.cities.y(corte(1)+1:end) = [];
Y1 = X1(1:corte(1));
plot_brazil_cities( map1, Y1 );
colormap(gray)
hold on

map2 = map;
map2.cities.code6(1:corte(1)) = []; map2.cities.code7(1:corte(1)) = [];
map2.cities.x(1:corte(1)) = []; map2.cities.y(1:corte(1)) = [];
Y2 = X1(corte(1)+1:end);
plot_brazil_cities( map2, Y2 );