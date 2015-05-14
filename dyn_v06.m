function [dx other] = dynamics_simple( t, x )

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
r = x(2*n+1:3*n);

D0 = robot.(eva.name).out_lieD( q );
C00 = robot.(eva.name).out_lieC( q, dq );
G0 = robot.(eva.name).out_lieG( q );

H0 = D0;
C0 = C00*dq + G0;

B0 = [ zeros( un, n-un); eye(n-un) ];
eva.B0 = B0; % for input plot


%  for i=1:n
%  	link(i).J = robot.jacobian( i, q );
%  	link(i).dJ = robot.djacobian( i, q, dq );
%  end

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

if ~exist( 'eva.control' ) | isempty( eva.control )
	% fallback
	control.(eva.name).control
else
	control.(eva.control).control
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

%  % check for errors in lambda:
%  if ~isempty( eva.support )
%  	ddq2 = inv(H0)*(-C0+B0*u-A'*lambda);
%  	[ ddq' ; ddq2' ]
%  end

other.lambda = lambda;
other.Alambda = Alambda;
other.u = u;

if 0 % this is version with accel
	global passthrough
	passthrough.ddq(1:eva.n) = 0;
	passthrough.u = u;
%  	for i=1:length(eva.support)
%  		J = robot.jacobian( eva.support(i), q );
%  		dJ = robot.djacobian( eva.support(i), q, dq );
%  
%  		if length(eva.support) > 1
%  			allbutcurrent = setdiff( 1:length(eva.support), i );
%  	%  		whichtochoose = [ allbutcurrent ; size(A,1)/2+allbutcurrent];
%  			whichtochoose = allbutcurrent;
%  			
%  			% [ allbutcurrent ; size(A)/2+allbutcurrent] is a trick to choose [1;3;4;4+1;4+3;4+4] - z and x axis
%  			Apart = A( whichtochoose , :);
%  			lambdapart = lambda( whichtochoose );
%  			ddx = dJ*dq + J*inv(H0)*(B0*u-C0 - Apart'*lambdapart );
%  		else
%  			ddx = dJ*dq + J*inv(H0)*(B0*u-C0 );
%  		end
%  		passthrough.ddq( eva.support(i) ) = ddx(3);
%  		if ddx(3)>0
%  			fprintf( 'lift %i at time %f with accel %f and lambda:\n', eva.support(i), t, ddx(3) )
%  			disp(lambda')
%  			forces = motion.contactforce( t, x, u );
%  			disp(forces)
%  %  			pause
%  		end
%  	end
	if ~isempty( eva.support )
		for i=1:Alength
			if Aaxis(i) == 3
				whichlines = [ 1:i-1, i+1:Alength ];
				if isempty( whichlines )
					passthrough.ddq( Apoint(i) ) = dJ*dq + J*inv(H0)*(B0*u-C0 );
				else
					Apart = A( whichlines, : );
					lambdapart = lambda( whichlines );
					
					J = robot.jacobian( Apoint(i), q );
					dJ = robot.djacobian( Apoint(i), q, dq );
					J = J(3,:);
					dJ = dJ(3,:);
					passthrough.ddq( Apoint(i) ) = dJ*dq + J*inv(H0)*(B0*u-C0 - Apart'*lambdapart );
				end
			end
		end
	end
else % version with forces
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
end
