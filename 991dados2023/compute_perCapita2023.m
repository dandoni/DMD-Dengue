 run '../startup' 
 
 load dados2023.hdf5
 
 
 isnum = cellfun(@isnumeric,pop);
 Pop = [pop{isnum}]';
 Pop = repmat ( Pop, 1, num_sem );
 X_c = X ./ Pop;
 
 clear isnum
 
 save dados_perCapita2023.hdf5