clc, clear all
run '../../../startup'
close all


pc = 0.96;
t = linspace(-2*pi,2*pi,200);
dt = t(2) - t(1);
X(1,:) = exp(pi*i*t);
X(2,:) = exp( i*( pi*t+(pi/2) ) );
[ modes lambdas sigmas r] = compute_dmd(X,pc);
[ X_dmd E_dmd b] = compute_dmd_reconstruction_im_teste( X, modes, lambdas);
X_dmd = X_dmd(:,:,end);
freq = log(lambdas)/dt/2/pi;
coef = b*modes;
fase = imag(log(coef));
atraso_fase = mod(fase(2)-fase(1),2*pi);

cd ../Plots
save 'ex7'

