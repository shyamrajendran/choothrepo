function crop_image(actor_name, path, row_correction, col_correction)
    cd(path);
    jpgFiles = dir('*.jpg');
    numFiles = length(jpgFiles);
    mydata = cell(1,numFiles);
    
    for k = 1:numFiles
        mydata{k} = imread(jpgFiles(k).name);
    end
    
    j = 1;
    for k = 1:numFiles
        image = mydata{k};
        [r,c,v] = size(image);
        image = image(1:r-row_correction,1:c-col_correction,1:v);
         filename=sprintf('IMG_%d',j); 
         name = strcat('/tmp/',actor_name,'_',filename,'.JPG');
         imwrite(image, name);           
         j = j + 1;
    end
end
