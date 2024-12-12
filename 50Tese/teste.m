clc, clear all
run '../../../startup'
close all

load 'dengue.hdf5'

ano1 = 152;

modo = modes(:,ano1);
lambda = lambdas(ano1);
b_certo = b(:,ano1);
coef = coef(:,ano1);
fase = arg(coef);
fase = fase .+ pi;
fase = fase ./(2*pi);
[fase_ord ij] = sort(fase);
ind_v = sort(ij);
X_dmdf = X_dmd(ij,:);
X_dmd1 = X_dmdf(1:3906,:); X_dmd2 =  X_dmdf(3907:5402,:);X_dmd3 =  X_dmdf(5403:5501,:);X_dmd4 =  X_dmdf(5502:end,:);

subplot(4,1,1)
imagesc(real(X_dmd1))
caxis([0,10])
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
subplot(4,1,2)
imagesc(real(X_dmd2))
caxis([0,50])
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
subplot(4,1,3)
imagesc(real(X_dmd3))
caxis([0,50])
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})

subplot(4,1,4)
imagesc(real(X_dmd4))
caxis([0,100])
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
