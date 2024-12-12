
function h = figure_position( fid, ll, cc, ff )

% Set figure position using subplot method
%
% Usage: h = figure_position( fid, ll, cc, ff )

% Grid position
ii = floor((ff-1)/cc+1);
jj = ff - cc * (ii-1);

% Windows size
if( ll < 3 ), pp = 0.96;
else;         pp = 0.90;
end

S = get( 0, 'screensize' );
Sx = floor( S(3) / cc );
Sy = floor( S(4) / ll );
Py = floor( Sy * pp );

P = [ 1+(jj-1)*Sx 1+(ll-ii)*Sy Sx Py ];

H = figure( fid, 'MenuBar', 'none', 'ToolBar', 'none', 'position', P );

if( nargout > 0 ), h = H; end

