
% set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/6;
[x_range, y_range] = compute_bounding_box(x0,y0,theta,egg_params)
figure();
hold on
plot_egg(x0,y0,theta,egg_params);
x_plot_list = [x_range(1), x_range(1), x_range(2), x_range(2), x_range(1)];
y_plot_list = [y_range(1), y_range(2), y_range(2), y_range(1), y_range(1)];
plot(x_plot_list, y_plot_list, 'MarkerFaceColor','r','MarkerSize',3)
title('Egg with Boundary Box');
xlabel('x-axis');
ylabel('y-axis');
legend('Egg', 'Boundary Box');

axis equal
