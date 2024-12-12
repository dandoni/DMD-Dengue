 run '../../startup' 
 
 load dados2021.hdf5
 
 
 isnum = cellfun(@isnumeric,pop);
 Pop = [pop{isnum}]';
 Pop = repmat ( Pop, 1, num_sem );
 X_c = X ./ Pop;
 
 clear isnum
 
 save dados_perCapita2022.hdf5