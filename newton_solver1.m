function x = newton_solver1(fun,x0,max_iter,ftol,dxtol,dx_max)
    for i = 1:max_iter
        [f,dfdx] = fun(x0);
        x1 = x0 - f/dfdx;

        %plot(x1,0,".","MarkerSize",10, "Color",'c');

        if abs(x1-x0) <= dxtol
            fprintf('dxtol');
                x = x1

            return
        end

        if abs(fun(x0))<ftol
            fprintf('ftol');
                x = x1

            return
        end

        if abs(dfdx) > dx_max
            fprintf('dx_max');
                x = x1

            return
        end
        x0 = x1;
    end
    x = x1

end