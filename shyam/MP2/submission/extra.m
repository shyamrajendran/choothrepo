load one.mat;
[R, C] = size(one);

for i = 1:C
    input(:,i) = one{i}(:);
end

X = input;

N = 1135;
% figure,imagesc(X),colormap gray;
%%
% finding the distance between points
for i = 1:N
    frame1 = X(:,i);
    for j = 1:N
        frame2 = X(:,j);
        costheta = dot(frame1,frame2)/(norm(frame1)*norm(frame2));
%         theta = acos(costheta);
        W(i,j) = costheta;
    end
end

% figure,imagesc(W), colormap gray


%%
tw = zeros(N);
neighbours = 100;
for i = 1:N
    [sort_data, sort_index] = sort(W(i,:),'descend');
    for j = 2:neighbours
        max_index = sort_index(1,j);
        tw(i,max_index) = sort_data(1,j);
    end
end
% figure, imagesc(tw),colormap gray;


onet = ones(N,1).';
rs = onet*tw;
D = diag(rs);
L = tw - D;
for i = 1:N
    if (rs(1,i) ~= 0) 
        rs(1,i) = rs(1,i).^(-0.5);
    end
end
D1 = diag(rs);
Lchandra = (D1*L*D1);
% figure,imagesc(Lchandra);
[U,S,V] = svd(Lchandra);
cmap = jet(N);
% subplot(1,2,1)
scatter(U(:,N-1),U(:,N-2)),colormap gray, title('I can observe that when LE is applied on the input data, ones.mat and project it down to 2 dimension, the pattern of 1 is clearly seen');
