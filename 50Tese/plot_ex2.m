clc, clear all, close all

% Presentation information
latexdir = 'exemplo_2';
filename = 'exemplo_2.tex'; 
ptitle   = 'Exemplo 2'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex' , 'size', [14 4.5]);  %figuras geradas direto em pdf

% Load File

load 'ex2'

plot(t(50:150),Y(50:150))
hold on
plot(t(50:150),imag(X)(50:150))
legend("\Real (f(t))","\Imag(f(t))");
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"f(t)", "exemplo2_cap3");
clf

plot(t(50:150),Y(50:150))
hold on
plot(t(50:150),real(X_dmd)(50:150),'--','color','b')
legend("\Real (f(t))", "DMD - Parte Real") ;
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"Parte Real", "parte_real_cap3");
clf

plot(t(50:150),imag(X)(50:150),'color','r')
hold on
plot(t(50:150),imag(X_dmd)(50:150),'--','color','r')
legend("\Imag(f(t))", "DMD - Parte Imaginaria") ;
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"Parte Imaginaria", "parte_imag_cap3");
clf

plot(t(50:150),Y(50:150))
hold on
plot(t(50:150),real(X_dmd)(50:150),'--','color','b')
hold on
plot(t(50:150),imag(X)(50:150),'color','r')
hold on
plot(t(50:150),imag(X_dmd)(50:150),'--','color','r')
hold on
legend("\Real (f(t))", "DMD - Parte Real","\Imag(f(t))", "DMD - Parte Imaginaria") ;
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"Rec", "rec_cap3");
clf

close all
latex_compile(tex,'batchmode');

