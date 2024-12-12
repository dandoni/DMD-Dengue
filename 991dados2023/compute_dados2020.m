 run '../../startup' 
 
 load PopMun
 load dataMun2020.hdf5
 
 crit = 0;
 

 
 % Teste 1
 n = length(mun);
 m = length(cod);
  for ii = 1:n
    cod_pop(ii) = mun(ii); 
  end
 cod_pop = cod_pop';

 a = (cod_pop == cod);
 
 if (min(a) != 1)
   printf('Cidades Distintas')
 endif
  
 clear a
 clear n
 clear m
 clear ans
 clear cod_pop
 clear crit
 clear ii
 clear xls
 clear xlsx
 clear x
 clear csv
 
 semana_ano = [53,52,52,52,52,52,53,52]; 
 
 save dados2020.hdf5