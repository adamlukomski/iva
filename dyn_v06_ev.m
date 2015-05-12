function [value,isterminal,direction] = events(t,y)

global eva;
n = eva.n;

pos = robot.p( 1:n, y(1:n) );
value(1:n) = pos(3,:);
isterminal(1:n) = 1;   % Stop the integration
direction(1:n) = -1;   % Negative direction only

global passthrough
%  forces = motion.contactforce( t, y, passthrough.u );
%  allforces = zeros(eva.n,1);
%  if ~isempty(eva.support)
%    allforces( eva.support ) = -forces(3,:)';
%  end
%  value(1+n:2*n) = allforces;

value(1+n:2*n) = passthrough.ddq;
isterminal(1+n:2*n) = 1;   % Stop the integration
direction(1+n:2*n) = 0;   % Negative direction only

if any( passthrough.ddq > 0 )
	fprintf( 'lift confirmed at time %f\n', t )
end

%  if any( allforces > 0 )
%  	fprintf( 'lift confirmed at time %f\n', t )
%  end
value = value';
direction = direction';
isterminal = isterminal';