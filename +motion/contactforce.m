function forces = contactforce( t, x, u )

global eva
n = eva.n;
un = eva.underactuation;
q = x;
dq = q(n+1:2*n);

if ~exist('u')
	[dx, other] = dyn_v06( t, q );
	u = other.u;
end


%  disp('planar case')

forces = [];
for point = eva.support'

	D = robot.(eva.name).out_lieD( q );
	C = robot.(eva.name).out_lieC( q(1:eva.n), q(eva.n+1:2*eva.n) );
	G = robot.(eva.name).out_lieG( q(1:eva.n) );
	B = [ zeros( un, n-un); eye(n-un) ];

	J = robot.jacobian6( point, q );
	J = J([2,4,6],:);
	dJ = [ zeros(3,eva.n) ; robot.djacobian( point, q, dq ) ];
	dJ = dJ( [2,4,6], : );
	force = inv(J*inv(D)*J') * (J*inv(D)*(C*dq+G-B*u)-dJ*dq);
	forces = [ forces force ];
%  	fprintf('for support point: %i\n', point )
%  	disp(force)
end
