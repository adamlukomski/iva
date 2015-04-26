function S = hat(s)

if length(s)==3
	S = [ 0 -s(3) s(2); s(3) 0 -s(1) ; -s(2) s(1) 0 ];
else
	S = [ 0 -s(3) s(2) s(4); s(3) 0 -s(1) s(5) ; -s(2) s(1) 0 s(6) ; 0 0 0 0 ];
end
