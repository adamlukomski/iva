% djac by definition
for i=1:eva.n
	for j=1:eva.n
		eva.link(i).djac(1:3,j) = jacobian(eva.link(i).jac(:,j),eva.q)*eva.dq;
	end
	tools.write_full( [ '+robot/+' eva.name '/out_djac' num2str(i) '.m'],{'q','dq'},[eva.list_q;eva.list_dq],{eva.link(i).djac,'djac'});
end