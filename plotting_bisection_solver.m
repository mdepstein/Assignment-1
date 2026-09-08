function plotting_bisection_solver()
%Create an instance of the input_recorder
my_recorder = input_recorder();

%Use input_recorder to generate a version of the test function
%that records the input after every iteration
%Since test_fun is defined using function keyword
f_record = my_recorder.generate_recorder_fun(@test_function);

%initialize guesses for fzero
x_left = zeros(1000, 1);
x_right = zeros(1000, 1);

% x_root = zeros(size(x_left));


for i = 1:length(x_left)
    % Randomize guess
    x_left(i) = -3+6*rand();
    x_right(i) = -3+6*rand();

    % Run solver
    x_root(i) = bisection_solver1(f_record,x_left(i), x_right(i),10e-10,10e-10,1000);
    input_list = my_recorder.get_input_list();
    
    % Calculate error
    error = abs(input_list-x_root(i));
    error_list{i} = error;

    % Reset recorder
    my_recorder.clear_input_list();
end


%plot the inputs
figure;

for i = 1:length(error_list)
    error = error_list{i};
    loglog(error(1:end-1),error(2:end),'ko','markerfacecolor','k', 'MarkerSize', 2);
    hold on;
    xlabel('e_n')
    ylabel('e_{n+1}')
    title("Newton's Methods Raw Data")
end

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
% my_recorder.clear_input_list();
end

function [fval,dfdx] = test_function(x)
fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end