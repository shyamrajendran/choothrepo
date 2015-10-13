function lec9_53()

face_data = load('face2.mat');
faces = face_data.XX;
labels = face_data.g;

average_face = zeros(780,1);
for i = 1 : 400
    average_face = average_face + faces(:,i);
end

average_face = average_face / 400;

figure
colormap gray
imagesc(reshape(average_face,30,26));

for i = 1 : 400
    faces(:,i) = faces(:,i) - average_face;
end

[U,S,V] = svd(cov(faces.'));
W = U(:,1:2).';
Z = W * faces;

c1 = 1; 
c2 = 1;
for i = 1 : 400
    if labels(i) == 1
        class1(:,c1) = Z(:,i);
        c1 = c1 + 1;
    else
        class2(:,c2) = Z(:,i);
        c2 = c2 + 1;
    end
end
    
figure
plot(Z(1,:),Z(2,:),'.');

figure
plot(class1(1,:),class1(2,:),'r.');
hold on
plot(class2(1,:),class2(2,:),'b.');

% For class 1 data
u1x = mean(class1(1,:));
u1y = mean(class1(2,:));
u1 = [u1x ; u1y];
var1 = rms(class1);
w1 = u1 ./ var1;
b1 = -(u1.' * u1 / (2 * var1)) + log(0.5);

% For class 2 data
u2x = mean(class2(1,:));
u2y = mean(class2(2,:));
u2 = [u2x ; u2y];
var2 = rms(class2);
w2 = u2 ./ var2;
b2 = -(u2.' * u2 / (2 * var2)) + log(0.5);

c1 = 0; c2 = 0;
for i = 1 : size(class2,2)
    l1 = gfunc(class1(:,i),w1,b1,w2,b2);
    l2 = gfunc(class2(:,i),w1,b1,w2,b2);
    if l1 == 1
        c1 = c1 + 1;
    else
        c2 = c2 + 1;
    end
    
    if l2 == 1
        c1 = c1 + 1;
    else
        c2 = c2 + 1;
    end
    
end

%% Quadratic Boundary
cov1 = cov(class1.');
invcov1 = inv(cov1);
W1 = invcov1 .* (-0.5);
w1 = invcov1 * u1;
b1 = ((u1.' * w1).*(-0.5)) - (0.5 * log(det(cov1))) + log(0.5);

cov2 = cov(class2.');
invcov2 = inv(cov2);
W2 = invcov2 .* (-0.5);
w2 = invcov2 * u2;
b2 = ((u2.' * w2).*(-0.5)) - (0.5 * log(det(cov2))) + log(0.5);

c1 = 0; c2 = 0;
for i = 1 : size(class2,2)
    l1 = gquad(class1(:,i),W1,w1,b1,W2,w2,b2);
    l2 = gquad(class2(:,i),W1,w1,b1,W2,w2,b2);
    if l2 == 1
        c1 = c1 + 1;
    else
        c2 = c2 + 1;
    end
    
    if l2 == 1
        c1 = c1 + 1;
    else
        c2 = c2 + 1;
    end
    
end

c1
c2
end
