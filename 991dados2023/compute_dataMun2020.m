
 csv = 'Dengue2020mun.csv';                  % Nome da planilha de dados

 x = dlmread(csv,";",0,0);
 
 x = x';
 
 cod2020 = x(1:end,1);

 X2020 = x(1:end,3:end-1);
 
 
 save dataMun2020.hdf5
 
