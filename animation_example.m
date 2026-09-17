%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
function animation_example()
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
y_ground = 0; %3.4779
x_wall = 25;
[t_ground,t_wall] = collision_func(egg_params, y_ground, x_wall);
clf
figure()
hold on;   %set up the plotting axis
axis([0,30,-5,30])
axis equal;
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
[x0,y0,theta] = egg_trajectory01(t,egg_params);
[V_list, ~] = egg_func(s,x0,y0,theta,egg_params);
%plot the perimeter of the egg
egg(1) = plot(V_list(1,:),V_list(2,:),Color='k');

for t=0:.001:t_ground
   
%compute the position of the square's center (travelling along ellipse)
[x0,y0,theta] = egg_trajectory01(t,egg_params);

[V_list, ~] = egg_func(s,x0,y0,theta,egg_params);
%update the coordinates of the square plot
set(egg(1),'xdata',V_list(1,:),'ydata',V_list(2,:));
%update the actual plotting window
drawnow;
end

egg(2) = xline(x_wall,'Color','r');
yline(y_ground,'Color','r');
[~,index] = min(V_list(2,:))
V_list(1,index)
hold on
egg(3) = plot(V_list(1,index), y_ground, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 3)
legend(egg, "egg","boundaries", "point of contact")
end