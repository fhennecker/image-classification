function img_hist = getHistogram(features, k_words)

[x,y] = size(k_words);
[a,b] = size(features);
feat_hist = zeros(1,y);
distances = zeros(y,1);
%img_hist = zeros(c,y);
 %for k = 1:c
  for i = 1: b
    for j = 1:y
        %features(:,1);
        k_words(:,j);
        if(length(features(:,i)) == length(k_words(:,j)))
            %features(:,1);
            distances(j) = vl_alldist2(features(:,i),k_words(:,j));
        %else 
         %   distances(j) = 0;
        end
    end
    [~,index] = ismember(min(distances),distances);
    distances(index)
    index
    feat_hist(1,index) = feat_hist(1,index)+1;
  end
  sum(feat_hist);
 feat_hist = feat_hist/sum(feat_hist);
 img_hist = feat_hist;

 %end
end