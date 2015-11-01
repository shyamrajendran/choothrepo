clearvars
input_hand = [zeros(20, 60);2 + ones(20,20) zeros(20, 10) 2 + ones(20, 30) ...
    ;zeros(20,60)];
input = [zeros(20, 60);zeros(20,20) ones(20, 10) zeros(20, 30) ...
    ;zeros(20,60)];
total_hand = input_hand + input;
input = rot90(input);
total_hand = rot90(total_hand);
figure, colormap gray, imagesc(input)
figure, colormap gray, imagesc(total_hand)
hold on
% c_hand_x = 15;
% c_hand_y = 30;
% c_band_x = 25;
% c_band_y = 30;
c_hand_x = 30;
c_hand_y = 10;
c_band_x = 30;
c_band_y = 35;

c_hand = [c_hand_x;c_hand_y]
c_band = [c_band_x;c_band_y]
x = [c_hand_x; c_band_x];
y = [c_hand_y; c_band_y];
% figure
scatter(x, y, 'ro')
hold on
c_diff = c_hand -  c_band;
%%%notation anticlockwise +ve angle, clockwise -ve angle
%%%%% hand pointing straight up: -90, straight down: 90, 
%%%%% hand pointing straight right:0 straight left: 180, 
thetad = atand(c_diff(2)/c_diff(1))
s1_min = -30;
s1_max = 30;
index = s1_min:1:s1_max;
count = [];
i = 1;
for s1 = s1_min:1:s1_max
    p1 = c_band + s1 * [cosd(thetad + 90);sind(thetad + 90)];
    count(i) = 0;
    for s2 = -10:1:10
        p2 = p1 + s2*[cosd(thetad);sind(thetad)];
        if p2(1) > 0 && p2(2) > 0 && input(p2(2), p2(1)) == 1
            count(i) = count(i) + 1;
        end
        scatter(p2(1), p2(2), 'bo')
        hold on
    end
    i = i + 1;
end

l = length(count);
for i = 2: l
    if count(i) > 0 && count(i-1) <= 0
        bleft = c_band + index(i) * [cosd(thetad + 90);sind(thetad + 90)];
    end
    if count(i) == 0 && count(i-1) > 0
        bright = c_band + index(i) * [cosd(thetad + 90);sind(thetad + 90)];
    end
end
% bleft
% bright
scatter(bleft(1), bleft(2), 'yo')
scatter(bright(1), bright(2), 'go')
figure, plot(count, 'ko')


left_radius = sqrt((bleft(1) - c_hand(1))^2 +  (bleft(2) - c_hand(2))^2);
right_radius = sqrt((bright(1) - c_hand(1))^2 +  (bright(2) - c_hand(2))^2);
rband = max(left_radius, right_radius)

%%%find theta min and max w.r.t centroid of hand
% theta_bandmax = max(atand(bleft(2)/bleft(1)), atand(bright(2)/bright(1)))
% theta_bandmin = min(atand(bleft(2)/bleft(1)), atand(bright(2)/bright(1)))

% theta_bandmin = atand(bleft(2) - c_hand(2)/bleft(1) - c_hand(1))
% theta_bandmax = atand(bright(2) - c_hand(2)/bright(1) - c_hand(1))


left_diff = c_hand -  bleft;
theta_left = atand(left_diff(2)/left_diff(1))
if theta_left < 0
    theta_left =  theta_left + 180;
end

right_diff = c_hand -  bright;
theta_right = atand(right_diff(2)/right_diff(1))
if theta_right < 0
    theta_right =  theta_right + 180;
end

theta_bandmin = min(theta_right, theta_left)
theta_bandmax = max(theta_right, theta_left)

[row,col] = size(total_hand);
op = total_hand;
for i = 1:row
    for j = 1:col
        diff = c_hand - [j;i];
        theta = atand(diff(2)/diff(1))
        if theta < 0
            theta =  theta + 180;
        end
        radius = sqrt((i - c_hand(2))^2 +  (j - c_hand(1))^2);
        if theta >= theta_bandmin && theta <= theta_bandmax ...
                && radius > rband
            op(i,j) = 4;
        end
    end
end
figure, colormap gray, imagesc(op)
