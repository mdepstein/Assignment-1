function plotting_bisection_solver()
%Create an instance of the input_recorder
my_recorder = input_recorder();

%Use input_recorder to generate a version of the test function
%that records the input after every iteration
%Since test_fun is defined using function keyword
f_record = my_recorder.generate_recorder_fun(@test_function);

%initialize guesses for fzero
x_left = zeros(200, 1);
x_right = zeros(200, 1);

% x_root = zeros(size(x_left));


for i = 1:length(x_left)
    % Randomize guess
    x_left(i) = -3*rand();
    x_right(i) = 3*rand();

    % Run solver
    x_root = bisection_solver1(f_record,x_left(i), x_right(i),1e-12,1e-12,1000);
    input_list = my_recorder.get_input_list();
    
    % Calculate error
    error = abs(x_root-x_root(end));
    error_list{i} = error;

    % Reset recorder
    my_recorder.clear_input_list();
end


%plot the inputs
figure;
error_list0 = [];
error_list1 = [];
for i = 1:length(error_list)
    error = error_list{i};
    length(error)
    if(length(error)>3)
    error_list0 = [error_list0, error(1:end-1)];
    error_list1 = [error_list1, error(2:end)];
    h(1) = loglog(error(1:end-1),error(2:end),'ko','markerfacecolor','r', 'MarkerSize', 2, 'Color','r');
    hold on;
    xlabel('e_n')
    ylabel('e_{n+1}')
    title("Bisection's Convergence Rate Plot")
    end
end

x_regression = [];
y_regression = [];
filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
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
fit_line_x = 10.^[-12:.1:1];
%compute the corresponding y values
fit_line_y = k*fit_line_x.^p;
%plot on a loglog plot.
h(3) = loglog(fit_line_x,fit_line_y,'k-','linewidth',2,'Color','black');
l = legend(h,"Raw Data", "Filtered Data", "Fit Line");
set(l,'location','northwest');
fontsize(l, 14, "points"); % Sets the legend font size to 14 points
end

function [fval,dfdx] = test_function(x)
fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
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