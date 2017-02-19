function [dx other] = dynamics_simple( t, x )

% if not vertical (because shit happens)
if size(x,2)>1
	x = reshape( x, length(x), 1 );
end

global eva

n = eva.n;
un = eva.underactuation;

% in multi-contact support phases increase the underactuation to limit the possible support errors
% but only if horizontal friction is on

if length( eva.support )>1 & any(eva.supportaxis==1)
    un = eva.underactuation + ( length(eva.support) - 1);
end

q = x(1:n);
dq = x(n+1:2*n);
%  r = x(2*n+1:3*n);


% mass-inertia
D0 = robot.(eva.name).out_lieD( q );
% coriolis and gravity together
C0 = robot.(eva.name).out_lieC( q, dq ) * dq + robot.(eva.name).out_lieG( q );
B0 = [ zeros( un, n-un); eye(n-un) ];
% eva.B0 = B0; % for input plot

if isempty( eva.support )% normal model
	D = D0;
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


	a1 = A'*inv(A*inv(D0)*A')*A*inv(D0);
	B = (eye(n) - a1)*B0;
	
	C = (eye(n) - a1)*C0 + A'*inv(A*inv(D0)*A')*dA*dq;
	D = D0;
	

end


s=0;
u = zeros(n-un,1);
try
	controlname = eva.control;
catch
	controlname = 'control';
end
control.(eva.name).(controlname)

if isempty( eva.support )
	lambda = 0;
	Alambda = 0;
else
	lambda = inv(A*inv(D0)*A')*(A*inv(D0)*(B0*u-C0)+dA*dq );
	Alambda = A'*lambda;
end

ddq = inv(D)*(-C + B * u);
dx = [ dq ; ddq ];


ddx(1:eva.n) = 0;
if ~isempty( eva.support )
	for i=1:Alength
		if Aaxis(i) == 3
			ddx( Apoint(i) ) = lambda(i);
		end
	end
end

global passthrough
passthrough.ddx = ddx;
