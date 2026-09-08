function plotting_step_4()
%Create an instance of the input_recorder
my_recorder = input_recorder();
%Use input_recorder to generate a version of the test function
%that records the input after every iteration
%Since test_fun is defined using function keyword
f_record = my_recorder.generate_recorder_fun(@test_function);
%If test_fun is defined as an anonymous function:
%f_record = my_recorder.generate_recorder_fun(test_function);
%initialize guesses for fzero
x0 = linspace(-3, 3, 100);
%Call your root finder using the recording function:
for i = length(x0)
    x_root(i) = newton_solver1(f_record,x0(i),1000,10e-10,10e-10,100);

    %x_root = bisection_solver1(fun,x_left,x_right,dxtol,ftol,max_iter)
    %See what input values were used when f_record was called:
end
    % input_list(i) = my_recorder.get_input_list();
%at this point, input_list will be populated with the input arguments
%that fzero used to call test_function
%plot the inputs
error = abs(x0-x_root);
figure;
loglog(error(1:end-1),error(2:end),'ko','markerfacecolor','k');
xlabel('e_n')
ylabel('e_{n+1}')
title("Newton's Methos Raw Data")
hold on
% poly = polyfit(log10(error(1:end-1)),log10(error(2:end)),1);
% 4. Generate points for the regression line
% We evaluate the line across the range of our x data
% x_fit = logspace(log10(min(input_list)), log10(max(input_list)), 20);
% X_fit_log = log10(x_fit);

% Calculate fitted Y values in log space, then convert back to linear scale
% Y_fit_log = polyval(poly, X_fit_log);
% y_fit = 10.^Y_fit_log;

% loglog(x_fit, y_fit, 'b-', 'LineWidth', 2); 
%reset input_list for the next test
my_recorder.clear_input_list();
end

function [fval,dfdx] = test_function(x)
fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end