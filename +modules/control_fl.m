% basic feedback lin to zero

v =  100 * ( -L*q ) + 20 * ( -L*dq );
u = inv( L * inv(H) * B ) * ( v + L*inv(H)*C );

if any(isnan( u) )
	u = zeros(size(u));
end