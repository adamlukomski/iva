if length( eva.support )>1 & any(eva.supportaxis==1)
  L = [ zeros(eva.n-4,4), eye(eva.n-4) ];
  y = L*q;
  dy = L*dq;
  k = [ 100; 20 ];
  v =  k(1) * ( [0.3;-0.3;0.3]-y ) + k(2)* ( -dy );
  u = inv( L * inv(H) * B ) * ( v + L*inv(H)*C );
else
  L = [ zeros(eva.n-3,3), eye(eva.n-3) ];
  y = L*q;
  dy = L*dq;
  k = [ 100; 20 ];
  v =  k(1) * ( [0.3;0.3;-0.3;0.3]-y ) + k(2)* ( -dy );
  u = inv( L * inv(H) * B ) * ( v + L*inv(H)*C );
end

if any(isnan( u) )
	u = zeros(size(u));
end