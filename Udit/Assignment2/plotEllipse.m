function plotEllipse(a,b,C)
% range to plot over    
%------------------------------------    
N = 50;     
theta = 0:1/N:2*pi+1/N;
% Parametric equation of the ellipse
%   
%----------------------------------------    
state(1,:) = a*cos(theta);      
state(2,:) = b*sin(theta);      
% Coordinate transform (since your ellipse is axis aligned)     
%----------------------------------------     
X = state;     
X(1,:) = X(1,:) + C(1);     
X(2,:) = X(2,:) + C(2);      
% Plot     %----------------------------------------     
plot(X(1,:),X(2,:));     
hold on;     
plot(C(1),C(2),'r*');     
axis equal;     
grid; 
end
