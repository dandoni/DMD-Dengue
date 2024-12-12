
function show_mode_energy( modes, lambda, P )

I = 1:P;
N = size( modes, 2 );

% Energy of the largest eigenvalue
L = lambda(1);
M = norm( modes(:,1) );
E = abs( L.^I ) * M;

plot( I, E, 'r', 'linewidth', 2 )
hold on

% All remaining modes
for ii = 2:N

  L = lambda(ii);
  M = norm( modes(:,ii) );
  E = abs( L.^I ) * M;

  plot( I, E, 'b' )

end

hold off
grid on
ax = axis;
axis([ 1 P 0 ceil(ax(4)) ])

xlabel('Time Steps')
ylabel('Energy')

title('Mode Energy')

%------------------------------------------------------------------------------%
