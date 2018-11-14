function J_B2 = fcnJ_B2(x_m, y_m, z_m, xi_1, xi_3, E, D_TE)

t1 = (E .^ 2);
t3 = sqrt((t1 + 1));
t6 = (E .* x_m + D_TE - y_m);
t8 = abs(z_m);
t9 = t8 .* E;
t17 = ((x_m + z_m) .* E + D_TE - y_m) .* ((x_m - z_m) .* E + D_TE - y_m);
t19 = sqrt(2.*i .* t9 .* t6 + t17);
t20 = t19 .* t3;
t21 = x_m .* t8;
t22 = x_m .^ 2;
t23 = t22 ./ 0.2e1;
t24 = z_m .^ 2;
t25 = t24 ./ 0.2e1;
t26 = i .* t21 - t23 + t25;
t30 = sqrt(-2.*i .* t9 .* t6 + t17);
t31 = -i .* t30;
t32 = (xi_1 .^ 2);
t34 = -D_TE + y_m;
t40 = y_m .^ 2;
t42 = 2 .* D_TE .* y_m;
t43 = D_TE .^ 2;
t45 = sqrt((-2 .* E .* t34 .* xi_1 + t32 .* t1 - 2 .* x_m .* xi_1 + t22 + t24 + t32 + t40 - t42 + t43));
t47 = t1 .* xi_1;
t48 = E .* t34;
t51 = -i .* x_m;
t52 = t47 .* t51;
t55 = E .* (x_m + xi_1) .* t34;
t56 = -i .* t43;
t58 = 2.*i .* D_TE .* y_m;
t59 = -i .* t40;
t60 = -i .* t24;
t62 = -i .* xi_1;
t66 = log(0.1e1 ./ (t8 + i .* x_m + t62) .* (t45 .* t31 + (t8 .* (-t47 + t48 - xi_1 + x_m)) + t52 + i .* t55 + t56 + t58 + t59 + t60));
t69 = (xi_3 .^ 2);
t77 = sqrt((-2 .* E .* t34 .* xi_3 + t69 .* t1 - 2 .* x_m .* xi_3 + t22 + t24 + t40 - t42 + t43 + t69));
t79 = t1 .* xi_3;
t82 = t79 .* t51;
t85 = E .* (x_m + xi_3) .* t34;
t87 = -i .* xi_3;
t91 = log(0.1e1 ./ (t8 + i .* x_m + t87) .* (t77 .* t31 + (t8 .* (-t79 + t48 - xi_3 + x_m)) + t82 + i .* t85 + t56 + t58 + t59 + t60));
t96 = -E .* t34;
t98 = log(t3 .* t45 + t47 + t96 - x_m + xi_1);
t101 = log(t3 .* t77 + t79 + t96 - x_m + xi_3);
t107 = -i .* t19;
t112 = -i .* (t43 - t42 + t40 + t24);
t117 = log(0.1e1 ./ (i .* x_m + t62 - t8) .* (t45 .* t107 + (t8 .* (t47 + t96 + xi_1 - x_m)) + t52 + i .* t55 + t112));
t125 = log(0.1e1 ./ (i .* x_m + t87 - t8) .* (t77 .* t107 + (t8 .* (t79 + t96 + xi_3 - x_m)) + t82 + i .* t85 + t112));
J_B2 = i ./ t8 ./ t30 ./ t19 .* (-t66 .* t26 .* t20 + t91 .* t26 .* t20 + (i .* t19 .* (t98 - t101) .* t8 - (t117 - t125) .* (i .* t21 + t23 - t25) .* t3) .* t30) ./ t3;

end
