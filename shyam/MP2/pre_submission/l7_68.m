
FigHandle = figure('name','lecture 5 - 25','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1000, 500]);

%% input
file = 'hotlips.mp4';
v = VideoReader(file);
i = 1;

while hasFrame(v)
    frame = readFrame(v);
    grayScale = rgb2gray(frame);
    video(:,i) = grayScale(:);
    i = i + 1;
end
X = double(video);
[H,V,P] = size(frame);
N = 86;
W = zeros(N);

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
neighbours = 8;
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
subplot(1,2,1)
scatter(U(:,N-1),U(:,N-2),50,cmap),colormap gray, title(' with 8 neighbours ')


%% k = 25
tw = zeros(N);
neighbours = 25;
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
subplot(1,2,2)
scatter(U(:,N-1),U(:,N-2),50,cmap),colormap gray, title(' with 25 neighbours ');
