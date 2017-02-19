% simple hold the eva.controlsys.yr position
% feedback linearisation
% with goal linear system  ddy = -k1 y -k2 dy

% scale the response of the linear system:
ep = eva.controlsys.ep;
k = [ 120/ep^2; 20/ep ];

L = [ zeros(eva.n-3,3), eye(eva.n-3) ];
y = L*q;
dy = L*dq;
other.yr = eva.controlsys.yr;
v =  k(1) * ( eva.controlsys.yr-y ) + k(2)* ( -dy );

% if more than one point on the ground
if length( eva.support )>1 & any(eva.supportaxis==1)
	u = pinv( L * inv(D) * B ) * ( v + L*inv(D)*C );
% normal mode
else
	u = inv( L * inv(D) * B ) * ( v + L*inv(D)*C );
end

