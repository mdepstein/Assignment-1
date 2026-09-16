

function y_out = egg_wrapper_y(s,x0,y0,theta,egg_params)
[~, G] = egg_func(s,x0,y0,theta,egg_params);
y_out = G(2);
end