function fdop = generateFDfromfile(datafile, display, R_LOW, R_HIGH, G_LOW, G_HIGH, B_LOW, B_HIGH)
    %%%im - row * col image input
    %%%R/G/B_LOW/HIGH - low/high calibrated values of band
    if exist(datafile, 'file') ==  0
        fdop = [];
    else 
        im = imread(datafile);
        fdop = generateFD(im, display, R_LOW, R_HIGH, G_LOW, G_HIGH, B_LOW, B_HIGH);
    end
end