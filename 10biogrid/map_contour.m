
function map_contour

global param;

map = ceil( param.map );
if( param.interpolate )
  map = ceil( interp2( map, 2 ) );
end

C = contourc( map', [ eps eps ] );

xx = C(1,:); 
yy = C(2,:); 

ii = 1;
nn = size(C,2);

while( ii < nn )

   ll = yy(ii);

   xx(ii) = nan;
   yy(ii) = nan;

   ii = ii + ll + 1;

end

param.map_x = xx; 
param.map_y = yy; 

%------------------------------------------------------------------------------%
