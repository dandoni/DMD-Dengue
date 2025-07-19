 #run '../../startup'


# change for last year
 load datamun2025.hdf5
 load PopMun


 isnum = cellfun(@isnumeric,pop);
 Pop = [pop{isnum}]';
 Pop = repmat ( Pop, 1, num_sem );
 X = X';
 X_c = X ./ Pop;

 clear isnum

 save dados_perCapita2025.hdf5
