% 
% Function generates the variated positions from input positions
%
% pos - row vector of positions
%
function varPos = variatePos( a,b, N, M)
%we randomly chooses 
    varPos = a + (b-a)* rand(N, M);
    [X,Y]=meshgrid(1:N,1:N);
    ID=X<=Y;
    varPos = ID*varPos;
end
