function gunshot()

shot = 'shot.wav';
[shotSamples, shotRate] = audioread(shot);
t=[1/shotRate:1/shotRate:length(shotSamples)/shotRate];
figure,plot(t,shotSamples);

[shotSamplesRow, x] = size(shotSamples);
shotSamplesT = shotSamples.';
[x, shotSamplesTCol] = size(shotSamplesT);

pa = 'pa.wav';
[paSamples, paRate] = audioread(pa);
t=[1/paRate:1/paRate:length(paSamples)/paRate];
FigHandle = figure('name','lecture 8 slide 30','numbertitle','off');
set(FigHandle, 'Position', [50, 50, 1200, 400]);

plot(t,paSamples);

hold on



[paRow, x] = size(paSamples);

cols = uint8(paRow/shotSamplesTCol);
starti = 1;
paNew = zeros(shotSamplesTCol, cols);

for i = 1:cols
    if (starti+shotSamplesTCol > paRow) 
        break;
    end
    endi = starti+shotSamplesTCol-1;
    sample = paSamples(starti:endi,:);
    paNew(:,i)= shotSamplesT*sample;
    starti = endi;
end


op = paNew(:);


% op = shotSamplesT*paNew;
plot(t(1,1:length(op)),op/9);
hold off

end

