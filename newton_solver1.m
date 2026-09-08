function x = newton_solver1(fun,x0,max_iter,ftol,dxtol,dx_max)
    for i = 1:max_iter
        [f,dfdx] = fun(x0);
        
        if abs(fun(x0)) < ftol
            fprintf('ftol\n');
            x = x0;
            return
        end

        dx = -f/dfdx;
        if abs(dx) > dx_max
            dx = sign(dx)*dx_max;
            fprintf('dx_max\n');
            %     x = x1;
            % return
        end
        
        if abs(dx) > dx_max
            dx = sign(dx)*dx_max;
        end

        x1=x0+dx;

        if abs(dx) <= dxtol
            fprintf('dxtol\n');
            x = x1;
            return
        end

        x0 = x1;
        hold on
    end
    x = x0
    fprintf('max_iter\n')
end