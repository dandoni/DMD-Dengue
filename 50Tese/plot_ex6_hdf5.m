function plot_ex6_hdf5
clc, clear all
run '../../../startup'
close all

load 'ex6.hdf5'
% Presentation information
latexdir = 'exemplo_6';
filename = 'exemplo_6.tex'; 
ptitle   = 'Exemplo 6'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [6.5 4] ) ;  


imagesc (t(50:150),xi,real(X)(:,50:150))
plot_axis_setup()
ylabel("x")
tex = latex_add_fig( tex, "real X", "ex6_rec_cap3");
clf

imagesc (t(50:150),xi,real(X_dmd)(:,50:150))
plot_axis_setup()
colorbar
set(gca,'ytick',[])
tex = latex_add_fig( tex, "real rec X", "ex6_rec2_cap3");
clf


imagesc (t(50:150),xi,imag(X)(:,50:150))
plot_axis_setup()
ylabel("x")

tex = latex_add_fig( tex, "imag X", "ex6_rec3_cap3");
clf

imagesc (t(50:150),xi,imag(X_dmd)(:,50:150))
plot_axis_setup()
colorbar
set(gca,'ytick',[])
tex = latex_add_fig( tex, "real rec X", "ex6_rec4_cap3");
clf


function plot_axis_setup()
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  ;
colormap(cmap_rwb);
xlabel("t")
caxis([-2,2])
endfunction 

close all
latex_compile(tex,'batchmode');
endfunction