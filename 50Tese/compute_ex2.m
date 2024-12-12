clc, clear all
run '../../../startup'
close all

pc = 0.96;
t = linspace(-2*pi,2*pi,200);
X = exp(i*pi*t);
Y = real(X);
[ modes lambdas sigmas r ] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);

cd ../Plots
save 'ex2'