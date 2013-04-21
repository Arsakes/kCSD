%
% Computes potential profifle function values in measurement positions
%
%
function bPotMatrix = bPotMatrixCalc(X, src, elPos, distTable)

nObs = length(elPos);	% amount of potential measures
n = length(src);	% amount of points in visualization space

distMax = max(X(:)) - min(X(:));
l = length(distTable);

bPotMatrix = zeros(n, nObs);

for srcInd = 1:n
    currentSrc = src(srcInd);
    %keyboard();
    for argInd = 1:nObs
        arg = elPos(argInd);
        r = abs(currentSrc - arg);
        
        distTableInd = uint16(l.*r./distMax) + 1;
        bPotMatrix(srcInd, argInd) = distTable(distTableInd);
    end

end
