function lec11_24()

dataPoints = 200;
dim = 2;

for overlap = 3.5 : -1 : 0.5
    data = randn(dataPoints, dim);
    data((dataPoints / 2 + 1) : dataPoints, :) = data((dataPoints / 2 + 1) : dataPoints, :) + overlap;
    labels = ones(200,1);
    labels((dataPoints / 2 + 1) : 200) = labels(101 : 200) * -1;
    
    class1 = zeros(2,dataPoints/2);
    class2 = zeros(2,dataPoints/2);
    c1 = 1; 
    c2 = 1;
    for i = 1 : dataPoints
        if (labels(i) == 1)
            class1(:, c1) = data(i,:);
            c1 = c1 + 1;
        else
            class2(:, c2) = data(i,:);
            c2 = c2 + 1;
        end
    end

    class1 = class1.';
    class2 = class2.';
    figure,
    plot(class1(:,1), class1(:,2), 'or')
    hold on
    plot(class2(:,1), class2(:,2), 'ob')

    [testx, testy] = meshgrid(min(data(:,1)):0.1:max(data(:,1)),min(data(:,2)):0.1:max(data(:,2)));
    kvals = [1 3 5 11 21 101];
    figure,
    for i = 1: length(kvals)
        k = kvals(i);
        grid_labels = zeros(size(testx));
        
        for m = 1 : size(testx,1)
            for n = 1 : size(testx, 2)
                curx = testx(m, n);
                cury = testy(m, n);
                
                distances = zeros(dataPoints, 1);
                for l = 1 : dataPoints
                    distances(l) = (data(l,1) - curx).^2 + (data(l,2) - cury).^2;
                end
                
                [values, index] = sort(distances);
                
                class1_count = 0;
                class2_count = 0;
                for r = 1: k
                    if (labels(index(r)) == 1)
                        class1_count = class1_count + 1;
                    else
                        class2_count = class2_count + 1;
                    end
                end
                
                if class1_count > class2_count
                    grid_labels(m, n) = 1;
                else
                    grid_labels(m, n) = -1;
                end
                
            end
        end
        
        subplot(3,2,i);
        plot(class1(:,1), class1(:,2), 'or')
        hold on
        plot(class2(:,1), class2(:,2), 'ob')
        contour(testx, testy, grid_labels, 2, 'k');
        hold off
    end
end

end

