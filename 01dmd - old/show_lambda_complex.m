
function h = show_lambda_complex( L, msize )

% Show the eigenvalues on the complex plane
%
% Usage: 
%     h = show_lambda_complex( lambdas, msize )
% 
% lambdas - eigenvalues
% msize   - marquer size (default = 5)

if( nargin < 2 ), msize = 5; end

t = linspace( 0, 2*pi, 200 );
m = max( abs( L(:) ) );

gray = [ .5 .5 .5 ];

cla
hold on

m = ceil(m);
axis([-m m -m m])
axis square
grid on 
box on

plot(   cos(t),   sin(t), 'k', 'linewidth', 0.5 )
plot( m*cos(t), m*sin(t), 'k', 'linewidth', 0.5 )

R = real(L);
I = imag(L);

ii = find( I >= 0 );
H  = plot( R(ii), I(ii), 'b.', 'markersize', msize );

ii = find( I < 0 );
if( ~isempty(ii) ) 
  H(2) = plot( R(ii), I(ii), 'k.', 'markersize', msize );
end

hold off

ticks = -m:m;

set( gca, 'xtick', ticks, 'ytick', ticks );

if( nargout > 0 ), h = H; end

%------------------------------------------------------------------------------%
