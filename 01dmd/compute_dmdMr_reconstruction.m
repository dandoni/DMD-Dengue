function [ X_dmd ] = compute_dmdMr_reconstruction(tree,dt)
  Tf=tree{1,1}.T;
  Nt=Tf/dt;
  T = linspace(0,Tf,Nt);
  L = length(tree(1,:));
  global contador;
  contador = 0;
      N= length(tree{1,1}.Modes(:,1));
      X_dmd=zeros(N,length(T));
      for iter=1:length(T) 
        for i=1:L
          for j=1:2^(i-1);
            if (T(iter) < j*T/(2^(i-1)) && T(iter)>=(j-1)*T/(2^(i-1)))
             X_dmd(:,iter)=X_dmd(:,iter)+tree{i,j}.Modes*(tree{i,j}.P.*exp(tree{i,j}.omegas*T(iter))); %(n sei como indexar)
           contador ++;
           endif
         endfor
       endfor
     endfor
endfunction
