run '../../startup' 
clear all
load dados_perCapita2020.hdf5

total = sum ( X_c , 2 );
[ Total ind ] = sort ( total );

X_oc = X_c ( ind , : );
cod_oc = cod(ind);

total = sum ( X , 2 );
[ Total ind ] = sort ( total );

X_o = X ( ind , : );
cod_o = cod(ind);


clear total

save dados_ordenados2020.hdf5