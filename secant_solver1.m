%Root finding function via secant method
%INPUTS:
% fun: the function we are computing the root of
% x0: first guess for secant method
% x1: second guess for secant method
% dxtol: termination threshold (stop when interval abs(x1-x0) < dxtol)
% ftol: termination threshold (stop when abs(f(x0))<ftol
% max_iter: maximum iteration limit
% dxmax: threshold for checking for a divide by zero error:
% terminate when abs(x1-x0) > dxmax, where dxmax is a very large number
%OUTPUTS
% x: estimate for root of fun
% exit_flag: an integer indicating whether or not the solver succeeded
function [x, flag] = secant_solver1(fun,x0,x1,max_iter,ftol,dxtol,dx_max)
    f0 = fun(x0);
    for i = 1:max_iter
        f1 = fun(x1);
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
        % plot(x2,0,".","MarkerSize",10, "Color",'b');
        
        if abs(f1) <= ftol
            fprintf('ftol\n');
            x = x1;
            flag = 0;
            return
        end

        if abs(x2-x1) <= dxtol
            fprintf('dxtol\n');
            x = x2;
            flag = 0;
            return
        end

        if abs(f1 - f0) > dx_max
            fprintf('dx_max\n');
            x = x2;
            flag = 1;
            return
        end  

        x0=x1;
        x1=x2;
        f0=f1;
        
    end
    flag = 1;
    x = x1;
end