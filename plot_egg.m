function plot_egg(x0,y0,theta,egg_params)
s = linspace(0,1,100);
a=egg_params.a;
b=egg_params.b;
c=egg_params.c;
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

%rotation matrix corresponding to theta
R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
%compute position and gradient for rotated + translated oval
V = R*[x;y]+[x0*ones(1,length(theta));y0*ones(1,length(theta))];
plot(V(1,:),V(2,:))
end