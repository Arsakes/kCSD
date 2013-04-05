function bSrcMatrix = bSrcMatrixCalc(X, src, h)

nSrc = length(src);
nGx = length(X);

bSrcMatrix = zeros(nGx, nSrc);

for currentSrc = 1:nSrc
    try
        bSrcMatrix(:, currentSrc) = gauss_rescale(X, src(currentSrc), h);
    catch err
        keyboard()
    end
end