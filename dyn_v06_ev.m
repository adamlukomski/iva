function [value,isterminal,direction] = events(t,y)

global eva;
n = eva.n;

pos = robot.p( 1:n, y(1:n) );
value(1:n) = pos(3,:);
isterminal(1:n) = 1; 
direction(1:n) = -1; 

global passthrough

value(1+n:2*n) = passthrough.ddq;
isterminal(1+n:2*n) = 1; 
direction(1+n:2*n) = 0; 

if any( passthrough.ddq > 0 )
	fprintf( 'lift confirmed at time %f\n', t )
end

value = value';
direction = direction';
isterminal = isterminal';