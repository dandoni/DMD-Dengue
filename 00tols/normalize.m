function [X d]= normalize(X)  
  X_mean = mean(X(:));    X = X - X_mean;
  d(1) =X_mean;
  X_max = max(abs(X(:))); X = X / X_max;
  d(2) = X_max;
endfunction
