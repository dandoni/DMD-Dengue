function [X]= denormalize(X,d) 
  
  X = X.*d(2);
  X = X+ d(1);
  
endfunction
