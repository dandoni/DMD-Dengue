clc, clear all, close all

f = 60;  % Hz
tmin = -0.05;
tmax = 0.05;
t = linspace(tmin, tmax, 400);
x_c = cos(2*pi*f * t);

T = [1/70,1/120,1/140];
x_c2 = cos(2*pi*10 * t);
nmin = ceil(tmin / T(1));
nmax = floor(tmax / T(1));
n1= nmin:nmax;
x1 = cos(2*pi*f * n1*T(1));


%Mudar esse mumero que da os hz (70 basta pra dar errado)
nmin = ceil(tmin / T(2));
nmax = floor(tmax / T(2));
n2 = nmin:nmax;
x2 = cos(2*pi*f * n2*T(2));


nmin = ceil(tmin / T(3));
nmax = floor(tmax / T(3));
n3 = nmin:nmax;
x3 = cos(2*pi*f * n3*T(3));

cd ../Plots
save 'Nyquist'