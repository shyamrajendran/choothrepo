A=randn(1000,2);
x=A(:,1);
y=A(:,2);
plot(x,y,'Marker','.','LineStyle','none')
var(x)+1i*var(y)
mean(x)+1i*mean(y)


A=randn(3000,2);
x=A(:,1)';
y=A(:,2)';
x=[x(1:800)+3 1/2.*x(801:1800)-3 1.5.*x(1801:3000)+2];
y=[y(1:800)+4 1/2.*y(801:1800)   1.5.*y(1801:3000)-3];
plot(x,y,'Marker','.','LineStyle','none')
axis('equal')
var(x)+1i*var(y)
mean(x)+1i*mean(y)

count = 0;

for i = 1 : 21
    for j = 1 : 17
        count = count + 1;
    end
end

count

