function A = simplify_elements( A )

for i=1:size(A,1)
	for j=1:size(A,2)
		A(i,j) = simplify( A(i,j) );
	end
end
