% dump a symbolic math variable containing an equation to a file
% a little bit faster than matlabFunction, but brute-force
%
% original write_fcn by B. Morris and E. Westervelt, 2007
% slightly modified by A. Lukomski 2012



function write_full( fcn_name, arguments, replace_list, list)
% Write a cell array of symbolic expressions to an m-file.
%
% Benjamin Morris
% 15 January 2007

fprintf('file: %s ',fcn_name);
fid = fopen(fcn_name,'w');

fprintf(fid,'function [');
for item = 1:1:size(list,1)
	currentname = list{item,2};
	if (item > 1), fprintf(fid,','); end;
	fprintf(fid,'%s',currentname);
end

[path,name,ext] = fileparts(fcn_name);
fprintf(fid,'] = %s(',name);

for item = 1:1:size(arguments,2) % write arguments
	currentname = arguments{1,item};
	if (item > 1), fprintf(fid,','); end;
	fprintf(fid,'%s',currentname);
end
fprintf(fid,')\n\n');

for item = 1:1:size(list,1) % write variables to file
	currentvar = list{item,1};
	currentname = list{item,2};
	[n,m]=size(currentvar);
	for i=1:n
		for j=1:m
			Temp0=currentvar(i,j);
			Temp1=replace(char(Temp0),replace_list);
			Temp2=['  ',currentname,'(',num2str(i),',',num2str(j),')=',Temp1,';'];
			fixlength(Temp2,'*+-',100,'         ',fid);
			fprintf(fid,'\n');
		end
	end
	fprintf(fid,'\n%s',' ');
end

fclose(fid);
fprintf(' - done\n');

%-------------------------------------------------------------------------
function str = replace(str,replace_list)

% process the longest strings first to keep from accidentally replacing substrings of longer strings
% perform a bubble sort on 'replace_list' according to decending length of the first element

for loop=1:1:size(replace_list,1)
	for i=1:1:size(replace_list,1)-1
		if (length(replace_list{i,1}) < length(replace_list{i+1,1}))
			temp = replace_list(i,:);
			replace_list(i,:) = replace_list(i+1,:);
			replace_list(i+1,:) = temp;
		end
	end
end

for i=size(replace_list,1):-1:1
	orig_str = char(replace_list(i,1));
	new_str = char(replace_list(i,2));
	str = strrep(str,orig_str,new_str);
end

%-------------------------------------------------------------------------
function fixlength(s1,s2,len,indent,fid)
%FIXLENGTH Returns a string which has been divided up into < LEN
%character chuncks with the '...' line divide appended at the end
%of each chunck.
%   FIXLENGTH(S1,S2,L) is string S1 with string S2 used as break points into
%   chuncks less than length L.

%Eric Westervelt
%5/31/00
%1/11/01 - updated to use more than one dividing string
%4/29/01 - updated to allow for an indent
%3/24/05 - bjm - non-iterative operation, much faster for large files

A=[];
for c = 1:length(s2)
	A = [A findstr(s1,s2(c))];
	A = sort(A);
end

if (length(A)>0)

	dA = diff(A);
	B = A;

	runlen = A(1);

	for i=1:1:length(dA)
		if (runlen + dA(i) <= len)
			runlen = runlen + dA(i);
			B(i) = 0;
		else
			runlen = 0;
		end
	end
	B(end) = 0; % don't make a newline after the last entry

	B=[0 B(B>0) length(s1)];

	for i=1:1:length(B)-1
		if (i==1)
			fprintf(fid,'%s',s1(B(i)+1:B(i+1)));
		else
			fprintf(fid,'...\n%s%s',indent,s1(B(i)+1:B(i+1)));
		end
	end

else
	fprintf(fid,'%s',s1);
end