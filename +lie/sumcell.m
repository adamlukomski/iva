function out = sumcell( a )

out = sym(0); % safe
for i=1:length(a)
	out = out + a{i};
end