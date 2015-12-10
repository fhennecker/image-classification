addpath('functions');

run('vlfeat/toolbox/vl_setup')

classes = dir('../images/training/');
i = 1;
for class={classes.name}
    class = class{1};
    if strncmpi(class, '.', 1)
        classes(i) = [];
    else
        i = i+1;
    end
end

%% Extracting features
% % feature vectors
% X = [];
% 
% cid = 1; % class index
% i = 1; % current training feature index
% for class={classes.name}
%     class = class{1};
% 
%     disp(sprintf('Training with class %s', class));
% 
%     images = dir(sprintf('../images/training/%s/*.jpg', class));
%     for image={images.name}
%         image = image{1};
%         I = imread(sprintf('../images/training/%s/%s', class, image));
%         [f, d] = vl_sift(single(I), 'PeakThresh', 10);
%         for descriptor=1:size(d, 2)
%             X(i+1, :) = d(:, descriptor).';
%             i = i+1;
%         end
%     end
% 
%     cid = cid+1;
% end

%% Building the codebook

% [idx, C] = kmeans(X, 500);


%% Building histograms

% % Histograms
% H = [];
% 
% % targets (classes)
% T = [];
% 
% cid = 1; % class index
% i = 1; % current training image index
% for class={classes.name}
%     class = class{1};
% 
%     disp(sprintf('Training with class %s', class));
% 
%     images = dir(sprintf('../images/training/%s/*.jpg', class));
%     for image={images.name}
%         image = image{1};
%         I = imread(sprintf('../images/training/%s/%s', class, image));
%         [f, d] = vl_sift(single(I), 'PeakThresh', 10);
%         
%         % building histogram
%         H(i, :) = zeros(1, size(C, 1)); 
%         for descriptor=1:size(d, 2)
%             % quantize descriptor
%             repid = quantizevec(d(:, descriptor).', C);
%             H(i, repid) = H(i, repid)+1;
%             T(i) = cid;
%         end
%         i = i+1;
%     end
%     cid = cid+1;
% end

%% Training classifier

% hom.kernel = 'KChi2';
% hom.order = 2;
% 
% HHKM = vl_svmdataset(H.', 'homkermap', hom);
% 
% % one-vs-all classifier
% w = zeros(15, size(H, 2));
% for i=1:15
%     t = zeros(1, size(T,2));
%     for ti=1:size(T,2)
%         if T(ti) == i
%             t(ti) = 1;
%         else
%             t(ti) = -1;
%         end
%     end
%     w(i, :) = vl_svmtrain(H.', t, 0.01)';
% end
% 
% %% Testing classifier
% 
% cid = 1; % class index
% i = 1; % current training image index
% for class={classes.name}
%     class = class{1};
% 
%     disp(sprintf('Testing with class %s', class));
%     
%     total = 0;
%     correct = 0;
% 
%     images = dir(sprintf('../images/training/%s/*.jpg', class));
%     for image={images.name}
%         image = image{1};
%         I = imread(sprintf('../images/training/%s/%s', class, image));
%         [f, d] = vl_sift(single(I), 'PeakThresh', 10);
%         
%         % building histogram
%         hist = zeros(1, size(C, 1)); 
%         for descriptor=1:size(d, 2)
%             % quantize descriptor
%             repid = quantizevec(d(:, descriptor).', C);
%             hist(repid) = hist(repid)+1;
%         end
%         
%         % classifying with 1vsAll
%         ccount = zeros(1, 15);
%         for c=1:15
%             val = hist*w(c, :)';
%             if val > 0
%                 ccount(c) = ccount(c)+val;
%             else
%                 ccount = ccount -val;
%                 ccount(c) = ccount(c)+val;
%             end
%         end
%         [M, predicted] = max(ccount);
%         
%         total = total+1;
%         %disp(sprintf('cid : %d, res : %d', cid, round(hist*w)))
%         if predicted == cid
%             correct = correct+1;
%         end
%         i = i+1;
%     end
%     disp(sprintf('Total : %d, correct : %d', total, correct));
%     cid = cid+1;
% end


for i=0:1313
    I = imread(sprintf('../images/testing/%d.jpg', i));
    [f, d] = vl_sift(single(I), 'PeakThresh', 10);

    % building histogram
    hist = zeros(1, size(C, 1)); 
    for descriptor=1:size(d, 2)
        % quantize descriptor
        repid = quantizevec(d(:, descriptor).', C);
        hist(repid) = hist(repid)+1;
    end
    
    ccount = zeros(1, 15);
    for c=1:15
        val = hist*w(c, :)';
        if val > 0
            ccount(c) = ccount(c)+val;
        else
            ccount = ccount -val;
            ccount(c) = ccount(c)+val;
        end
    end
    [M, predicted] = max(ccount);
    disp(sprintf('%d.jpg : %s', i, classes(predicted).name));
end

