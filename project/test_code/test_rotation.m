function fd_op = test_rotation(totalcount, filename)
%%%complex = 0 is complex coordinate signature
%%% else centroid distance signature
complex = 0;
%%% test =1 for testing, test=0 for training

%%%%calibrate band range
R_LOW = 9999;
R_HIGH = -1;
G_LOW = 9999;
G_HIGH = -1;
B_LOW = 9999;
B_HIGH = -1;

for count = 1:totalcount
    calibfile = [filename, 'CALIB_', int2str(count), '.JPG'];
    if exist(calibfile, 'file')
        im = imread(calibfile);
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
end

for count = 1:totalcount
    datafile = [filename, 'IMG_', int2str(count), '.JPG'];
    if exist(datafile, 'file')
        im = imread(datafile);
        figure,
        subplot(3,3,1)

        rand_angle = randi([-45 45], 1);
        %%% give a random rotation to the gesture
        im = imrotate(im, rand_angle);
        im1 = imresize(im, [200 150]);
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
                if R >= R_LOW && R <= R_HIGH && G >=G_LOW && G <= G_HIGH ...
                        && B >=B_LOW && B <= B_HIGH
                    bandop(i,j) = 1;
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
        orientation = regionprops(binaryImage, 'Orientation');
        centroid = regionprops(binaryImage,'centroid');
        rotated = imrotate(segopm1, -orientation(1).Orientation);
        subplot(3,3,5),
        colormap gray
        imshow(rotated)

        [rows_rotated, cols_rotated] = size(rotated);
        dist = zeros(rows_rotated,1);
        for row_count = rows_rotated:-1:1
            s = find(rotated(row_count,:), 1, 'first');
            e = find(rotated(row_count,:), 1, 'last');
            if(~isempty(s) && ~isempty(e))
                dist(row_count) = e - s;
            end
        end

        dist = smooth(dist, 15);
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
        for i = 1:rows_rotated
            for j = 1:cols_rotated
                if rotated(i,j) > 0
                    sumy =  sumy + i;
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
        %%%get the clockwise pixels form the edge image
        e_b = bwboundaries(e, 'noholes');
    %     for k = 1%:length(e_b)
    %         boundary = e_b{k};
    %         scatter(boundary(:,2), boundary(:,1), 'ro')
    %     end
        %%biggest boundary should be hand
        boundary = e_b{1};
        subplot(3,3,8),
        fnplt(cscvn(boundary.'),'r',2);
        pt = interparc(128,boundary(:,2),boundary(:,1),'spline');
        xc = mean(pt(:,1));
        yc = mean(pt(:,2));
        subplot(3,3,9),
        plot(pt(:,1),pt(:,2),'b-o')
        hold on
        plot(xc,yc,'ro')
    %     figure, plot(dist)
        if complex == 1
            %%%now make the pt data zero mean for fourier descpitor calc
            pt(:,1) = pt(:,1) - xc;
            pt(:,2) = pt(:,2) - yc;
            %%%%complex coordinate method
            xy = pt(:,1) + 1j * pt(:,2);
            xy_fd = fft(xy);
            FD1 = abs(xy_fd(2));
            xy_fd = xy_fd(3:length(xy_fd));
            fd = zeros(length(xy_fd),1);
            for i = 1:length(xy_fd)
                fd(i,1) = abs(xy_fd(i))/ FD1;
            end
        else
            %%%else use centroid distance method
            xy = zeros(length(pt),1);
            for i = 1:length(pt)
                xy(i,1) = sqrt((pt(i,1) - xc).^2 + (pt(i,2) - yc).^2);
            end
            xy_fd = fft(xy);
            xy_fd = xy_fd(1:length(xy_fd)/2 + 1);
            fd = zeros(length(xy_fd)-1,1);
            FD0 = abs(xy_fd(1));
            xy_fd = xy_fd(2:length(xy_fd));
            for i = 1:length(xy_fd)
                fd(i,1) = abs(xy_fd(i))/ FD0;
            end
        end

        fd = circshift(fd, length(fd)/2);
        figure,plot(fd)
        global_fd(count,:) = fd.';
    end
end
fd_op = global_fd;
end
