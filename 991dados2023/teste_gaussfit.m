load 'dados_ordenados';

xdata= X(1,:);
x_1 = xdata(1:53);
x_2 = xdata(54:105);
t = linspace(1,52,52);
mu=0; sigma =0;
%[mu,sigma] = gaussfit(t,x_2);

%A = [t.^2;t;ones(size(t))];
b = log(x_2(:));
%x= A\b;
z = polyfit(t,x_2,2) % z = [P Q R]
sigma = sqrt(-1/2/z(1));