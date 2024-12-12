 run '../../startup' 
 clear all
 load dados2020.hdf5

 
 %isnum = cellfun(@isnumeric,pop);
 %Pop = [pop{isnum}]';
 Pop = repmat ( pop, 1, num_sem );
 X_c = X ./ Pop;
 
 clear isnum
 
 save dados_perCapita2020.hdf5