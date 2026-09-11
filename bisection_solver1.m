%Root finding function via bisection algorithm CLEAN CONVERGENCE PLOT
%INPUTS:
% fun: the function we are computing the root of
% x_left: left guess
% x_right: right guess
% note that f(x_left) and f(x_right) should have different signs
% dxtol: termination threshold (stop when interval x_right-x_left < dxtol)
% ftol: termination threshold (stop when abs(f(x_guess))<ftol
% max_iter: maximum iteration limit
%OUTPUTS
% x: estimate for root of fun
% exit_flag: 1 if success, 0 if fail
function [x,flag] = bisection_solver1(fun,x_left,x_right,dxtol,ftol,max_iter)
    if(x_left>=x_right)
        flag = 2;
        return
    end
    for i = 1:max_iter
        f_left = fun(x_left);
        f_right = fun(x_right);
        x_c = (x_left+x_right)/2;
        f_c = fun(x_c);
        % plot(x_c,f_c,".","MarkerSize",10, "Color",'r');
    
        if (sign(f_c) == sign(f_right))
            x_right = x_c;
        else 
            x_left = x_c;
        end

        if (abs(x_right)-abs(x_left)) <= dxtol
            fprintf('dxtol\n');
            x = x_c;
            flag = 1;
            return
        end
        
        if abs(fun(x_c))<ftol
            fprintf('ftol\n');
            x=x_c;
            flag = 1;
            return
        end

    hold on
    end
    x = x_c
    p = log((e-1)/e)/log(e/(e-1));
    flag = 0;
    fprintf('max_iter\n')
end