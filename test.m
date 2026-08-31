tlist = linspace(-5,5,100);
ylist = test_func01(tlist);
figure();
plot(tlist,ylist)
hold on
x1 = bisection_solver1(@test_func01,-5,5)
x2 = newton_solver1(@test_func01,-3)
x3 = secant_solver1(@test_func01,-5,5)

%Definition of the test function and its derivative (as a single function):
%This definition uses the function keyword
%when passing this function as an argument to a solver,
%you'll need to use the handle operator
%ex. solver(@test_func01,x_guess)
function [fval,dfdx] = test_func01(x)
fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end

function x = bisection_solver1(fun,x_left,x_right)
    for i = 1:100
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
    hold on
    end
    x = x_c;
 
 
end
%Note that fun(x) should output [f,dfdx], where dfdx is the derivative of f
function x = newton_solver1(fun,x0)
    for i = 1:10
    [f,dfdx] = fun(x0);
    x1 = x0 - f/dfdx;
    x0 = x1;
    plot(x1,0,".","MarkerSize",10, "Color",'c');
    end
    x = x1

end
function x = secant_solver1(fun,x0, x1)
for i = 1:10
    x2 = x1 - fun(x1) * (x1 - x0) / (fun(x1) - fun(x0));
    plot(x2,0,".","MarkerSize",10, "Color",'b');
    
    x0 = x1;
    x1 = x2;
    if(x1 == x0)
        x = x1;
        return
    end
end

end