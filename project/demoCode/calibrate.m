function [calibrated_data] = calibrate(filename, total)
R_LOW = 9999;
R_HIGH = -1;
G_LOW = 9999;
G_HIGH = -1;
B_LOW = 9999;
B_HIGH = -1;

for count = 1:total
    calibfile = [filename, 'CALIB_', int2str(count), '.JPG'];
    calibfile
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

calibrated_data = struct();
calibrated_data.R_LOW = R_LOW;
calibrated_data.R_HIGH = R_HIGH;
calibrated_data.G_LOW = G_LOW;
calibrated_data.G_HIGH = G_HIGH;
calibrated_data.B_LOW = B_LOW;
calibrated_data.B_HIGH = B_HIGH;

end