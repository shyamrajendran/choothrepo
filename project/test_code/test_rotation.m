clearvars
close all

%%%%calibrate band range
R_LOW = 9999
R_HIGH = -1
G_LOW = 9999
G_HIGH = -1
B_LOW = 9999
B_HIGH = -1
for count = 1:4
    im = imread(['../testhand/testimg/saikat/CALIB_', int2str(count), '.JPG']);
    [row, col, h] = size(im);
    for i = 1:row
        for j = 1:col
            if im(i,j,1) < R_LOW
                R_LOW = im(i,j,1);
            end
            if im(i,j,2) < G_LOW
                G_LOW = im(i,j,2);
            end
            if im(i,j,3) < B_LOW
                B_LOW = im(i,j,3);
            end
            if im(i,j,1) > R_HIGH
                R_HIGH = im(i,j,1);
            end
            if im(i,j,2) > G_HIGH
                G_HIGH = im(i,j,2);
            end
            if im(i,j,3) > B_HIGH
                B_HIGH = im(i,j,3);
            end
        end
    end    
end

for count = 1:10
    im = imread(['../testhand/testimg/saikat/IMG_', int2str(count), '.JPG']);
    figure,
    subplot(3,3,1)
    
    rand_angle = randi([-45 45], 1);
    im = imrotate(im, rand_angle);
    im1 = imresize(im, [200 200]);
    imshow(im)
    [row, col, h] = size(im1);
    
    %%%%% for band
    %%%r - 38-65, g - 100-136, b-34-60
    segop = zeros(row,col);
    bandop = zeros(row,col);
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
            %%%%% this will change based on band color/calibration
            if count == 8
                if R >= 38 && R <= 65 && G >=100 && G <=255 && B >=34 && B <= 60
                    bandop(i,j) = 1;
                end
            end
            if count == 9 || count == 10 || count == 11
                if R >= 90 && R <= 230 && G >=6 && G <=40 && B >=45 && B <= 150
                    bandop(i,j) = 1;
                end
            end
%             if count == 12 || count == 13 || count == 14
            if count >= 1 && count <=10
                if R >= R_LOW && R <= R_HIGH && G >=G_LOW && G <= G_HIGH && B >=B_LOW && B <= B_HIGH
                    bandop(i,j) = 1;
                end
            end
        end
    end
    subplot(3,3,2),
    colormap gray
    imagesc(segop)
    segopm = medfilt2(segop, [ 5 5]);
    segopm1 = imclose(segopm, strel('rectangle',[5 5]));

    %%%% morpohological ops
    bandopm = medfilt2(bandop, [5 5]);
%     bandopm = bandop;
    bandopm1 = imclose(bandopm, strel('rectangle',[5 5]));
    subplot(3,3,3),
    colormap gray
    imagesc(bandopm1),
    
    subplot(3,3,4),
    colormap gray
    imagesc(segopm1),

    %%%%%%%%%%%%%%%%rotation of image
    %%% needs to be collected from actual size calibration of band
    average_band_pixel = 10*20;
    binaryImage = bandopm > 0;
    binaryImage = bwareaopen(binaryImage, average_band_pixel);
%     imshow(binaryImage)
    orientation = regionprops(binaryImage, 'Orientation');
    centroid = regionprops(binaryImage,'centroid');
    rotated = imrotate(segopm1, -orientation(1).Orientation);
    subplot(3,3,5),
    colormap gray
    imshow(rotated)
    
    rows_rotated = size(rotated,1);
    dist = zeros(rows_rotated,1);
    for row_count = rows_rotated:-1:1
        s = find(rotated(row_count,:), 1, 'first');
        e = find(rotated(row_count,:), 1, 'last');
        if(~isempty(s) && ~isempty(e))
            dist(row_count) = e - s;
        end
    end
    
    dist = smooth(dist, 15);
%     %%%%%%%%%%%%%%simplified wrist deteciton
%     for i = size(dist,1) - 1 :-1 :1
%         if (dist(i,1)-dist(i+1,1))
%     end
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure, plot(-dist)
    % Find peaks
    [pks, locs] = findpeaks(-dist);
    th = 20; % A threshold on the distance among peaks
    if length(locs) == 0
    else
        if (length(locs) == 1)
        loc = locs(1);
        else
        loc = locs(end);
        for i = length(locs)-1 : -1 : 1
            if(abs(locs(i) - loc) > th)
                break;
            else
                loc = locs(i);
            end
        end
        end
        % Keep best
        ycut = loc;

        %%%%%%clear all values below ycut
        for y = ycut:rows_rotated
            rotated(y,:) = 0;
        end
    end
    
    
    subplot(3,3,6)
    colormap gray
    imshow(rotated)
    hold on
    %     %%%%%%%%%%%%%%%%% calculate centroid of the hand area
    sumx = 0;sumy = 0;pixelcount = 0;
    for i = 1:row
        for j = 1:col
            if segopm1(i,j) > 0
                sumy =  sumy + j;
                sumx =  sumx + j;
                pixelcount = pixelcount + 1;
            end
        end
    end
    centroid = [sumx/pixelcount;sumy/pixelcount];
    scatter(centroid(1), centroid(2), 'ro');
    e = edge(rotated, 'canny');
    subplot(3,3,7)
    colormap gray
    imshow(e)
    figure, plot(dist)
end


