clc, clear all, close all
run '../../../startup'
% Presentation information
latexdir = 'Dengue Rotina';
filename = 'dengue_rotina.tex'; 
ptitle   = 'Dengue Rotina'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 6] );
% Load File
load 'dengue_rotina.hdf5'

t = 1:length(sigmas);
h = plotyy(t,sigmas,t,erro_max,'semilogy','semilogy');
set (gca,'position',[0.1500   0.10000   0.70000   0.800]) 
set(h(1),'ytick',10.^[0:-4:-20])
set(h(2),'ytick',10.^[4:-2:-10])
set(h(1),'yminortick', 'off')
set(h(2),'yminortick', 'off')
##grid on
set (gca,'yminorgrid', 'off')
xlabel('Valores Singulares')
set(h(1), 'ylabel', 'Valor Singular')
set(h(2), 'ylabel', 'Erro Máximo')
hold on 
plot([0,313],[1e-16,1e-16],'-.','color', 'b');
tex = latex_add_fig(tex,"dengue sigmas", "dengue_sigmas",'box', 'on');
clf


##plot(time)
##xlabel('Valores Singulares')
##ylabel('Tempo de processamento (s)')
##axis('tight')
##tex = latex_add_fig(tex,"dengue_tempo", "dengue_tempo");
##clf

close all
latex_compile(tex,'batchmode');
