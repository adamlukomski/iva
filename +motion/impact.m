function [dqafter F] = impact( x0, ie )

global eva

q = reshape( x0(1:eva.n), eva.n, 1 );
dqbefore = reshape( x0(eva.n+1:2*eva.n), eva.n, 1 );

D = robot.(eva.name).out_lieD( q' );

Afull = [];
for i=1:length(eva.support)
	Apart = robot.jacobian( eva.support(i), q );
	Afull = [ Afull ; Apart( eva.impactaxis,: ) ];
end


[Q,R1,E] = qr(Afull',0);
A = [];
for i=1:rank(Afull)
	A = [ A ; Afull(E(i),:) ];
end

out = inv( [ D -A' ; A zeros( size(A,1) ) ] ) * [ D * dqbefore ; zeros(size(A,1),1) ];

dqafter = reshape( out(1:eva.n), eva.n, 1 );
F = out(eva.n+1:end);

%  robot.dp( 1:7, q, dqafter )