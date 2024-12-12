load dados_ordenar.hdf5

total = sum ( X , 2 );
[ Total ind ] = sort ( total );

X_o = X ( ind , : );
cod_o = cod(ind);