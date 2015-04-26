function [dx other] = dyn_v06( t, x )

global eva

n = eva.n;
un = eva.underactuation;

q = x(1:n);
dq = x(n+1:2*n);
r = x(2*n+1:3*n);

D0 = robot.(eva.name).out_lieD( q );
C00 = robot.(eva.name).out_lieC( q, dq );
G0 = robot.(eva.name).out_lieG( q );

H0 = D0;
C0 = C00*dq + G0;

B0 = [ zeros( un, n-un); eye(n-un) ];


if isempty( eva.support )% normal model
	H = H0;
	B = B0;
	C = C0;
	A = [];
	dA = [];
else
	% constraints - ground contact
	Afull = [];
	dAfull = [];
	Aaxisfull = [];
	Apointfull = [];
	for i=1:length(eva.support)
		Apart = robot.jacobian( eva.support(i), q );
		Afull = [Afull ; Apart( eva.supportaxis,: ) ];

		dApart = robot.djacobian( eva.support(i), q, dq );
		dAfull = [dAfull; dApart( eva.supportaxis,: ) ];

		Aaxisfull = [ Aaxisfull eva.supportaxis ];
		Apointfull = [ Apointfull ones(size(eva.supportaxis))*eva.support(i) ];
	end

	[Q,R1,E] = qr(Afull',0);

	A = [];
	dA = [];
	Alength = rank(Afull);
	for i=1:Alength
		A = [ A ; Afull(E(i),:) ];
		dA = [ dA ; dAfull(E(i),:) ];
		Aaxis(i) = Aaxisfull(E(i));
		Apoint(i) = Apointfull(E(i));
	end


	a1 = A'*inv(A*inv(H0)*A')*A*inv(H0);
	B = (eye(n) - a1)*B0;
	
	C = (eye(n) - a1)*C0 + A'*inv(A*inv(H0)*A')*dA*dq;
	H = H0;
end


u = zeros(n-un,1);

dr = dq;

L = [ 	0 0 0 1 0 0 0 0 0 0 0 ;
	0 0 0 0 1 0 0 0 0 0 0 ;
	0 0 0 0 0 1 0 0 0 0 0 ;
	0 0 0 0 0 0 1 0 0 0 0 ;
	0 0 0 0 0 0 0 1 0 0 0 ;
	0 0 0 0 0 0 0 0 1 0 0 ;
	0 0 -1 0 0 0 0 0 0 1 0 ;
	0 0 -1 0 0 0 0 0 0 0 1 ];
y = L*q;
dy = L*dq;

k = [ 100; 20 ];
v =  k(1) * ( [0.3;0.3;0;-0.3;0.3;0;0.1;-0.1]-y ) + k(2)* ( -dy );
u = inv( L * inv(H) * B ) * ( v + L*inv(H)*C );
if any(isnan( u) )
	u = zeros(size(u));
end




if isempty( eva.support )
	lambda = 0;
	Alambda = 0;
else
	lambda = inv(A*inv(H0)*A')*(A*inv(H0)*(B0*u-C0)+dA*dq );
	Alambda = A'*lambda;
end

ddq = inv(H)*(-C + B * u);
dx = [ dq ; ddq ; dr ];

other.lambda = lambda;
other.Alambda = Alambda;
other.u = u;


global passthrough
passthrough.u = u;
passthrough.ddq(1:eva.n) = 0;

if ~isempty( eva.support )
	for i=1:Alength
		if Aaxis(i) == 3
			passthrough.ddq( Apoint(i) ) = lambda(i);
		end
	end
end
