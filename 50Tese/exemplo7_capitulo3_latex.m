clc, clear all
run '../startup'
close all


% Presentation information
latexdir = 'exemplo7_capitulo3_latex';
filename = 'exemplo7_capitulo3_latex.tex'; 
ptitle   = 'Exemplos CAP 3'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );

figure_position(1,2,2,1);

tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex' );  %figuras geradas direto em pdf

pc = 0.96;

t = linspace(-2*pi,2*pi,200);
dt = t(2) - t(1);

X(1,:) = exp(pi*i*t);
X(2,:) = exp(i*(pi*t-3));

[ modes lambdas sigmas r] = compute_dmd(X,pc);
[ X_dmd E_dmd b] = compute_dmd_reconstruction_im_teste( X, modes, lambdas);
X_dmd = X_dmd(:,:,end);
freq = log(lambdas)/dt/2/pi;


coef = b*modes;
fase = imag(coef);
atraso_fase = mod(fase(1)-fase(2),2*pi);
