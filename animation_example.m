%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
function animation_example(t_end)
y_ground = 0; %3.4779
x_wall = 25;

clf
figure()
hold on; axis equal; axis square %set up the plotting axis
axis([0,50,-50,25])
s = linspace(0,1,100);
a=3;
b=2;
c=.15;
x = [];
y = [];

for i = s
    %compute x (without rotation or translation)
    x(end+1) = a*cos(2*pi*i);
    %useful intermediate variable
    f = exp(-c*x(end)/2);
    %compute y (without rotation or translation)
    y(end+1) = b*sin(2*pi*i).*f;
end
t = 0;
x0 = 7*t + 8;
y0 = -6*t.^2 + 20*t + 6;
theta = 5*t;
%rotation matrix corresponding to theta
R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
%compute position and gradient for rotated + translated oval
V = R*[x;y]+[x0*ones(1,length(theta));y0*ones(1,length(theta))];
egg = plot(V(1,:),V(2,:));

for t=0:.001:t_end
   
%compute the position of the square's center (travelling along ellipse)
x0 = 7*t + 8;
y0 = -6*t.^2 + 20*t + 6;
theta = 5*t;

%rotation matrix corresponding to theta
R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
%compute position and gradient for rotated + translated oval
V = R*[x;y]+[x0*ones(1,length(theta));y0*ones(1,length(theta))];
%update the coordinates of the square plot
set(egg,'xdata',V(1,:),'ydata',V(2,:));
%update the actual plotting window
drawnow;
end

xline(y_ground);
yline(x_wall);
x(find(abs(y-y_ground)<1e-10))
plot(x(find(abs(y-y_ground)<1e-10)),y_ground,MarkerFaceColor='r', MarkerSize=3)
end