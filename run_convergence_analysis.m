function run_convergence_analysis()
    guess_list1 = [-5:0.01:0];
    guess_list2 = [0:0.01:5];
    filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
    x_guess0 = 2;
    solver_flag = 1;
    convergence_analysis(solver_flag, @test_function, x_guess0, guess_list1, guess_list2, filter_list);
end


function [fval,dfdx] = test_function(x)
    fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end