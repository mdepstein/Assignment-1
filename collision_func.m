%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
% of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground
%x_wall: position of the wall
%OUTPUTS:
%t_ground: time that the egg would hit the ground
%t_wall: time that the egg would hit the wall
function [t_ground,t_wall] = collision_func(traj_fun, egg_params, y_ground, x_wall)
    et_vals =  @(t) egg_trajectory01(t);
    x0 = et_vals(1); y0 = et_vals(2); theta = et_vals(3); 
    [x_range, y_range] = compute_bounding_box(x0, y0, theta, egg_params);
    y_min = min(y_range); x_max = max(x_range);
    t_ground = secant_solver1(y_min-y_ground, y_ground, y_ground+1, 1000, 1e-14, 1e-14, 1e3);
    t_wall = secant_solver1(x_max-x_wall, x_wall, x_wall+1, 1000, 1e-14, 1e-14, 1e3);  

    xline(y_ground);
    yline(x_wall);
end

% function y_min = compute_y_min(et, time, egg_params)
%     [x, y, theta] = et(time);
%     y_out = G(2);
% end

