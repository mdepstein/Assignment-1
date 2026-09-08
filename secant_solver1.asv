function x = secant_solver1(fun,x0, x1,max_iter,ftol,dxtol,dx_max)
    for i = 1:max_iter
        x2 = x1 - fun(x1) * (x1 - x0) / (fun(x1) - fun(x0));
        plot(x2,0,".","MarkerSize",10, "Color",'b');
        
        x0 = x1;
        x1 = x2;
        if(x1 == x0)
            x = x1;
            return
        end

        if abs(x1-x0) <= dxtol
            fprintf('dxtol');
            x = x1;
            return
        end

        if abs(fun(x0))<ftol
            fprintf('ftol');
            x=x1;
            return
        end

        if abs(fun(x1) - fun(x0)) > dx_max
            fprintf('dx_max');
            x = x1;
            return
        end  
    end
    x = x1;
end