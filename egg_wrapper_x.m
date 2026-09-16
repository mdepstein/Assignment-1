function x_out = egg_wrapper_x(s,x0,y0,theta,egg_params)
[~, G] = egg_func(s,x0,y0,theta,egg_params);
x_out = G(1);
end
