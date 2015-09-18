function l3_21()
N = 32;
[X, Y]= meshgrid(2*pi*(1:N)/N, 2*pi*(1:N)/N);

o1 = sin(3*X);
o2 = sin(5*Y);
o3 = sin(3*(X+Y));
o4 = sin(3*(X+Y)) + sin(6*X + 8*Y);
FigHandle = figure;
  set(FigHandle, 'Position', [50, 50, 2000, 1000]);

subplot(2,4,1)
imagesc(imcomplement(o1)),colormap gray, title(' sin(3*X)');
subplot(2,4,3)
imagesc(imcomplement(o2)),colormap gray,title(' sin(5*Y)');
subplot(2,4,5)
imagesc(imcomplement(o3)),colormap gray,title(' sin(3*(X+Y))');
subplot(2,4,7)
imagesc(imcomplement(o4)),colormap gray,title(' sin(3*(X+Y)) + sin(6*X+8*Y)');


t = o1*mydft(N);
oo1 = mydft(N)*t;
subplot(2,4,2)
imagesc(imcomplement(abs(oo1))),colormap gray, title(' sin(3*X)');
view(0,90);axis xy; axis tight;


t = o2*mydft(N);
oo2 = mydft(N)*t;
subplot(2,4,4)
imagesc(imcomplement(abs(oo2))),colormap gray, title(' sin(5*Y)');
view(0,90);axis xy; axis tight;

t = o3*mydft(N);
oo3 = mydft(N)*t;
subplot(2,4,6)
imagesc(imcomplement(abs(oo3))),colormap gray, title(' sin(3*(X+Y))');
view(0,90);axis xy; axis tight;


t = o4*mydft(N);
oo4 = mydft(N)*t;
subplot(2,4,8)
imagesc(imcomplement(abs(oo4))),colormap gray, title(' sin(3*(X+Y)) + sin(6*X+8*Y)');
view(0,90);axis xy; axis tight;

end