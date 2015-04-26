function kinematics

global eva

q = eva.q;
dq = eva.dq;

list_q = {};
list_dq = {};
for i=1:9
	list_q(i,1) = {[ 'q' num2str(i) ]};
	list_q(i,2) = {[ 'q(' num2str(i) ')' ]};
	list_dq(i,1) = {[ 'dq' num2str(i) ]};
	list_dq(i,2) = {[ 'dq(' num2str(i) ')' ]};
end
for i=10:19
	list_q(i,1) = {[ 'q(1)' num2str(i-10) ]};
	list_q(i,2) = {[ 'q(' num2str(i) ')' ]};
	list_dq(i,1) = {[ 'dq(1)' num2str(i-10) ]};
	list_dq(i,2) = {[ 'dq(' num2str(i) ')' ]};
end
eva.list_q = list_q;
eva.list_dq = list_dq;

n = eva.n;

% u are currently absolute, add parent field later on and calculate u!

fprintf( 's A ' );
for i=1:n
	if eva.link(i).v == 0
		eva.link(i).s = [ eva.link(i).w ; lie.hat(eva.link(i).u)*eva.link(i).w ];
	else
		eva.link(i).s = [ eva.link(i).w ; eva.link(i).v ];
	end
	A = expm( lie.hat( eva.link(i).s ) * q(i) );
	eva.link(i).A = lie.simplify_elements( A );

	
%  	w(1:3,i) = link(i).w;
end



fprintf( 'S ' );
for i=1:n
	eva.link(i).S = sym(1);
	for j = eva.link(i).chain(1:end-1) % all chain except last value (j==i)
		eva.link(i).S = eva.link(i).S * lie.Ad( eva.link(j).A );
	end
	eva.link(i).S = eva.link(i).S * eva.link(i).s;
end

fprintf( 'dqi Aall g p jac dp' );
% dqi - absolute angular velocity - sum of relative ones
% Aall = A1 * A2 * ...
% jac - jacobian by definition (of position only)
for i=1:n
	fprintf( ' %i', i );
	eva.link(i).dqi = sym(0);
	eva.link(i).Aall = sym(1);
	for j = eva.link(i).chain % go through the chain and multiply / sum
		eva.link(i).dqi = eva.link(i).dqi + dq(j)*eva.link(j).w;
		eva.link(i).Aall = eva.link(i).Aall * eva.link(j).A;
	end

	eva.link(i).Aall = lie.simplify_elements( eva.link(i).Aall );
	eva.link(i).g = eva.link(i).Aall * [ eye(3) eva.link(i).p0 ; 0 0 0 1 ];
	eva.link(i).p = eva.link(i).Aall * [ eva.link(i).p0 ; 1 ];

	eva.link(i).jac = sym( zeros(3,n) );
	eva.link(i).jac6 = sym( zeros(6,n) );
	for j = eva.link(i).chain % go through the chain and multiply / sum
		jac = lie.hat(eva.link(j).S)*eva.link(i).p; % size is 4x1, need 3x1
		eva.link(i).jac(:,j) = jac(1:3,1);

		jac6 = lie.hat(eva.link(j).S)*[ eye(4,3) eva.link(i).p];
		eva.link(i).jac6(:,j) = lie.unhat( jac6 );
	end

	eva.link(i).dp = eva.link(i).jac * dq;
end




fprintf('\n')
for i=1:n
	write_full( [ '+robot/+' eva.name '/out_p' num2str(i) '.m'],{'q'},[eva.list_q],{eva.link(i).p,'p'});
	write_full( [ '+robot/+' eva.name '/out_dp' num2str(i) '.m'],{'q','dq'},[eva.list_q;eva.list_dq],{eva.link(i).dp,'dp'});
	write_full( [ '+robot/+' eva.name '/out_g' num2str(i) '.m'],{'q'},[eva.list_q],{eva.link(i).g,'g'});
	write_full( [ '+robot/+' eva.name '/out_jac' num2str(i) '.m'],{'q'},[eva.list_q],{eva.link(i).jac,'jac'});
	write_full( [ '+robot/+' eva.name '/out_jac6' num2str(i) '.m'],{'q'},[eva.list_q],{eva.link(i).jac6,'jac6'});
end