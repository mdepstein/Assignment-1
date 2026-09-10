%Example template for analysis function
%INPUTS:
%solver_flag: an integer from 1-4 indicating which solver to use
%
% 1->Bisection 2-> Newton 3->Secant 4->fzero
%fun: the mathematical function that we are using the
%
% solver to compute the root of
%x_guess0: the initial guess used to compute x_root
%guess_list1: a list of initial guesses for each trial
%guess_list2: a second list of initial guesses for each trial
%
% if guess_list2 is not needed, then set to zero in input
    %filter_list: a list of constants used to filter the collected data
function convergence_analysis(solver_flag, fun, x_guess0, guess_list1, guess_list2, filter_list)

%Create an instance of the input_recorder
my_recorder = input_recorder();

%Use input_recorder to generate a version of the test function
%that records the input after every iteration
%Since test_fun is defined using function keyword
f_record = my_recorder.generate_recorder_fun(fun);

% Exit parameters
dxtol = 1e-12;
ftol = 1e-12;
max_iter = 1000;
dx_max = 1e10;

%initialize guesses for fzero
x_root = [];
error_list = [];
flag = [];

    for i = 1:length(x_guess0)
        % Randomize guess
        % Run solver

        if solver_flag == 1
            [x_root(i), flag(i)]  = bisection_solver1(f_record, guess_list1, guess_list2, dxtol, ftol, max_iter);
            % x_root(i)  = bisection_solver1(fun, guess_list1(i), guess_list2(i), dxtol, ftol, max_iter);

        elseif solver_flag == 2
            [x_root(end+1), flag(end+1)] = newton_solver1(f_record, x_guess0, max_iter, ftol, dxtol, dx_max)

            % x_root(i) = newton_solver1(fun, x_guess0, max_iter, ftol, dxtol, dx_max);

        elseif solver_flag == 3
            [x_root(i), flag(i)] = secant_solver1(f_record, guess_list1, guess_list2, max_iter, ftol, dxtol, dx_max);
            % x_root(i) = secant_solver1(fun, guess_list1, guess_list2, max_iter, ftol, dx_tol, dx_max);

        elseif solver_flag == 4
            [x_root(i), flag(i)] = fzero(f_record, x_guess0);
            % x_root(i)= fzero(fun, x_guess0);
        else
            return
        end
        input_list = my_recorder.get_input_list()

        % Calculate error
        error = abs(input_list-x_root(i))
        error_list{i} = error;

        % Reset recorder
        my_recorder.clear_input_list();
    end
    
    % Predict k value (for Newton's method)
    x_r = x_root(1);
    h = 1e-4;
    dx = (f_record(x_r+h)-f_record(x_r))/(h);
    dx2 = (f_record(x_r+h)-2*f_record(x_r)-f_record(x_r-h))/(h^2);
    k_predicted = abs(0.5*dx2/dx)


    %plot the inputs
    figure;
    error_list0 = [];
    error_list1 = [];

    if solver_flag == 1
        solver_title = "Bisection Method";
    elseif solver_flag == 2
        solver_title = "Newton's Method";
    elseif solver_flag == 3
        solver_title = "Secant Method";
    elseif solver_flag == 4
        solver_title = "FZero";
    end

    for i = 1:length(error_list)
        error = error_list{i};
        error_list0 = [error_list0, error(1:end-1)];
        error_list1 = [error_list1, error(2:end)];
        h(1) = loglog(error(1:end-1),error(2:end),'ko','markerfacecolor','r', 'MarkerSize', 2, 'Color','r');
        hold on;
        xlabel('e_n')
        ylabel('e_{n+1}')
        title({solver_title}, " Convergence Rate Plot")
    end

    x_regression = [];
    y_regression = [];
    % filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
    index_list = 1:length(error_list0);
    %iterate through the collected data
    for n=1:length(index_list)
        %if the error is not too big or too small
        %and it was enough iterations into the trial...
        if error_list0(n)>filter_list(1) && error_list0(n)<filter_list(2) && ...
                error_list1(n)>filter_list(3) && error_list1(n)<filter_list(4) && ...
                index_list(n)>filter_list(5)
            %then add it to the set of points for regression
            x_regression(end+1) = error_list0(n);
            y_regression(end+1) = error_list1(n);
        end
    end

    h(2) = loglog(x_regression,y_regression,'ko','markerfacecolor','b', 'MarkerSize', 2, 'Color','b')

    %x_regression -> e_n
    %y_regression -> e_{n+1}
    [p,k] = generate_error_fit(x_regression,y_regression)

    %example for how to plot fit line
    %generate x data on a logarithmic range
    fit_line_x = 10.^[-5:.1:1];
    %compute the corresponding y values
    fit_line_y = k*fit_line_x.^p;
    %plot on a loglog plot.
    h(3) = loglog(fit_line_x,fit_line_y,'k-','linewidth',2,'Color','black');
    l = legend(h,"Raw Data", "Filtered Data", "Fit Line");
    set(l,'location','northwest');
    fontsize(l, 14, "points"); % Sets the legend font size to 14 points
end

    
    %example for how to compute the fit line
    %data points to be used in the regression
    %x_regression -> e_n
    %y_regression -> e_{n+1}
    %p and k are the output coefficients
function [p,k] = generate_error_fit(x_regression,y_regression)
    %generate Y, X1, and X2
    %note that I use the transpose operator (')
    %to convert the result from a row vector to a column
    %If you are copy-pasting, the ' character may not work correctly
    Y = log(y_regression)';
    X1 = log(x_regression)';
    X2 = ones(length(X1),1);
    %run the regression
    coeff_vec = regress(Y,[X1,X2]);
    %pull out the coefficients from the fit
    p = coeff_vec(1)
    k = exp(coeff_vec(2))
end

