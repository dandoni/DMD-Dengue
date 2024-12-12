    function [ X_dmd ] = compute_dmdMr_reconstruction_pot2(tree,dt,L)
 %Calculating Parameters
      Tf=tree{1,1}.T;
  
##  for ii=1:L   
##    for jj=1:2^(ii-1)
##        if ~isempty (tree{ii,jj}.Modes(:,1))
##          N = length(tree{ii,jj}.Modes(:,1));
##          break                           %SO 1 BREAK?
##        endif
##       endfor
##     endfor
##   endfor
##    
  N = length(tree{1,1}.Modes(:,1));
     
     Nt=Tf/dt;
     Ns = Nt ;
     T = linspace(0,Tf,Ns);
     T = repmat(T,N,1);
 %--------------------------------------     
 %Generating Correct Sizes
      
      X_dmd=zeros(N,Ns);  
      
 %---------------------------------------     
 
      for ii=1:L    %Andar
        
        sp = (Ns/2^(ii-1))
        
        for jj=1:2^(ii-1)     %Partição
          arvore = tree{ii,jj};
          if isfield(arvore,"Modes")
          modes = tree{ii,jj}.Modes;
          b     = tree{ii,jj}.P;
          omega = tree{ii,jj}.omegas;
          
          si = (jj-1)*sp + 1;
          sf =  jj*sp;
          
          for nn=1:length(omega)  %Modo
            
            Mode = repmat(modes(:,nn),1,(sf-si)+1);
            
              X_dmd(:,si:sf)= X_dmd(:,si:sf) + ... 
              Mode*b(nn).*exp(omega(nn)*T(:,si:sf)/dt);   %/dt
           
          endfor
          endif
        endfor
      endfor
    endfunction

