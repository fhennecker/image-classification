function [ w ] = one_vs_all( X, Y, hkm )
%ONE_VS_ALL one-vs-all classifier on data X and targets Y
%   the columns of w will contain the weights of each classifier
%   Data vectors must be the columns of X and Y must be a line vector
    if nargin == 2
        hkm = 0;
    end
    
    if hkm == 1
        hom.kernel = 'KChi2';
        hom.order = 2;

        X = vl_svmdataset(X, 'homkermap', hom);
    end
    
    targets_nr = size(unique(Y), 2);
    w =[];
    for i=1:targets_nr
        % creating target t with 1 for Ith class, -1 for other classes
        t = zeros(1, size(Y,2));
        for ti=1:size(Y,2)
            if Y(ti) == i
                t(ti) = 1;
            else
                t(ti) = -1;
            end
        end
        w(:, i) = vl_svmtrain(X, t, 0.01)';
    end

end

