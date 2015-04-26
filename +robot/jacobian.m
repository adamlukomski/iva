function J = jac( i, q )
% normal jacobian(p,q), so only positions - 3 (x,y,z)
global eva
eval( [ 'J = robot.' eva.name '.out_jac' num2str(i) '( q ); ' ] );
