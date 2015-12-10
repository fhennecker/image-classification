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
% X3 = [];
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
%         [f, d] = vl_phow(single(I), 'Step', 64);
%         for descriptor=1:size(d, 2)
%             X3(i+1, :) = d(:, descriptor).';
%             i = i+1;
%         end
%     end
% 
%     cid = cid+1;
%     size(X3)
% end


%% Building the codebook
% 
% [idx, C3] = kmeans(X3, 1000);


%% Building histograms and targets

% [H3, T3] = build_hist_targets(classes, [0:99], C3', 'phow', 'Step', 64);


%% Cross-validating model accuracy

% accuracies = cross_validation(H3, T3, classes, C3', 'phow', 'Step', 64, 1);
% mean_accuracies = mean(accuracies)
% std_accuracies = std(accuracies)

% general_accuracy = mean(mean_accuracies)


%% Training classifier

w = one_vs_all(H3, T3, 1);


%% Predicting test set

output_file = fopen('run3.txt', 'w');
predict(output_file, classes, w, C3', 'phow', 'Step', 64, 1);
