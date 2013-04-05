%
% Function used for chosing the best timepoint for cross validation
% The choice is made by checking spatial potential variation for a give time
%
function image = choose_CV_image(pots)
maks = 0;
image = 0;
[~, nt] = size(pots);

for i = 1:nt
    diff= abs(max(pots(:,i)) - min(pots(:,i)));
    if diff>maks
        maks = diff;
        image = i;
    end
end

if image == 0
    image = 1;
end;
