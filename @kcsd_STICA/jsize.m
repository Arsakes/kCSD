function sz=jsize(m,str);

if nargin>1
fprintf('%s: ',str);
end;

sz=size(m);
fprintf('jsize = ');
fprintf(' %d ',sz);
fprintf('\n');
