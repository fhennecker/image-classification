function [ class ] = knn( X, T, input, k)
%knn compute class of input with KNN on feature vectors X with targets T
    closest = [Inf(k, 1) zeros(k, 1)]; % distance-class vector
    for x=1:size(X,1)
        i=1;
        % sorted insert if we find a closer point
        while (i <= size(closest, 1) && norm(X(x)-input) < closest(i))
            if (i ~= 1)
                closest(i-1, :) = closest(i, :);
            end
            closest(i, :) = [norm(X(x)-input) T(x)];
            i = i+1;
        end
    end
    class = mode(closest(:, 2)); % most frequent number in closest's 2nd col
end

