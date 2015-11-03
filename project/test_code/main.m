clearvars
for count  = 1:7
    im = imread(['test', int2str(count), '.jpg']);
    figure,
    subplot(1,4,1)
    im = imrotate(im, 90);
    imshow(im)
    im1 = imresize(im, .5);
    [row, col, h] = size(im1);
    
    segop = zeros(row,col);
    for i = 1:row
        for j = 1:col
            rgbseg = 0;
            yseg = 0;
            R = im1(i,j,1);
            G = im1(i,j,2);
            B = im1(i,j,3);
            Y = 0.299 * R + 0.587*G + 0.114*B;
            Cr = 128 + (0.5 * R) - (0.418 * G) -(0.081*B);
            Cb = 128 - (0.168 * R) -(0.331*G) + (0.5 * B);
            if (Y > 80) && (Cb > 85 && Cb <135) && (Cr > 135 && Cr < 180)
                yseg = 1;
            end
            minval = min(min(R,G),B);
            maxval = max(max(R,G),B);
            if R > 95 && G > 40 && B > 20 && (maxval-minval)>15 ...
                    && abs(R-G)>15 &&  R > G && R > B
                rgbseg = 1;
            end
            if yseg == 1 || rgbseg == 1
                segop(i,j) = 1;
            end
        end
    end
    subplot(1,4,2),
    colormap gray
    imagesc(segop)
    segopm = medfilt2(segop, [10 10]);
    segopm1 = imclose(segopm, strel('rectangle',[10 10]));
    
    orientation = regionprops(int64(segopm1), 'Orientation');
    centroid = regionprops(segopm1,'centroid');

    %%%%%%%%%%%%%%%%% calculate centroid of the hand area
    sumx = 0;sumy = 0;pixelcount = 0;
    for i = 1:row
        for j = 1:col
            if segopm1(i,j) == 1
                sumy =  sumy + j;
                sumx =  sumx + j;
                pixelcount = pixelcount + 1;
            end
        end
    end
    centroid = [sumx/pixelcount;sumy/pixelcount];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(1,4,3)
    colormap gray
    imagesc(segopm1),
    hold on
    scatter(centroid(1), centroid(2), 'go');
%     e = canny(double(segop), [],[]);
    e = edge(segopm1);
    subplot(1,4,4),
    colormap gray
    imshow(e)
end
% % [U,S,V] = svd(double(im(:)));
% % imbw = im2bw(im);
% % g = rgb2gray(im);
% % [e,t] = edge(rgb2gray(im));
% e = canny(double(yseg), [],[]);
% % ep = e(1:100,1:100,1:3);
% figure,colormap gray
% subplot(1,3,1)
% imagesc(e(:,:,1))
% subplot(1,3,2)
% imagesc(e(:,:,2))
% subplot(1,3,3)
% imagesc(e(:,:,3))
% 
% % imshow(e)
% % plot3(e.subpix{1}(e.edge), ...
% %       e.subpix{2}(e.edge), e.subpix{3}(e.edge), '.');
