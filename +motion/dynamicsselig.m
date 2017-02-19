function dynamicsselig


%  disp('not universal! change the detection: if N1 from one arm, N2 from another than N=0')


global eva
fprintf('N ');
for i=1:eva.n
	disp('WARNING: version for calc_ with N = J mC mC m  !')
	disp('robot with no internal N, calculating from J and m, hat(c)')
	disp('will NOT work with bioloid')
	eva.link(i).Nnormal = [eva.link(i).J zeros(3); zeros(3) eye(3)*eva.link(i).m ];
	eva.link(i).Nnormal = [eva.link(i).J, eva.link(i).m*lie.hat(eva.link(i).c); eva.link(i).m*lie.hat(eva.link(i).c)', eye(3)*eva.link(i).m ];
	% translation only!
	eva.link(i).Ntranslation = lie.Ad( [ [ eye(3) ; 0 0 0 ] eva.link(i).p ] );
	eva.link(i).Ntranslation = lie.Ad( eva.link(i).g );
	eva.link(i).N =  inv(eva.link(i).Ntranslation')*eva.link(i).Nnormal*inv(eva.link(i).Ntranslation);
end

for i=1:eva.n
	for j=1:eva.n
		N{i,j} = sym(0);
	end
	for j= eva.link(i).children
		N{i,j} = lie.sumcell({eva.link( eva.link(j).children  ).N});
	end
end

fprintf('D ');
for i=1:eva.n
	for j=i:eva.n
		D(i,j) = eva.link(i).S' * N{i,j} * eva.link(j).S;
		D(j,i) = D(i,j);
	end
end

fprintf('Nijk ');
for i=1:eva.n
	for j=1:eva.n
		for k=1:eva.n
			NB{i,j,k} = sym(0);
		end
	end
end

%  fprintf('\n compiled for a planar model without feet');
%  fprintf('\n compiled for a planar model WITH feet');
%  fprintf('\n compiled for a planar model WITH feet and WITH arms');
for i=1:eva.n
	for j= 1:eva.n
		for k = 1:eva.n
			% to how many different limbs does the [i,j,k] set belong?
%  			% with feet
%  			if sum([i j k] == 4 | [i j k] == 5 | [i j k] == 6) & sum([i j k] == 7 | [i j k] == 8 | [i j k] == 9)
%  			% without feet
%  			if sum([i j k] == 4 | [i j k] == 5 ) & sum([i j k] == 6 | [i j k] == 7 )
			if motion.samelimb( [i,j,k] )
				NB{i,j,k} = lie.sumcell({eva.link(  eva.link(max([i,j,k])).children  ).N});
			else
				% that means they belong to different limbs, so no common:
				NB{i,j,k} = sym(zeros(6));
			end
		end
	end
end

fprintf('brackets')
for i=1:eva.n
	for j=1:eva.n
		br{i,j} = lie.bracket(eva.link(i).S, eva.link(j).S);
	end
end

fprintf('Coriolis ');
for i=1:eva.n
	for j=1:eva.n
		for k=1:eva.n
			B(i,j,k) = 0.5*( eva.link(j).S' * NB{i,j,k} * br{i,k} + ...
					 eva.link(k).S' * NB{i,j,k} * br{i,j} - ...
					 eva.link(i).S' * NB{i,j,k} * br{max([k,j]), min([j,k])} )*eva.dq(k);
%  			fprintf( '%d ',(i-1)*eva.n^2+(j-1)*eva.n+k );
		end
	end
	fprintf('%d ',i);
end
fprintf('\n');
% coriolis 
C = sym(0);
for i=1:eva.n
	C = C + B(:,:,i);
end


% for gravt

fprintf('Gravity ');
for i=1:eva.n
	N1{i} = lie.sumcell({eva.link( eva.link(i).children  ).N});
end

clear G
% sure that it is not -9.81 ??
g = sym([ 0;0;0; 0;0; 9.81]);
% gravity
for i=1:eva.n
	G(i,1) = eva.link(i).S' * N1{i} * g;
end


% both
%  C = B2*eva.dq + B3;

eva.dynamics.br = br;
eva.dynamics.Dselig = D;
eva.dynamics.Cselig = C;
eva.dynamics.Gselig = G;
fprintf('\n');
tools.write_full( [ '+robot/+' eva.name '/out_lieD.m'],{'q'},[eva.list_q],{D,'D'});
tools.write_full( [ '+robot/+' eva.name '/out_lieC.m'],{'q','dq'},[eva.list_q;eva.list_dq],{C,'C'});
tools.write_full( [ '+robot/+' eva.name '/out_lieG.m'],{'q'},[eva.list_q],{G,'G'});


for c = 1:eva.n; % current djacobian_c
	% djac*dq = ( term2 + term1 ) * p
	% djac*dq = ( sum_(1<=i<j<6) ( dqi dqj [Si,Sj] ) + sum (dqi^2 Si^2) ) * p

	term1 = sym(0); % sum (dqi^2 Si^2)
	for i= eva.link(c).ancestors
		term1 = term1 + eva.dq(i)^2*lie.hat(eva.link(i).S)^2;
	end

	term2 = sym(zeros(6,1)); % sum_(1<=i<j<6) ( dqi dqj [Si,Sj] )
	for i=eva.link(c).ancestors
		for j=eva.link(c).ancestors
			if i<j
				term2 = term2 + eva.dq(i)*eva.dq(j)*eva.dynamics.br(i,j);
			end
		end
	end

	djac_dq = ( lie.hat(term2) + term1 ) * eva.link(c).p;
	eva.link(c).djac_dq = djac_dq(1:3,1);

	tools.write_full( [ '+robot/+' eva.name '/out_djac_dq' num2str(c) '.m'],{'q','dq'},[eva.list_q;eva.list_dq],{eva.link(c).djac_dq,'djac_dq'});
end

fprintf(' potential energy V, ');
Vi = sym(0);
for i=1:eva.n
	Vi(i) = eva.link(i).m*9.81*eva.link(i).pc(3);
end
V = sum( Vi );
tools.write_full( [ '+robot/+' eva.name '/out_V.m'],{'q'},[eva.list_q],{V,'V'});

% COM point
% the [eva.link.m]*0] is needed to erase the 1 from [px;py;pz;1] that would ruin COM point
com = sum( [eva.link.pc].*[[eva.link.m;eva.link.m;eva.link.m];[eva.link.m]*0], 2 )./(sum([eva.link.m]));
tools.write_full( [ '+robot/+' eva.name '/out_com.m'],{'q'},[eva.list_q],{com,'com'});

dcom = sum( [eva.link.dpc].*[eva.link.m;eva.link.m;eva.link.m], 2 )./(sum([eva.link.m]));
tools.write_full( [ '+robot/+' eva.name '/out_dcom.m'],{'q','dq'},[eva.list_q;eva.list_dq],{dcom,'dcom'});



fprintf(' djac, ');
%
%   FIX THIS:   needs to be explicit
%
for i=1:eva.n
	for j=1:eva.n
		eva.link(i).djac(1:3,j) = jacobian(eva.link(i).jac(:,j),eva.q)*eva.dq;
	end
	tools.write_full( [ '+robot/+' eva.name '/out_djac' num2str(i) '.m'],{'q','dq'},[eva.list_q;eva.list_dq],{eva.link(i).djac,'djac'});
end
