function plot_dengue_hdf5
clc, clear all
run '../../startup'
close all

load 'dengue_proj2023.hdf5'

% Presentation information
latexdir = 'Dengue';
filename = 'exemplo_1_latex.tex'; 
ptitle   = 'Dengue'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 5] );


plot(brasil.X./1000)
ylabel("Casos (em milhares)")
plot_axis_setup()
grid on

tex = latex_add_fig(tex,"dengue brasil", "dengue_brasil",'box','on');
clf


imagesc(X_o(:,num_sem))
plot_axis_setup()
ylabel("Cidades")
##yticklabels([])
yticks([])
colorbar
caxis([0,50])
colormap(cmap_wgbr)
tex = latex_add_fig(tex,"dengue colormap", "dengue_colormap",'box','on');
clf

h = semilogy(sigmas)
set (gca,'position',[0.0700   0.30000   0.90000   0.6500]) 
set(gca,'ytick',10.^[0:-4:-20])
set(gca,'yminortick', 'off')
xlabel('Valores Singulares')
xlim([0,num_sem] )
hold on 
plot([0,num_sem],[1e-16,1e-16],'--')
tex = latex_add_fig(tex,"dengue sigmas", "dengue_sigmas");
clf




tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [6.5 5] ) ; 

imagesc(real(Y_o(:,num_sem)))
plot_axis_setup2()
ylabel("Cidades")

tex = latex_add_fig(tex,"dengue dadofinal", "dengue_dadofinal1");
clf


imagesc(imag(Y_o(:,num_sem)))
plot_axis_setup2()
colorbar
set(gca,'ytick',[])

tex = latex_add_fig(tex,"dengue dadofinal", "dengue_dadofinal2");
clf





imagesc(real(Y_o(:,num_sem)))
plot_axis_setup2()
ylabel("Cidades")
tex = latex_add_fig(tex,"dengue dadofinal", "dengue_rec1");
clf


imagesc(real(X_dmd(:,num_sem)))
plot_axis_setup2()
##set(gca,'ytick',[])
ylabel("Cidades")
colorbar
tex = latex_add_fig(tex,"dengue dadofinal", "dengue_rec2");
clf

e = abs(real(X_dmd(:,1:num_sem))-real(Y_o));
maxi = max(e(:));
e = e./maxi;
imagesc(e, 'cdatamapping', 'scaled' )
##image( x, y, f,)
plot_axis_setup3()
h = colorbar
##aux = get(h, 'yticklabel');
##for ii = 1:5
##  tick_eixo(ii) = str2num(aux(ii){1,1});
##  auxi(ii) = maxi;
##end
##tick_eixoc(1:5) = 0;
##tick_eixoc(2:end) = auxi(2:end).*tick_eixo(2:end);
caxis_max = 4e-9 / maxi;
caxis([0,caxis_max])
ticks = linspace(0,4,5) * caxis_max /4
set(h,'ytick', ticks)
tick_eixoc = ticks * maxi;
set(h, 'yticklabel', tick_eixoc)
tex = latex_add_fig(tex,"dengue dadofinal", "dengue_erro");
clf




function plot_axis_setup()
set (gca,'position',[0.0800   0.220000   0.90000   0.6700]) 
xticks([0 53 105 157 209 261 313 365 417]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020','2021','2022'})
xlim([0, 419] )
endfunction 



function plot_axis_setup2()
set (gca,'position',[0.100   0.30000   0.85000   0.6500]) 
xticks([0 53 105 157 209 261 313 365 419]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020','2021','2022'})
xlim([0,419] )
colormap(cmap_wgbr)

caxis([0,50])
set(gca, 'fontsize', 8)
endfunction 

function plot_axis_setup3()
set (gca,'position',[0.100   0.30000   0.85000   0.6500]) 
xticks([0 53 105 157 209 261 313 365 417]) 
xticklabels({'2014',"2015","2016","2017","2018","2019",'2020','2021','2022'})
xlim([0,419] )
colormap(cmap_wgbr)
##colormap(jet)#h = colorbar;
##set(gca,'clim',[0,1E-10])
caxis([0,0.01])
##set(h,'ylim', [0,9E-11]);
##h = axes('CLim', [-12, 12]);
##hcb = colorbar('peer', h);
##set(hcb, 'YTick', [-12:3:12], 'YTickLabel', {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'});

set(gca,'ytick',[])
set(gca, 'fontsize', 8)
endfunction 

close all
latex_compile(tex,'batchmode');
endfunction