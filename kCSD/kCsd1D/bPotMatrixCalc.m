%
% What exactly this function does?
%
%
function bPotMatrix = bPotMatrixCalc(X, src, elPos, distTable)

nObs = length(elPos);
n = length(src);

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
