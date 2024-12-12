run '../startup'  
xlsx = 'Pop_cid.xlsx'; 
xls = xlsopen(xlsx, 0 ,'oct');

mun = xls2oct( xls, 'Pop_cid', [ 'A4:A5573'] )  ;
pop = xls2oct (xls, 'Pop_cid', [ 'B4:B5573'] )  ;

save -hdf5  PopMun 