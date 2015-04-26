function J = jac( i, q, dq )
global eva
eval( [ 'J = robot.' eva.name '.out_djac' num2str(i) '( q, dq ); ' ] );
