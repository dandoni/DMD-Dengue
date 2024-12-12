 run '../../startup' 
 clear all
 load 'dataMun';
 load 'dataMun2020.hdf5';
 load 'dataMun2021.hdf5';
 
 %Para automatizar da pra transformar aqui em função que recebe os dados de um ano e concatena
 % Unico cuidado é conferir se cod - codAno = 0 
 X = X';
 X = cat(2,X,X2020); 
 X = cat(2,X,X2021);
 %X = cat(2,X,X2022);
 num_sem = size(X,2);
 sem = linspace(1,num_sem,num_sem);
 
 save dataMun2020.hdf5