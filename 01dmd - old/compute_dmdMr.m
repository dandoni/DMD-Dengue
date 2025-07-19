function tree = compute_dmdMr(X,dt,r,max_cyc,L)
 global erro 
  erro=erro+1;

  % Inputs
  % X          n by m matrix of data
  %            n measurements, m snapshots
  % dt         fixed time step
  % r          rank of truncation  (Se colocar a energia vai variar por recursao, nao sei o que é melhor no caso)
  % max_cyc    To determine rho, the freq cutoof, compute oscillations of max_cyc in the time window
  % L          number of levels remaining in the recursion 
  %            the first entry of L should be the last level
  
  %Ao que parece o max_cyc é a maior frequencia obtida nos dados
  
   % Normalization of dataset - This operation will be undone on the modes
  %------------------------------------------------------------------------------%
  
##  X_mean = mean(X(:));    X = X - X_mean;           Tive problema com divisao por 0
##  X_max = max(abs(X(:))); X = X / X_max;
  
  %--------------------------------------------------------------------------
  
  T = size(X,2) * dt;
  rho = max_cyc/T;              %cutoff of freq at this level
  sub = ceil(1/rho/8/pi/dt);     %4xNyquist for rho  (Algum criterio de estabilidade)
  
  %--------------------------------------------------------------------------
  
  %DMD
  % Subsample used 
    Xaug = X(:,1:sub:end);                 
    Xaug = [Xaug(1,1:end-1); Xaug(:,2:end)]; 
    X1 = Xaug(:,1:end-1);
    X2 = Xaug(:,2:end);
  
  % Perform SVD
   [U, S, V] =svd(X1, 'econ');           
    r = min(size(U,2),r);
  
  % Rank trunkation
    U = U(:, 1:r);                         
    S = S(1:r, 1:r);
    V = V(:, 1:r);
  % Computing Ã
    InvS = diag( 1./diag(S) );           
    A  = X2 * V * InvS * U';
    At = U' * X2 * V * InvS;
  
  % Computing eigenvalues and dynamic modes
    [W, L1] = eig(At); 
    
    L1 = diag( L1 );
    aa = abs( L1 );
    
    [ ll ii ] = sort( aa, 'descend' );
    
    lambdas = L1(ii);
    
   modes = X2 * V * InvS * W(:,ii);
##    modes = ( modes * X_max ) + X_mean;
%--------------------------------------------------------------------------
    
   %Power of modes
  Vand = zeros(r, size(X1,2));  %Vandermonde Matrix 
  
  for k=1:size(X:2),
    Vand(:,k) = lambdas.^(k-1);
  endfor
  
  %Linhas do artivo Jovanovic et al,2014
    G = S*V';
    P = (W'*W).*conj(Vand*Vand');
    q = conj(diag(Vand*G'*W));
    P1 = chol(P,'lower');
    b = (P1')\(P1\q);  %Optimal Vecotr of amplitudes b   
    
  ## Ao que parece é uma forma mais esperta de tomar o vetor b, mas não entendi
  ## pretendo procurar ainda
     
  %Consolidate slow modes, where abs(omega) < rho
    omegas = log(lambdas)/sub/dt/2/pi;
    mymodes = find(abs(omegas) <= rho);

  %Preparating for recursion
  %Saving data for actual level
    thislevel.T = T;
    thislevel.rho = rho;
    thislevel.hit = numel(mymodes)> 0;
    thislevel.omegas = omegas(mymodes);
    thislevel.P = abs(b(mymodes));
    thislevel.Modes = modes(:,mymodes);

  %Recurse on halves
  
  if L > 1,
    sep = floor(size(X,2)/2);
    nextlevel1 = compute_dmdMr(X(:,1:sep),dt,r,max_cyc,L-1);
    nextlevel2 = compute_dmdMr(X(:,sep+1:end),dt,r,max_cyc,L-1);
  else
    nextlevel1 = cell(0);
    nextlevel2 = cell(0);
  endif
  
   %reconcile indexing on output
  ## Ele faz isso pq o Matlab nao suporta recursao em estruturas de dados
  tree = cell(L,2^(L-1));
  tree{1,1} = thislevel;
  
  for l = 2:L
    col = 1;
    for j= 1:2^(l-2),
      tree{l,col} = nextlevel1{l-1,j};
      col = col + 1;
    endfor
    for j=1:2^(l-2),
      tree{l,col} = nextlevel2{l-1,j};
      col = col + 1;
    endfor
   endfor
        
endfunction
