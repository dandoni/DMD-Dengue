function plot_fase_faixa
clc, clear all
run '../../../startup'
close all

load 'dengue.hdf5'

% Presentation information
latexdir = 'Dengue fase faixa';
filename = 'teste_100k.tex'; 
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
                                 'size',   [15 4] );

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
