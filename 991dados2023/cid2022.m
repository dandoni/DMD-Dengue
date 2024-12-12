%compute cid_2022
clc, clear all
load 'dataMun2022.hdf5';

ind(1) = find ( cod2022 == 313670 );
ind(2) = find ( cod2022 == 355030 );
ind(3) = find ( cod2022 == 330455 );
ind(4) = find ( cod2022 == 500270 );

cid2022 = X2022(ind,:);

save cid2022.hdf5