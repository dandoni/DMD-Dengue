run '../../startup'  
##xlsx = 'Pop_cid.xlsx'; 
##
##xls = xlsopen(xlsx, 0 ,'oct');
##
##mun = xls2oct( xls, 'Pop_cid', [ 'A4:A5573'] )  ;
##pop = xls2oct (xls, 'Pop_cid', [ 'B4:B5573'] )  ;

csv = 'Pop_cid.csv';
a = dlmread(csv,";",0,0);
a = a(1:5570,1:2);
a = sortrows(a);

pop=a(:,2);
mun=a(:,1);

save -hdf5  PopMun 