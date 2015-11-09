function knn_sai_shyam()

%training_data = load('fd_sai_hand.mat');
training_data = load('fd_sam_hand.mat');
%training_labels = load('Y_sai_hand.mat');
training_labels = load('Y_sam_hand.mat');
%test_data = load('fd_sam_hand.mat');
test_data = load('fd_sai_hand.mat');
training_data = training_data.global_samples_fd;
training_labels = training_labels.Y;
test_data = test_data.global_samples_fd;

predicted_labels = zeros(size(test_data, 2), 1);
k = 20;

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
    
    predicted_labels(i) = predicted_label;
end

test_labels = load('Y_sam_hand.mat');
%test_labels = load('Y_sai_hand.mat');
test_labels = test_labels.Y;
correct_labels = 0;

for i = 1 : length(predicted_labels)
    if test_labels(predicted_labels(i), i) == 1
        correct_labels = correct_labels + 1;
    end
end

accuracy = correct_labels / size(test_data,2);
accuracy
end

