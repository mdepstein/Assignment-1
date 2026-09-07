function x = bisection_solver1(fun,x_left,x_right,dxtol,ftol,max_iter)
    for i = 1:max_iter
        f_left = fun(x_left);
        f_right = fun(x_right);
        x_c = (x_left+x_right)/2;
        f_c = fun(x_c);
        plot(x_c,f_c,".","MarkerSize",10, "Color",'r');
    
        if (sign(f_c) == sign(f_right))
            x_right = x_c;
        else 
            x_left = x_c;
        end

        if (x_right-x_left) <= dxtol
            fprintf('dxtol');
            x = 'N/A';
            return
        end
        
        if abs(f(x_c))<ftol
            fprintf('ftol');
            x='N/A';
            return
        end

    hold on
    end
    x = x_c;
    p = log((e-1)/e)/log(e/(e-1));
end