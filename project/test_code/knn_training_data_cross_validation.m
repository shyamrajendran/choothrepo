function knn_training_data_cross_validation()
trainingFiles = 'fd_sai_hand.mat,fd_sam_hand.mat,fd_udit_hand.mat,fd_sai_colored_bg.mat,fd_sam_colored_bg.mat,fd_sai_new_2';
trainingLabelFiles = 'Y_sai_hand.mat,Y_sam_hand.mat,Y_udit_hand.mat,Y_sai_colored_bg.mat,Y_sam_colored_bg.mat,Y_sai_new_2';
trainFiles = strsplit(trainingFiles,',');
trainLabelFiles = strsplit(trainingLabelFiles,',');
data = load(trainFiles{1});
all_data = data.global_samples_fd;
labels = load(trainLabelFiles{1});
all_labels = labels.Y;
for i = 2 : length(trainFiles)
    data = load(trainFiles{i});
    d = data.global_samples_fd;
    labels = load(trainLabelFiles{i});
    l = labels.Y;  
    all_data = [all_data,d];
    all_labels = [all_labels,l];
end

permutation = uint32(randperm(size(all_data, 2)));
training_set_length = uint32(0.7 * size(all_data, 2));
training_data = all_data(:,permutation(1));
training_labels = all_labels(:,permutation(1));

for i = 2 : training_set_length
    training_data = [training_data, all_data(:,permutation(i))];
    training_labels = [training_labels, all_labels(:,permutation(i))];
end

test_data = all_data(:,permutation(training_set_length + 1));
test_labels = all_labels(:,permutation(training_set_length + 1));

for i = (training_set_length + 2) : size(all_data, 2)
    test_data = [test_data, all_data(:,permutation(i))];
    test_labels = [test_labels, all_labels(:,permutation(i))]; 
end

accuracies_training = knn_prediction(training_data, training_labels, training_data, training_labels);
accuracies_test = knn_prediction(training_data, training_labels, test_data, test_labels);

figure
plot(accuracies_training);
hold on
plot(accuracies_test);
xlabel('k value');
ylabel('accuracy');
legend('Accuracy on Training','Accuracy on Test','Location','northeast')
%{
predicted_labels = zeros(size(test_data, 2), 1);
accuracies = zeros(20);

max_accuracy = 0;
for k = 1 : 20

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

correct_labels = 0;

for i = 1 : length(predicted_labels)
    if test_labels(predicted_labels(i), i) == 1
        correct_labels = correct_labels + 1;
    end
end

accuracy = correct_labels / size(test_data,2);
accuracies(k) = accuracy;

if accuracy > max_accuracy
    max_accuracy = accuracy;
end

end

max_accuracy
figure
plot(accuracies);
title('Accuracy on Training Data Set');
xlabel('k value');
ylabel('accuracy');
%}
end