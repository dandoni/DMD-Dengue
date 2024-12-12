
function S_vec = biogrid_scatter( P_vec, scatter )

% Population scattering function

%------------------------------------------------------------------------------%

global param;

ii = 1:(param.Nx-1);
jj = 1:(param.Ny-1);

ip = ii + 1;
jp = jj + 1;

P = reshape( P_vec, param.Nx, param.Ny );
S = zeros  (        param.Nx, param.Ny );

S(ii,jj) =            scatter(1,1) * P(ip,jp);
S(ii, :) = S(ii, :) + scatter(2,1) * P(ip,: );
S(ii,jp) = S(ii,jp) + scatter(3,1) * P(ip,jj);

S( :,jj) = S( :,jj) + scatter(1,2) * P( :,jp);
S( :, :) = S( :, :) + scatter(2,2) * P( :,: );
S( :,jp) = S( :,jp) + scatter(3,2) * P( :,jj);

S(ip,jj) = S(ip,jj) + scatter(1,3) * P(ii,jp);
S(ip, :) = S(ip, :) + scatter(2,3) * P(ii,: );
S(ip,jp) = S(ip,jp) + scatter(3,3) * P(ii,jj);

S_vec = S(:);

%------------------------------------------------------------------------------%
