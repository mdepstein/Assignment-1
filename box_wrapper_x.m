function x_diff = box_wrapper_x(x_wall, x0,y0,theta,egg_params)
[x_range, ~] = compute_bounding_box(x0,y0,theta,egg_params);
x_diff = x_wall-x_range(2); %abs(diff)?
end

