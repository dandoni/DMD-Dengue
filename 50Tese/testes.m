function compute_ex0
clc,clear all,close all;

x0 = 2;
t = 1:0.1:5;
X = x0*t;
Y = exp(t);

A1= compute_A(X);
A2= compute_A(Y);

X1(1) = x0;
Y1(1) = x0;
for ii =1:length(X)-1
X1(ii+1) =  A1*X1(ii);
Y1(ii+1) = A2*Y1(ii);
endfor


function A = compute_A(X)

X1 = X(1:end-1);
X2 = X(2:end);
[ U S V ] = svd(X1);
##InvS = 1/S(1);
S(1) = 1/S(1);
A = X2*V*S'*(U');

endfunction

save 'ex0'

endfunction