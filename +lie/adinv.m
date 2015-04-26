function adc = ad(c)
% adjoint - lie algebra on itself

if size(c,1) == 1 
	c = c';
end

switch size(c,1)
    case 4
	adc = [ c(1:3,1:3) zeros(3) ; lie.hat( c(1:3,4) ) c(1:3,1:3) ];
    case 6
	adc = [ lie.hat( c(1:3) ) zeros(3) ; lie.hat( c(4:6) ) lie.hat( c(1:3) ) ];
    otherwise
	disp( ['not supported size! size(s) = [' num2str(size(s)) ']' ] );
	out = [];
end

