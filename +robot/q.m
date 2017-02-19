function [qs dqs] = q(n)

if ~exist('n')
	global eva
	n = eva.n;
end

qs = sym('q%d',[n 1]);
%assume(qs,'real')
qs = sym(qs,'real');
dqs = sym('dq%d',[n 1]);
%assume( dqs,'real')
dqs = sym(dqs,'real');
