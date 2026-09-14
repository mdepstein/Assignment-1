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
    max_iter = 1000;
    dx_max = 1e10;
    
    syms x y
    egg_equation = x^2/a^2 + (y^2/b^2)*e^(c*x) == 1;
    x_r = newton_solver1(egg_equation, x0, max_iter, ftol, dxto, dx_max);
    x_range = [x0-x_r, x+x_r]

    y_r = newton_solver1(egg_equation, y0, max_iter, ftol, dxto, dx_max);
    y_range = [y0-y_r, y+y_r]

end