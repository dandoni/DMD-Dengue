clc, clear all
run '../../../startup'
close all

pc = 0.99;
t = linspace(-2*pi,2*pi,200);
dt = t(2)-t(1);
xi = linspace(-10,10,100);
[Xgrid,T] = meshgrid(xi,t);
X = ( sech( Xgrid+3 ) .* exp(i*pi*T) )';
##df = -sech(Xgrid).*tanh(Xgrid);
##X = ((sech(Xgrid)+i*df).*exp(i*pi*T    ))';

[ modes lambdas sigmas r ] = compute_dmd(X,pc);
[ X_dmd E_dmd b] = compute_dmd_reconstruction_im_teste( X, modes, lambdas);
ss = sigmas/sum(sigmas);
freq = log(lambdas)/dt/2/pi;
coef = b*modes;
fase = imag(log(coef));

cd ../Plots
save 'ex1.hdf5' '-hdf5'
