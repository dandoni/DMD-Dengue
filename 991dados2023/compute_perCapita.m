 run '../startup' 
 
 load dados
 
 
 isnum = cellfun(@isnumeric,pop);
 Pop = [pop{isnum}]';
 Pop = repmat ( Pop, 1, 313 );
 X_c = X ./ Pop;
 
 clear isnum
 
 save dados_perCapita