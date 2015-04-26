function val = samelimb( set1 )
% val = samelimb( set1, limbs )
%
% check if all points in set1 are on the same limb
%
global eva

val = 0;
for currentlimb = 1: length(eva.limb)
	% current limb: eva.limb(currentlimb)
	% check every point
	count = 0;
	for j = 1 : length(set1)
		if any( set1(j) == eva.limb(currentlimb).points )
			count = count + 1;
		end
	end
	if count == length( set1 )
		val = 1;
		break
	end
end
