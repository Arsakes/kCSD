function jrand_set_seed(s)

% Set rand and randn to have same seed = s;
% If s=='clock' then set seed from clock.

if s=='clock'
	fprintf('\nSETTING RANDOM NUMBER SEEDS TO CLOCK\n\n');
	rand('state',sum(100*clock));
else
	fprintf('\nSETTING RANDOM NUMBER SEEDS TO %d\n\n',s);
	rand('seed',s);
	randn('seed',s);
end;
