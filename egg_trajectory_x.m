%Example parabolic trajectory
%egg starts at height of 6
% reaches peak of 29.3393 at 1.667s
%crosses 6 at 3.3333 seconds
function [x_diff] = egg_trajectory_x(t,egg_params,x_wall)
    x0 = 7*t + 8;
    y0 = -6*t.^2 + 20*t + 6;
    theta = 5*t;
    
    x_diff = box_wrapper_x(x_wall, x0,y0,theta,egg_params);

end