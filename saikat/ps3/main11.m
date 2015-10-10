clearvars
numDataA = 100;
numDataB = 100;
numData = numDataA + numDataB;
numDim = 2;
%%%%%%%%%%%
%%%%%Generate values from a normal distribution with mean 'x'
%%%%%and standard deviation 'y'.
%%%%%r = x + y.*randn(100,1);
%%%%loop on diffulty level
for g = 4 : -1.5 : 1
    X = [randn(numDataA, numDim);randn(numDataB, numDim)+ g];
    Y = [repmat(1,numDataA,1);repmat(-1,numDataA,1)];
    la = 1, lb = 1;
    clearvars classA
    clearvars classB
    for i = 1 : numData
    if (Y(i) == 1)
        classA(:,la) = X(i,:);
        la = la + 1;
    else
        classB(:,lb) = X(i,:);
        lb = lb + 1;
    end
    end

    classA = classA.';
    classB = classB.';
    figure,
    plot(classA(:,1), classA(:,2), 'or')
    hold on
    plot(classB(:,1), classB(:,2), 'ob')
    title('initial test data')
    
    %%%%generate test data coordinates in 2d plane
    [x1_test, x2_test] = meshgrid(min(X(:,1)):0.1:max(X(:,1)),min(X(:,2)):0.1:max(X(:,2)));
    K_vec = [1 3 5 11 21 101]
    figure,
    for i = 1: length(K_vec)
        cur_k = K_vec(i);
        classfier_op = zeros(size(x1_test));
        %%%%%for all points of X find distance to cur point
        for j = 1: length(x1_test(:))
            curx = x1_test(j);
            cury = x2_test(j);
            distances = zeros(numData, 1);
            for l = 1 : numData
                distances(l) = (X(l,1) - curx).^2 + (X(l,2) - cury).^2;
            end
            [val, index] = sort(distances);
            %%%%%check majority in top-k NNs
            classA_count = 0;
            classB_count = 0;
            for k = 1: cur_k
                if (Y(index(k)) == 1)
                    classA_count = classA_count + 1;
                else
                    classB_count = classB_count + 1;
                end
            end
            %%%%%% assign majority class for test data (x1_test(j),x2_test(j))
            if classA_count > classB_count
                classfier_op(j) = 1;
            else
                classfier_op(j) = -1;
            end
        end
        subplot(3,2,i);
        plot(classA(:,1), classA(:,2), 'or')
        hold on
        plot(classB(:,1), classB(:,2), 'ob')
        contour(x1_test, x2_test, classfier_op, 2, 'k');
        hold off
    end
end


