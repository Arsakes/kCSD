%
% Function used for creating the domain of potential CSD and potentaial calculations
% X - basic vector based on potential signal measures positions
% ext - border length (i guess)
% nSrc - how  many points we want
%
function src = makeSrc(X, ext, nSrc)
    xMin = min(X) - ext;
    xMax = max(X) + ext;
    dx = (xMax - xMin)/nSrc;
    src = min(X):dx:max(X);
end
