function knn()

data = load('global_fd.mat');

training_data = data.global_fd;
test_data = data.global_fd_test;
k = 1;

predicted_labels = size(test_data, 1);

for i = 1 : size(test_data, 1)
    test_row = test_data(i,:);
    len = size(training_data, 1);  
    dist_vec = zeros(len, 1);
    for j = 1 : len
        row = training_data(j, 1 : size(training_data, 2) - 1);
        dist = (row - test_row) .^ 2;
        dist = sum(dist) ^ 0.5;
        dist_vec(j) = dist;
    end
    
    [a, b] = sort(dist_vec);
    label_counts = zeros(10, 1);
    
    for j = 1 : k
        label = training_data(b(j), size(training_data,2)); 
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
    
    predicted_labels(i) = predicted_label;
end

end

