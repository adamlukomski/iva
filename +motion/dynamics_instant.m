function link = dynamics_instant( q, dq )
% kin and dyn, all in one package WITHOUT symbolic math

global eva
n = eva.n;

fprintf( 's A ' );
for i=1:n
	if eva.link(i).v == 0
		link(i).s = [ eva.link(i).w ; lie.hat(eva.link(i).u)*eva.link(i).w ];
	else
		link(i).s = [ eva.link(i).w ; eva.link(i).v ];
	end
	A = expm( lie.hat( link(i).s ) * q(i) );
	link(i).A = A;

	
%  	w(1:3,i) = link(i).w;
end



fprintf( 'S ' );
for i=1:n
	link(i).S = 1;
	for j = eva.link(i).chain(1:end-1) % all chain except last value (j==i)
		link(i).S = link(i).S * lie.Ad( link(j).A );
	end
	link(i).S = link(i).S * link(i).s;
end

fprintf( 'dqi Aall g p jac dp' );
% dqi - absolute angular velocity - sum of relative ones
% Aall = A1 * A2 * ...
% jac - jacobian by definition (of position only)
for i=1:n
	fprintf( ' %i', i );
	link(i).dqi = 0;
	link(i).Aall = 1;
	for j = eva.link(i).chain % go through the chain and multiply / sum
		link(i).dqi = link(i).dqi + dq(j)*eva.link(j).w;
		link(i).Aall = link(i).Aall * link(j).A;
	end

%  	link(i).Aall = lie.simplify_elements( link(i).Aall );
	link(i).g = link(i).Aall * [ eye(3) eva.link(i).p0 ; 0 0 0 1 ];
	link(i).p = link(i).Aall * [ eva.link(i).p0 ; 1 ];

	link(i).jac = zeros(3,n);
	link(i).jac6 = zeros(6,n);
	for j = eva.link(i).chain % go through the chain and multiply / sum
		jac = lie.hat(link(j).S)*link(i).p; % size is 4x1, need 3x1
		link(i).jac(:,j) = jac(1:3,1);

		jac6 = lie.hat(link(j).S)*[ eye(4,3) link(i).p];
		link(i).jac6(:,j) = lie.unhat( jac6 );
	end

	link(i).dp = link(i).jac * dq;
end

fprintf('brackets')
for i=1:eva.n
	for j=1:eva.n
		br{i,j} = lie.bracket(link(i).S, link(j).S);
	end
end

%%%% NOT WORKING
fprintf('\n djac_dq still not operational! so no support points for now\n')
for c = 1:eva.n; % current djacobian_c
	% djac*dq = ( term2 + term1 ) * p
	% djac*dq = ( sum_(1<=i<j<6) ( dqi dqj [Si,Sj] ) + sum (dqi^2 Si^2) ) * p

	term1 = 0; % sum (dqi^2 Si^2)
	for i= eva.link(c).ancestors
		term1 = term1 + dq(i)^2*lie.hat(link(i).S)^2;
	end

	term2 = zeros(6,1); % sum_(1<=i<j<6) ( dqi dqj [Si,Sj] )
	for i=eva.link(c).ancestors
		for j=eva.link(c).ancestors
			if i<j
				term2 = term2 + dq(i)*dq(j)*br{i,j};
			end
		end
	end

	djac_dq = ( lie.hat(term2) + term1 ) * link(c).p;
	link(c).djac_dq = djac_dq(1:3,1);
end

%  motion.test_djac_failsafe


fprintf('N ');
for i=1:eva.n
	link(i).Nnormal = [eva.link(i).J zeros(3); zeros(3) eye(3)*eva.link(i).m ];
	% translation only!
	link(i).Ntranslation = lie.Ad( [ [ eye(3) ; 0 0 0 ] link(i).p ] );
	link(i).N =  inv(link(i).Ntranslation')*link(i).Nnormal*inv(link(i).Ntranslation);
end

for i=1:eva.n
	for j=1:eva.n
		N{i,j} = 0;
	end
	for j= eva.link(i).children
		N{i,j} = lie.sumcell({link( eva.link(j).children  ).N});
	end
end

fprintf('D ');
for i=1:eva.n
	for j=i:eva.n
		D(i,j) = link(i).S' * N{i,j} * link(j).S;
		D(j,i) = D(i,j);
	end
end

fprintf('Nijk ');
for i=1:eva.n
	for j=1:eva.n
		for k=1:eva.n
			NB{i,j,k} = 0;
		end
	end
end

for i=1:eva.n
	for j= 1:eva.n
		for k = 1:eva.n
			if motion.samelimb( [i,j,k] )
				NB{i,j,k} = lie.sumcell({link(  eva.link(max([i,j,k])).children  ).N});
			else
				% that means they belong to different limbs, so no common:
				NB{i,j,k} = zeros(6);
			end
		end
	end
end



fprintf('Coriolis ');
for i=1:eva.n
	for j=1:eva.n
		for k=1:eva.n
			B(i,j,k) = 0.5*( link(j).S' * NB{i,j,k} * br{i,k} + ...
					 link(k).S' * NB{i,j,k} * br{i,j} - ...
					 link(i).S' * NB{i,j,k} * br{max([k,j]), min([j,k])} )*dq(k);
%  			fprintf( '%d ',(i-1)*eva.n^2+(j-1)*eva.n+k );
		end
	end
	fprintf('%d ',i);
end
fprintf('\n');
% coriolis 
C = 0;
for i=1:eva.n
	C = C + B(:,:,i);
end


% for gravt

fprintf('Gravity ');
for i=1:eva.n
	N1{i} = lie.sumcell({link( eva.link(i).children  ).N});
end

clear G
% sure that it is not -9.81 ??
g = [ 0;0;0; 0;0; 9.81];
% gravity
for i=1:eva.n
	G(i,1) = link(i).S' * N1{i} * g;
end



