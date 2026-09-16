egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
y_ground = 25; x_wall = 25;
t_list = linspace(0, 10, 100);
collision_func(egg_trajectory01(t_list), egg_params, y_ground, x_wall);