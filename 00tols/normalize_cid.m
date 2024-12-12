function X = normalize_cid(X) 
   
 for ii = 1:size(X,1) 
  X_mean = mean(X(ii,:));   
 
  X(ii,:) = X(ii,:) - X_mean;
  
  X_max = max(abs(X(ii,:)));  
  
  X_max( X_max < 1E-6 ) = 1;
  
  X(ii,:) = X(ii,:) / X_max;
  
 end
endfunction
