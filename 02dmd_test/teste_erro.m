run '../startup'
pc = 0.96;

t = linspace(0,6*pi,500);
X = sin(pi*0.1*t);
Y = compute_complex_data(X);

[ modes lambdas sigmas r] = compute_dmd(Y,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction( X, modes, lambdas);
Y_dmd = real(X_dmd(1,:,end));


plot(X)
hold on
plot(Y_dmd)