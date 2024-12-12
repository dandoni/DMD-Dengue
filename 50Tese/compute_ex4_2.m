clc, clear all
run '../../../startup'
close all


pc = 0.96;
L = 500;
t = linspace(-2*pi,2*pi,L);
dt = t(2) - t(1);
Fs = 1/dt;
Ts = dt;

X = cos(3*pi*t);   
Y = fft(X);

df = Fs/L; # spacing between samples on freq. axis
min_f = -Fs/2; # min freq. for which fft is calculated
max_f = Fs/2 - df; # max freq. for which fft is calculated
f = [min_f : df : max_f]; # horizontal values
size(f) # should equal N
y = abs(fftshift(Y)); # ma


Z = compute_complex_data(X);


Y2 = fft(Z);
y2 = abs(fftshift(Y2)); # magnitude of shifted spectrum
[ modes lambdas sigmas r b] = compute_dmd_b(Z,pc);
b = modes\Z(1);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im_b( Z, modes, lambdas, b);
freq = log(lambdas)/dt/2/pi;

cd ../Plots
save 'ex4_2.hdf5' '-hdf5'