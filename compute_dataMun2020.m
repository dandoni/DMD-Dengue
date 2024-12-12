
 tic
 
 csv = 'Dengue2020mun.csv';                  % Nome da planilha de dados

 x = dlmread(csv,";",0,0);
 
 x = x';
 
 x = x(1:4,:);
  
 cod = x(1:end,1);

 
 save dataMun2020.hdf5
 
 toc