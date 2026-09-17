function y_diff = box_wrapper_y(y_ground, x0,y0,theta,egg_params)
[~, y_range] = compute_bounding_box(x0,y0,theta,egg_params);
y_diff = y_range(1)-y_ground; %abs(diff)?
end

