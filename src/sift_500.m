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
% X1 = [];
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
%             X1(i+1, :) = d(:, descriptor).';
%             i = i+1;
%         end
%     end
% 
%     cid = cid+1;
%     size(X1)
% end


%% Building the codebook
% 
% [idx, C1] = kmeans(X1, 500);


%% Building histograms and targets

[H1, T1] = build_hist_targets(classes, [0:99], C1', 'sift', 'PeakThresh', 10);


%% Cross-validating model accuracy

accuracies = cross_validation(H1, T1, classes, C1', 'sift', 'PeakThresh', 10);
mean_accuracies = mean(accuracies)
std_accuracies = std(accuracies)

general_accuracy = mean(mean_accuracies)


%% Training classifier

hom.kernel = 'KChi2';
hom.order = 2;

HHKM = vl_svmdataset(H.', 'homkermap', hom);

w = one_vs_all(H1, T1);


%% Predicting test set

% output_file = fopen('run3.txt', 'w');
% predict(output_file, classes, w, C1', 'sift', 'PeakThresh', 10);
