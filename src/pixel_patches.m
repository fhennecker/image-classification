addpath('functions');

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

feature vectors
X4 = zeros(1500000, 128); % 15 classes * 100 images * 1000 features

cid = 1; % class index
i = 1; % current training feature index
for class={classes.name}
    class = class{1};

    disp(sprintf('Training with class %s', class));

    images = dir(sprintf('../images/training/%s/*.jpg', class));
    for image={images.name}
        image = image{1};
        I = imread(sprintf('../images/training/%s/%s', class, image));
        d = extract_patches(single(I), 'Step', 16);
        for descriptor=1:size(d, 2)
            X4(i+1, :) = d(:, descriptor).';
            i = i+1;
        end
    end

    cid = cid+1;
    size(X4)
end



%% Building the codebook
ii = randperm(size(X4, 1));
[idx, C4] = kmeans(X4(ii(1:20000), :), 1000);


%% Building histograms and targets

[H4, T4] = build_hist_targets(classes, [0:99], C4', 'patch');


%% Cross-validating model accuracy

accuracies = cross_validation(H4, T4, classes, C4', 'patch');
mean_accuracies = mean(accuracies)
std_accuracies = std(accuracies)

general_accuracy = mean(mean_accuracies)


%% Training classifier

w = one_vs_all(H4, T4, 1);


%% Predicting test set

output_file = fopen('run3.txt', 'w');
predict(output_file, classes, w, C4', 'phow', 'Step', 64, 1);
