clc, clear all
run '../../../startup'
close all

pc = 0.96;

t = linspace(-2*pi,2*pi,500);
dt = t(2) - t(1);
X = exp(i*pi*t)+exp(4*i*pi*t);
[X d]= normalize(X);
[ modes lambdas sigmas r ] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
freq = log(lambdas)/dt/2/pi;
X = denormalize(X,d);
X_dmd = denormalize(X_dmd,d);



xi = linspace(-10,10,100);
[Xgrid,T] = meshgrid(xi,t);
X2 = ( sech( Xgrid+3 ) .* ( exp(i*pi*T) + +exp(4*i*pi*T) ) )';
[X2 d2]= normalize(X2);


[ modes2 lambdas2 sigmas2 r2 ] = compute_dmd(X2,pc);
[ Y_dmd e_dmd ] = compute_dmd_reconstruction_im( X2, modes2, lambdas2);
freq2 = log(lambdas2)/dt/2/pi;
X2 = denormalize(X2,d2);
Y_dmd = denormalize(Y_dmd,d2);

cd ../Plots
save 'ex5.hdf5' -hdf5