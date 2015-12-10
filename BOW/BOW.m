run('vlfeat/toolbox/vl_setup')

%data_image_path = '../images';
data_image_train_path = 'images/training';
data_image_test_path = 'images/testing';
dictionary_path = 'data'; %%will content train.mat and test.mat

patch_size = 8;
%images = zeros(100*15,1);
classes = dir(data_image_train_path);
classes_test = dir(data_image_test_path);


for class = {classes.name}
      class = class{1};
     if ~strncmpi(class, '.', 1) % ignoring '.', '..', '.DS_Store', ...
        i = 1; 
        %class_name(:,i) = {classes.name} 
        %disp(sprintf('Training with class %s', class));
       
        images = dir(sprintf('images/training/%s/*.jpg', class));
        %images_path = strcat(data_image_train_path,{class.name});
         image = {images.name}';
        i = i+1;
        
        %class_name = {classes.name};
       % words = getFeature(sprintf('images/training/%s/%s', class, image),patch_size);
        %label = {classes.name}';
     end
end


    
%else


 %words = getFeature(data_image_train_path,classes,image,patch_size);  
%end


%if exist('data/patchFeatures_test.mat')
%    words_test = load('data/patchFeatures_test.mat');
%else
   %words_test = getFeature_test(data_image_test_path,image_test,patch_size);  
%end
%load('.mat');
   %image_hist = calculatePatch(words_test,words,data_image_test_path,classes,image_test(3),patch_size);

%image_hist = getHistogram(words_test, words);

images_test = dir(sprintf('images/testing/*.jpg'));
image_test = {images_test.name}';

label = {classes.name}';
for i = 1:15
    labels(i) = label(i+3);
end
labels = labels';
k = 1;
for j = 1:15
    for i = 1:100
    train_labels(k) = labels(j);
    k = k+1;
    end
end

train_labels = train_labels';





if exist('data/words.mat')    %get train features
    words_train = load('data/words.mat');
    words_train = words_train.words;
    words = words_train;
else
    words = getFeature(data_image_train_path,classes,image,patch_size); 
    words_train = words;
end


if exist('data/patchFeatures_test.mat')    %get test features
    words_test_features = load('data/patchFeatures_test.mat');
    words_test_features = words_test_features.patch_all;
else
    words_test_features = getFeature_test(data_image_test_path,image_test,patch_size); 
end


if exist('data/features_histogram.mat')   %make test words
    words_test = load('data/features_histogram.mat');    
    test_features = words_test.feature_hist;
else
    test_features = calculatePatch(words_test_features,words,data_image_test_path,classes,image_test, patch_size);
end


%(words_train,words, path,classes,images,patchSize)
if exist('data/features_histogram_train.mat')  %make train words
    words_train = load('data/features_histogram_train.mat');
    train_features = words_train.feature_hist_train;
else
    train_features = calculatePatch_train(words_train,words,data_image_train_path,classes,image,patch_size );
end 


classify = svm_classify(train_features,test_features,train_labels);




