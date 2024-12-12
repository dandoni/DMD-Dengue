clc, clear all, close all

% Presentation information
latexdir = 'exemplo_5';
filename = 'exemplo_5.tex'; 
ptitle   = 'Exemplo 5'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex', 'size', [7 4.5]);  %figuras geradas direto em pdf

% Load File

load 'ex5'

plot(t(50:150),X(50:150))
hold on
plot(t(50:150),real(X_dmd)(50:150),'--','color','b')
legend("$f(t)$", "DMD") ;
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"Parte Real", "ex5_rec1_cap3");
clf

plot(t(50:150),imag(X)(50:150),'color','r')
hold on
plot(t(50:150),imag(X_dmd)(50:150),'--','color','r')
legend("\Imag(f(t))", "DMD - Parte Imaginaria") ;
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"Parte Imaginaria", "ex5_rec2_cap3");
clf



imagesc (t(50:150),xi,real(X2)(:,50:150))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "real X", "ex5_rec3_cap3");
clf

imagesc (t(50:150),xi,real(Y_dmd)(:,50:150))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "real rec X", "ex5_rec4_cap3");
clf


imagesc (t(50:150),xi,imag(X2)(:,(50:150)))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "imag X", "ex5_rec5_cap3");
clf

imagesc (t(50:150),xi,imag(Y_dmd)(:,(50:150)))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "real rec X", "ex5_rec6_cap3");
clf


close all
latex_compile(tex,'batchmode');