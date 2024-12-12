function [ Y ] = compute_complex_data( X )
  
% Compute frequency domain

X_t = fft(X,[],2);

% Define cutoff

c_off = ceil(size(X,2)/2 + 1);

% Build auxiliar data

Y_t = X_t;
Y_t(:,c_off:end) = 0;

Y_t1 = zeros(size(X));
Y_t2 = Y_t1;
Y_t1(:,1) = Y_t(:,1);
Y_t2(:,2:end) = Y_t(:,2:end);


% Return to time domain
aux = ifft(Y_t1,[],2);
Y = aux;
aux = 2*ifft(Y_t2,[],2);
Y = Y +aux;  %% Correction factor because of lack of sum of sines

endfunction
