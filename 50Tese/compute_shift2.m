#compute_shift2
clc, clear all
run '../../../startup'
close all

pc = 0.96;
t = linspace(-2*pi,2*pi,500);
dt = t(2) - t(1);
X = cos(pi*t);
X = [X(:,1:end-1); X(:,2:end)];
[ modes lambdas sigmas r ] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
X_dmd = real(X_dmd(:,:,end));
freq = log(lambdas)/dt/2/pi;

cd ../Plots
save 'ex_shift2.hdf5' '-hdf5'