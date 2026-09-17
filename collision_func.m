%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
% of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground <6
%x_wall: position of the wall >0
%OUTPUTS:
%t_ground: time that the egg would hit the ground
%t_wall: time that the egg would hit the wall
function [t_ground,t_wall] = collision_func(egg_params, y_ground, x_wall)
    %et_vals =  @(t) egg_trajectory01(t);
    %x0 = et_vals(1); y0 = et_vals(2); theta = et_vals(3); 
    trajectory_y = @(t) egg_trajectory_y(t,egg_params,y_ground)
    trajectory_x = @(t) egg_trajectory_x(t,egg_params,x_wall)

    %newton and secant struggles when slope nears infinity
    t_ground = bisection_solver1(trajectory_y, 0, 20, 1e-14, 1e-14, 100)
    t_wall =  bisection_solver1(trajectory_x, 0, 20, 1e-14, 1e-14, 100)

    xline(y_ground);
    yline(x_wall);
end

% function y_min = compute_y_min(et, time, egg_params)
%     [x, y, theta] = et(time);
%     y_out = G(2);
% end

