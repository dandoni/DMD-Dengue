
function S_vec = biogrid_scatter_map( P_vec )

% Population scattering function

%------------------------------------------------------------------------------%

global param;

ii = 1:(param.Nx-1);
jj = 1:(param.Ny-1);

ip = ii + 1;
jp = jj + 1;

P = zeros( param.Nx, param.Ny );
S = zeros( param.Nx, param.Ny );

P(param.map_id) = P_vec;

S(ii,jj) =            param.scatter(1,1) * P(ip,jp);
S(ii, :) = S(ii, :) + param.scatter(2,1) * P(ip,: );
S(ii,jp) = S(ii,jp) + param.scatter(3,1) * P(ip,jj);

S( :,jj) = S( :,jj) + param.scatter(1,2) * P( :,jp);
S( :, :) = S( :, :) + param.scatter(2,2) * P( :,: );
S( :,jp) = S( :,jp) + param.scatter(3,2) * P( :,jj);

S(ip,jj) = S(ip,jj) + param.scatter(1,3) * P(ii,jp);
S(ip, :) = S(ip, :) + param.scatter(2,3) * P(ii,: );
S(ip,jp) = S(ip,jp) + param.scatter(3,3) * P(ii,jj);

S_vec = S(param.map_id);

%------------------------------------------------------------------------------%
