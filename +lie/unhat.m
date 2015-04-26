function out = unhat(s)

%  if all( s(1:3,1:3) == -s(1:3,1:3)' )
	switch size(s,1)
		case 3
			out = [ s(3,2); s(1,3); s(2,1)];
		case 4
			out = [ s(3,2); s(1,3); s(2,1); s(1,4); s(2,4); s(3,4)];
		otherwise
			disp('unhat, only size 3 and 4 square matrices supported');
	end
%  else
%      disp( 'unhat, not supported non-skew symmetric rotation matrices 3x3' );
%      out = [];
%  end
