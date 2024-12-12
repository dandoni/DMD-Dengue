clc, clear all, close all

% Presentation information
latexdir = 'exemplo_7';
filename = 'exemplo_7.tex'; 
ptitle   = 'Exemplo 7'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex', 'size', [14 4.5] );  %figuras geradas direto em pdf

% Load File

load 'ex7'

plot(t(50:150),real(X(1,50:150)))
hold on 
plot(t(50:150),real(X(2,50:150)),'color','green')
axis('tight')
legend('$x=1$','$x=2$');
xlabel('t')
tex = latex_add_fig( tex, "dado", "dadosex7");
clf
close all
latex_compile(tex,'batchmode');