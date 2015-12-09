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
     end
end

%if exist('data/patchFeatures.mat')
%    words = load('data/patchFeatures.mat');
%else
    words = getFeature(data_image_train_path,classes,image,patch_size);  
%end
 images_test = dir(sprintf('images/testing/*.jpg'));
 image_test = {images_test.name}';
%if exist('data/patchFeatures_test.mat')
%    words_test = load('data/patchFeatures_test.mat');
%else
    words_test = getFeature_test(data_image_test_path,image_test,patch_size);  
%end
%load('.mat');
image_hist = calculatePatch(words_test,words,data_image_test_path,classes,image_test(3),patch_size);

%image_hist = getHistogram(words_test, words);
%