syms x
f = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);

dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
df2dx = diff(f,x,2)
df2dx = subs(df2dx,.7174)
dfdx = subs(dfdx, .7174)
k = double(.5*dfdx/df2dx)

