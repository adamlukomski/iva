function [qs dqs] = q(n)

if ~exist('n')
	global eva
	n = eva.n;
end

qs = sym('q%d',[n 1]);
qs = sym(qs,'real');
dqs = sym('dq%d',[n 1]);
dqs = sym(dqs,'real');
