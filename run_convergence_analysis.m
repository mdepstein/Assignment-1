function run_convergence_analysis()
    %guess_list1 = [0:0.1:50];
    %guess_list2 = [0:0.01:5];
    x = linspace(0,50,50);
    y = linspace(0,50,50);   
    filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
    x_guess0 = 2;
    solver_flag = 4;
    if(solver_flag == 2||solver_flag == 4)
        x = linspace(0,50,300);

        y = 1
    end
    convergence_analysis(solver_flag, @test_function, x_guess0, x, y, filter_list);
end
%Example sigmoid function
function [f_val,dfdx] = test_function(x)
a = 27.3; b = 2; c = 8.3; d = -3;
H = exp((x-a)/b);
dH = H/b;
L = 1+H;
dL = dH;
f_val = c*H./L+d;
dfdx = c*(L.*dH-H.*dL)./(L.^2);
end
% 
% function [fval,dfdx] = test_function(x)
%     fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
%     dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
% end