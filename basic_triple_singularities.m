% will simulate triple pendulum (embedded function for dynamics)
% will plot the results against dynamic singularities

function test_triple2

if ~exist('eva')
	global eva
	load +robot/+triple/out_eva.mat
end

[t,xrel] = ode45( @tripledyn, 0:0.01:20, [1.5;-3;-1.0  ;0.0;0.0;0.0] );
plotter1 = draw.window( 5, [] );
for plane = plotter1.PlanesOfMotion % sagittal, frontal, tranverse...
	subplot( plotter1.(plane{1}).subplot );
	axis( [-3 3, -3 3, -3 3] )
end
for i=1:length(t)
	draw.windowupdate( plotter1, xrel(i,1:eva.n) )
	drawnow
end

L = [ 1 0 0 0 0 0; 1 1 0 0 0 0 ; 1 1 1 0 0 0 ];
x = (L * xrel')';

%  load +robot/+triple/out_eva.mat
B = [ 0 0 ; 1 0 ; 0 1 ];
L = [ 1 0 0 ; 1 1 0 ];
det( L*inv(eva.dynamics.Dselig)*B )
detsing = ans;
detsing = simplify(detsing)

[q,dq] = lie.q;

syms a1 a2 a3 real;
a = [a1;a2;a3];

qsubs = inv( [ 1 0 0 ; 1 1 0 ; 0 1 1 ] ) * [a1;a2;a3];
q1 = qsubs(1);
q2 = qsubs(2);
q3 = qsubs(3);
detabs = simplify(subs(detsing),150)

sketch_detA( detabs, a )
hold on
plot3( x(:,1), x(:,2), x(:,3) )
plot3( x(1,1), x(1,2), x(1,3), '.r' )

% dynamics

function dx = tripledyn(t,x)

global eva

q = x(1:3);
dq = x(4:6);

D = robot.(eva.name).out_lieD( q );
C = robot.(eva.name).out_lieC( q, dq );
G = robot.(eva.name).out_lieG( q );

B = [ 0 0 ; 1 0 ; 0 1 ];
%  B = [0;0;1];
%  L = [ 1 0 0 ; 1 1 0 ];
%  L = [ q(1), q(2), q(3) ];
L = [ 1 0 0; 1 1 0 ];
v = 2*([1;-2]-L*q) + 1*(-L*dq);
u = inv( L*inv(D)*B ) * ( v - L*(inv(D)*(-C*dq-G)) )
%  u = [0;0];

ddq = inv(D)*(-C*dq-G+B*u);

dx = [dq;ddq];