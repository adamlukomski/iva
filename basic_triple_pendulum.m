% will simulate triple pendulum (embedded function for dynamics)

function basic_triple_pendulum

global eva
load +robot/+triple/out_eva.mat

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



% dynamics

function dx = tripledyn(t,x)

global eva

q = x(1:3);
dq = x(4:6);

D = robot.(eva.name).out_lieD( q );
C = robot.(eva.name).out_lieC( q, dq );
G = robot.(eva.name).out_lieG( q );

B = eye(3);
L = eye(3);
v = 2*(-L*q) + 1*(-L*dq);
u = inv( L*inv(D)*B ) * ( v - L*(inv(D)*(-C*dq-G)) )

ddq = inv(D)*(-C*dq-G+B*u);
dx = [dq;ddq];