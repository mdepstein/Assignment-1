%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
%This version also store the animation in a vide.
function video_example()
%define location and filename where video will be stored
%written a bit weird to make it fit when viewed in assignment
mypath1 = 'C:\Users\kyue\OneDrive - Olin College of Engineering\Documents\MATLAB\Numerical Methods\Assignment-1';
fname='egg_animation.avi';
input_fname = [mypath1,fname];
%create a videowriter, which will write frames to the animation file
writerObj = VideoWriter(input_fname);
open(writerObj); %must call open before writing any frames
%Define the coordinates of the square vertices (in its own frame)
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
y_ground = 0; %3.4779
x_wall = 37;
[t_ground,t_wall] = collision_func(egg_params, y_ground, x_wall);
clf
fig1 = figure(1)
hold on;   %set up the plotting axis
axis([0,20,-5,30])
axis equal;
s = linspace(0,1,100);
a=3;
b=2;
c=.15;

x = [];
y = [];
title("Egg Flying Through Space", 'Interpreter', 'latex', 'FontSize', 18)
xlabel("Distance (m)")
ylabel("Height (m)")
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
egg(2) = xline(x_wall,'Color','r');
yline(y_ground,'Color','r');
legend("egg","boundaries")
current_frame = getframe(fig1);
%write the frame to the video
writeVideo(writerObj,current_frame);

%iterate through time
for t=0:.01:t_ground
   
%compute the position of the square's center (travelling along ellipse)
[x0,y0,theta] = egg_trajectory01(t,egg_params);

[V_list, ~] = egg_func(s,x0,y0,theta,egg_params);
%update the coordinates of the square plot
set(egg(1),'xdata',V_list(1,:),'ydata',V_list(2,:));


%update the actual plotting window
drawnow;

%capture a frame (what is currently plotted)
current_frame = getframe(fig1);
%write the frame to the video
writeVideo(writerObj,current_frame);
end
[~,index] = min(V_list(2,:))
V_list(1,index)
hold on
egg(3) = plot(V_list(1,index), y_ground, 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 3)
l = legend(egg, "egg","boundaries", "point of contact")
%must call close after all frames are written
close(writerObj);
end