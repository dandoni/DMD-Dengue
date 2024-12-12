function plot_dengue_hdf5
clc, clear all
run '../../../startup'
close all

load 'dengue.hdf5'

% Presentation information
latexdir = 'exemplo_1_latex';
filename = 'exemplo_1_latex.tex'; 
ptitle   = 'Exemplo 1'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 3] );


plot(brasil.X)
##xlabel("Ano")
ylabel("Número de casos")
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
grid on
tex = latex_add_fig(tex,"dengue_brasil", "dengue_brasil");
clf

plot(cid.X(1,:))
hold on
plot(cid.X(2,:))
hold on
plot(cid.X(3,:))
hold on
plot(cid.X(4,:))
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
##xlabel("Ano")
ylabel("Número de casos")
legend("JF", "SP", "RJ", "Goiania");
grid on
tex = latex_add_fig(tex,"dengue_cid", "dengue_cid");
clf


imagesc(X_o)
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
ylabel("Cidades")
colorbar
caxis([0,50])
colormap(cmap_wgbr)
tex = latex_add_fig(tex,"dengue_colormap", "dengue_colormap");
clf

subplot(1,2,1)
imagesc(real(Y_o))
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
ylabel("Cidades")
colorbar
caxis([0,50])
colormap(cmap_wgbr)

subplot(1,2,2)
imagesc(imag(Y_o))
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
ylabel("Cidades")
colorbar
caxis([0,50])
colormap(cmap_wgbr)
tex = latex_add_fig(tex,"dengue_dadofinal", "dengue_dadofinal");
clf


h = semilogy(sigmas)
set(gca,'ytick',10.^[0:-4:-20])
set(gca,'yminortick', 'off')
xlabel('Valores Singulares')
xlim([0,313] )
hold on 
plot([0,313],[1e-15,1e-15],'--')
hold on 
plot([0,313],[1e-11,1e-11],'--')
legend("Valores Singulares", "Zero Computacional", "Perda de precisão significativa")
tex = latex_add_fig(tex,"dengue_sigmas", "dengue_sigmas");
clf

subplot(1,2,1)
imagesc(real(Y_o))
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
ylabel("Cidades")
colorbar
caxis([0,50])
colormap(cmap_wgbr)
title("Dado Original")

subplot(1,2,2)
imagesc(real(X_dmd))
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
ylabel("Cidades")
colorbar
caxis([0,50])
colormap(cmap_wgbr)
title("Dado Reconstruido")
tex = latex_add_fig(tex,"dengue_rec", "dengue_rec");
clf


plot(cid.X(1,:))
hold on
plot(real(X_dmd(cid.ind_o(1),:)),'--')
hold on
plot(cid.X(2,:))
hold on
plot(real(X_dmd(cid.ind_o(2),:)),'--')
hold on
plot(cid.X(3,:))
hold on
plot(real(X_dmd(cid.ind_o(3),:)),'--')
hold on
plot(cid.X(4,:))
hold on
plot(real(X_dmd(cid.ind_o(4),:)),'--')
xticks([0 53 105 157 209 261 313]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020'})
xlim([0,313] )
##xlabel("Ano")
ylabel("Número de casos")
legend("JF","JF- DMD" ,"SP", "SP - DMD","RJ", "RJ - DMD","Goiania","Goiania - DMD");
grid on
tex = latex_add_fig(tex,"dengue_reccid", "dengue_reccid");
clf




close all
latex_compile(tex,'batchmode');
