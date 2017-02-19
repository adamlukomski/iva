function [value,isterminal,direction] = events(t,y)

% if not vertical (because shit happens)
if size(y,2)>1
	y = reshape( y, length(y), 1 );
end


global eva;
n = eva.n;

pos = robot.p( 1:n, y(1:n) );
value(1:n) = pos(3,:);
isterminal(1:n) = 1;   % Stop the integration
direction(1:n) = -1;   % Negative direction only

%  global passthrough
%  forces = motion.contactforce( t, y, passthrough.u );
%  allforces = zeros(eva.n,1);
%  if ~isempty(eva.support)
%    allforces( eva.support ) = -forces(3,:)';
%  end
%  value(1+n:2*n) = allforces;

global passthrough
value(1+n:2*n) = passthrough.ddx;
%  [dx,other] = dyn_v07( t, y );
%  value(1+n:2*n) = other.ddq;
isterminal(1+n:2*n) = 1;   % Stop the integration
direction(1+n:2*n) = 0;   % Negative direction only

%  if any( other.ddq > 0 )
%  	fprintf( 'lift confirmed at time %f\n', t )
%  end

%  if any( allforces > 0 )
%  	fprintf( 'lift confirmed at time %f\n', t )
%  end
value = value';
direction = direction';
isterminal = isterminal';