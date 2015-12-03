function fd_op = gen_fd_from_mat(frame_set, calibrated_data)
[r,numframes] = size(frame_set);
count = 1;
fd_op = zeros(64, numframes);
for i =1:numframes
    im = frame_set(:,i);
    count
    if (mod(count,10) == 0 ) 
        fd = generateFD2(im, 1,calibrated_data.R_LOW, calibrated_data.R_HIGH, calibrated_data.G_LOW, calibrated_data.G_HIGH, calibrated_data.B_LOW, calibrated_data.B_HIGH);
    else
        fd = generateFD2(im, 0,calibrated_data.R_LOW, calibrated_data.R_HIGH, calibrated_data.G_LOW, calibrated_data.G_HIGH, calibrated_data.B_LOW, calibrated_data.B_HIGH);
    end
    count = count + 1;
    fd_op(:,k) = fd;
end
end