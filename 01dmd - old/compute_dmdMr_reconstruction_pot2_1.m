    function [ X_dmd ] = compute_dmdMr_reconstruction_pot2_1(tree,dt,L)
 %Calculating Parameters
  Tf=tree{1,1}.T;
  N = 0;
  ii = 1; jj=0;
  while (N==0)
    jj++;
    
    if jj>2^(ii-1) 
      jj=1; ii++;
      
      if ii>L
          error('Não existem modos');
      end
      
    end
    N = length(tree{ii,jj}.Modes(:,1));  
  end
     
     Nt=Tf/dt;
     Ns = Nt; % + 1;
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

