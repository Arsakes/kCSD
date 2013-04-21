%
% Function used for creating the sources positions in X, denser than data input space,
% and less dense than estimation area
% X - estimation area
% ext - border length (i guess)
% nSrc - how  many points we want
%
function src = makeSrc(X, ext, nSrc)
    xMin = min(X) - ext;
    xMax = max(X) + ext;
    dx = (xMax - xMin)/nSrc;
    src = min(X):dx:max(X);
end
