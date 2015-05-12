function dynamics

global eva

q = eva.q;
dq = eva.dq;


fprintf( 'dynamics ' )

g = 9.81;

fprintf( 'energies ' )
T = sym(0);
V = sym(0);
for i=1:length(q)
	T = T + 0.5 * [ eva.link(i).dqi ; eva.link(i).dp(1:3) ]' * [ eva.link(i).J zeros(3) ; zeros(3) eva.link(i).m*eye(3) ] * [ eva.link(i).dqi ; eva.link(i).dp(1:3) ];
	V = V + eva.link(i).m*g*eva.link(i).p(3);
end
%  T = simple(T);
%  V = simple(V);

fprintf( 'G ' )
G = jacobian( V, q )';
G = simplify( G );
% mass and inertia
fprintf( 'D ' )
D = jacobian(T,dq)';
D = jacobian(D,dq);
if size(D,1)*size(D,2)<100
	D = lie.simplify_elements( D );
end
% coriolis
fprintf( 'C ' )
clear C
syms C real
m=max(size(q));
for k=1:m
	for j=1:m
		C(k,j)=sym(0);
		for i=1:m
			C(k,j)=C(k,j)+1/2*(diff(D(k,j),q(i)) + ...
				diff(D(k,i),q(j)) - ...
				diff(D(i,j),q(k)))*dq(i);
		end
	end
end

%  C=simple(C);
clear m k j i

eva.dynamics.D0 = D;
eva.dynamics.C0 = C;
eva.dynamics.G0 = G;

fprintf('\n')
write_full( [ '+robot/+' eva.name '/out_D.m'],{'q'},[eva.list_q],{D,'D'});
write_full( [ '+robot/+' eva.name '/out_C.m'],{'q','dq'},[eva.list_q;eva.list_dq],{C,'C'});
write_full( [ '+robot/+' eva.name '/out_G.m'],{'q'},[eva.list_q],{G,'G'});

write_full( [ '+robot/+' eva.name '/out_T.m'],{'q','dq'},[eva.list_q;eva.list_dq],{T,'T'});
write_full( [ '+robot/+' eva.name '/out_V.m'],{'q'},[eva.list_q],{V,'V'});
