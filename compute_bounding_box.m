%Function that computes the bounding box of an oval
%INPUTS:
%theta: rotation of the oval. theta is a number from 0 to 2*pi.
%x0: horizontal offset of the oval
%y0: vertical offset of the oval
%egg_params: a struct describing the hyperparameters of the oval
%OUTPUTS:
%x_range: the x limits of the bounding box in the form [x_min,x_max]
%y_range: the y limits of the bounding box in the form [y_min,y_max]
function [x_range,y_range] = compute_bounding_box(x0,y0,theta,egg_params)    

    % Exit parameters
    dxtol = 1e-12;
    ftol = 1e-12;
    max_iter = 100000;
    dx_max = 1e10;

    % define wrapper functions
    %wrapper function that calls egg_wrapper1
    %but only takes s as an input (other inputs are fixed)
    %(single input)
    x_wrap = @(s) egg_wrapper_x(s,x0,y0,theta,egg_params);
    y_wrap = @(s) egg_wrapper_y(s,x0,y0,theta,egg_params);

    guess_list = linspace(0, 1, 6);
    y_limits = zeros(size(guess_list));
    x_limits = zeros(size(guess_list));


    for i=1:length(guess_list)
        guess = guess_list(i);
        
        x_root = secant_solver1(x_wrap, guess, guess+1, max_iter, ftol, dxtol, dx_max);
        y_root = secant_solver1(y_wrap, guess, guess+1, max_iter, ftol, dxtol, dx_max);
        
        x_limit_xy = egg_func(x_root, x0, y0, theta, egg_params);
        y_limits_xy = egg_func(y_root, x0, y0, theta, egg_params);

        x_limits(i) = x_limit_xy(1);
        y_limits(i) = y_limits_xy(2);
        
        % [~,y_bottom] = secant_solver1(egg_wrapper1, .75, .76, max_iter, ftol, dxtol, dx_max)
        % 
        % [~,x_right] = secant_solver1(egg_wrapper2, .25, .26, max_iter, ftol, dxtol, dx_max)
        % [~,x_left] = secant_solver1(egg_wrapper2, .75, .76, max_iter, ftol, dxtol, dx_max)
        % x_range = [x_left, x_right];
        % y_range = [y_top, y_bottom];
    end

    x_range = [min(x_limits), max(x_limits)];
    y_range = [min(y_limits), max(y_limits)];

end

function x_out = egg_wrapper_x(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    x_out = G(1);
end

function y_out = egg_wrapper_y(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    y_out = G(2);
end

% set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/6;
[x_range, y_range] = compute_bounding_box(x0,y0,theta,egg_params)
figure();
hold on
plot_egg(x0,y0,theta,egg_params);
x_plot_list = [x_range(1), x_range(1), x_range(2), x_range(2), x_range(1)];
y_plot_list = [y_range(1), y_range(2), y_range(2), y_range(1), y_range(1)];
plot(x_plot_list, y_plot_list, 'MarkerFaceColor','r','MarkerSize',3)
title('Egg with Boundary Box');
xlabel('x-axis');
ylabel('y-axis');
legend('Egg', 'Boundary Box');

axis equal
