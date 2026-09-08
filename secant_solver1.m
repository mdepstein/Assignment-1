function x = secant_solver1(fun,x0,x1,max_iter,ftol,dxtol,dx_max)
    for i = 1:max_iter
        f0 = fun(x0);
        f1 = fun(x1);
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
        % plot(x2,0,".","MarkerSize",10, "Color",'b');
        
        if abs(f1) <= ftol
            fprintf('ftol\n');
            x = x1;
            return
        end

        if abs(x2-x1) <= dxtol
            fprintf('dxtol\n');
            x = x2;
            return
        end

        if abs(f1 - f0) > dx_max
            fprintf('dx_max\n');
            x = x2;
            return
        end  

        x0=x1;
        x1=x2;
        
    end
    x = x1;
end