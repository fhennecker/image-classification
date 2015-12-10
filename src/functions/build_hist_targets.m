function [ H, T ] = build_hist_targets( classes, images, C, type, param_name, param_value )
%HIST_TRAIN Build a matrix of histograms and a target vector 
%   classes must be a struct and images must be a vector of indices.
%   C is the matrix of representative (quantised) vectors. (1 vec = 1 col)
%   The columns of H will contain the histograms and T will be a line of
%   targets.


    % Histograms
    H = [];

    % targets (classes)
    T = [];

    cid = 1; % class index
    idx = 1; % current training image index
    for class={classes.name}
        class = class{1};

        disp(sprintf('Building histograms for class %s', class))
        
        for i=images
            I = imread(sprintf('../images/training/%s/%d.jpg', class, i));
            f = [];
            d = [];
            if type == 'phow'
                [f, d] = vl_phow(single(I), param_name, param_value);
            elseif type == 'sift'
                [f, d] = vl_sift(single(I), param_name, param_value);
            end

            % building histogram
            H(:, idx) = zeros(size(C, 2), 1); 
            for descriptor=1:size(d, 2)
                % quantize descriptor
                repid = quantizevec(d(:, descriptor), C);
                H(repid, idx) = H(repid, idx)+1;
                T(idx) = cid;
            end
            idx = idx+1;
        end
        cid = cid+1;
    end
end

