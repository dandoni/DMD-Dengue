clc, clear all
run '../../../startup'
close all

pc = 0.96;
t = linspace(-2*pi,2*pi,200);
dt = t(2) - t(1);
X = cos(pi*t);
[ modes lambdas sigmas r ] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
freq = log(lambdas)/dt/2/pi;

cd ../Plots
save 'ex3'