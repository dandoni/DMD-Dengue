clc, clear all, close all

% Presentation information
latexdir = 'exemplo_6';
filename = 'exemplo_6.tex'; 
ptitle   = 'Exemplo 6'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex' , 'size', [7 4.5]);  %figuras geradas direto em pdf

% Load File

load 'ex6'

imagesc (t(50:150),xi,real(X)(:,50:150))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "real X", "ex6_rec_cap3");
clf

imagesc (t(50:150),xi,real(X_dmd)(:,50:150))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "real rec X", "ex6_rec2_cap3");
clf


imagesc (t(50:150),xi,imag(X)(:,50:150))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "imag X", "ex6_rec3_cap3");
clf

imagesc (t(50:150),xi,imag(X_dmd)(:,50:150))
colormap(cmap_rwb); colorbar
caxis([-2,2])
axis('tight')
xlabel("t"), ylabel("x")
tex = latex_add_fig( tex, "real rec X", "ex6_rec4_cap3");
clf


close all
latex_compile(tex,'batchmode');