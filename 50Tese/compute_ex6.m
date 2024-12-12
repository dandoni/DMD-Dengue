clc, clear all
run '../../../startup'
close all


pc = 0.96;

t = linspace(-2*pi,2*pi,200);
dt = t(2) - t(1);
xi = linspace(-10,10,100);
[Xgrid,T] = meshgrid(xi,t);
X = ( sech( Xgrid+3 ) .* ( exp(i*pi*T)) + sech( Xgrid+1 ).*exp(4*i*pi*T) )';
[X d]= normalize(X);
[ modes lambdas sigmas r ] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
X_dmd = X_dmd(:,:,end);
freq = log(lambdas)/dt/2/pi;
X = denormalize(X,d);
X_dmd = denormalize(X_dmd,d);

cd ../Plots
save 'ex6'
