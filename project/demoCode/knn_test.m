function predicted_labels = knn_test(trainingFiles,trainingLabelFiles, test_data, k)
trainFiles = strsplit(trainingFiles,',');
folderName = 'matFiles/';
trainLabelFiles = strsplit(trainingLabelFiles,',');
data = load(strcat(folderName, trainFiles{1}));
training_data = data.global_samples_fd;
labels = load(strcat(folderName, trainLabelFiles{1}));
training_labels = labels.Y;
for i = 2 : length(trainFiles)
    data = load(trainFiles{i});
    d = data.global_samples_fd;
    labels = load(trainLabelFiles{i});
    l = labels.Y;  
    training_data = [training_data,d];
    training_labels = [training_labels,l];
end

predicted_labels = zeros(size(test_data, 2), 1);

for i = 1 : size(test_data, 2)
    test_row = test_data(:,i);
    len = size(training_data, 2);  
    dist_vec = zeros(len, 1);
    for j = 1 : len
        row = training_data(:, j);
        dist = (row - test_row) .^ 2;
        dist = sum(dist) ^ 0.5;
        dist_vec(j) = dist;
    end
    
    [a, b] = sort(dist_vec);
    label_counts = zeros(11, 1);
    
    for j = 1 : k
        label = 0;
        for l = 1 : size(training_labels(:,b(j)))
            if training_labels(l, b(j)) == 1
                label = l;
                break;
            end
        end
        label_counts(label) = label_counts(label) + 1;
    end   
    
    max_labels = 0;
    predicted_label = 0;
    for j = 1 : length(label_counts)
        if(label_counts(j) > max_labels)
            predicted_label = j;
            max_labels = label_counts(j);
        end
    end
    
    predicted_labels(i) = predicted_label - 1;
end

end

