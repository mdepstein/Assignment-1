%example of how to implement finite difference approximation
%for the first and second derivative of a function
%INPUTS:
%fun: the mathetmatical function we want to differentiate
%x: the input value of fun that we want to compute the derivative at
%OUTPUTS:
%dfdx: approximation of fun'(x)
%d2fdx2: approximation of fun''(x)
function [dfdx,d2fdx2] = approximate_derivative(fun,x)
%set the step size to be tiny
delta_x = 1e-6;
%compute the function at different points near x
f_left = fun(x-delta_x);
f_0 = fun(x);
f_right = fun(x+delta_x);
%approximate the first derivative
dfdx = (f_right-f_left)/(2*delta_x);
%approximate the second derivative
d2fdx2 = (f_right-2*f_0+f_left)/(delta_x^2);
end

function [fval] = test_function(x)
fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end

[dfdx,d2fdx2] = approximate_derivative(@test_function,.7174)
k_predicted = abs(0.5*d2fdx2/dfdx)