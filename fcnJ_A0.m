function J_A0 = fcnJ_A0(x_m, y_m, z_m, xi_1, xi_3, C, D_LE)
t2 = (C .* x_m + D_LE - y_m);
t4 = abs(z_m);
t5 = t4 .* C;
t13 = ((x_m + z_m) .* C - y_m + D_LE) .* ((x_m - z_m) .* C - y_m + D_LE);
t15 = sqrt(2.*i .* t5 .* t2 + t13);
t16 = -i .* t15;
t17 = C .^ 2;
t18 = (xi_1 .^ 2);
t20 = y_m - D_LE;
t24 = x_m .^ 2;
t27 = y_m .^ 2;
t29 = 2 .* D_LE .* y_m;
t30 = z_m .^ 2;
t31 = D_LE .^ 2;
t33 = sqrt((-2 .* C .* t20 .* xi_1 + t18 .* t17 - 2 .* x_m .* xi_1 + t18 + t24 + t27 - t29 + t30 + t31));
t35 = t17 .* xi_1;
t37 = -C .* t20;
t41 = -i .* t35 .* x_m;
t44 = C .* (x_m + xi_1) .* t20;
t45 = -i .* t27;
t47 = 2.*i .* D_LE .* y_m;
t48 = -i .* t30;
t49 = -i .* t31;
t51 = -i .* xi_1;
t55 = log(0.1e1 ./ (i .* x_m + t51 - t4) .* (t33 .* t16 + (t4 .* (t35 + t37 - x_m + xi_1)) + t41 + i .* t44 + t45 + t47 + t48 + t49));
t56 = (xi_3 .^ 2);
t64 = sqrt((-2 .* C .* t20 .* xi_3 + t56 .* t17 - 2 .* x_m .* xi_3 + t24 + t27 - t29 + t30 + t31 + t56));
t66 = t17 .* xi_3;
t69 = -i .* xi_3;
t71 = t17 .* x_m .* t69;
t74 = C .* (x_m + xi_3) .* t20;
t79 = log(0.1e1 ./ (i .* x_m + t69 - t4) .* (t64 .* t16 + (t4 .* (t66 + t37 - x_m + xi_3)) + t71 + i .* t74 + t45 + t47 + t48 + t49));
t84 = sqrt(-2.*i .* t5 .* t2 + t13);
t86 = -i .* t84;
t88 = C .* t20;
t95 = log(0.1e1 ./ (t4 + i .* x_m + t51) .* (t33 .* t86 + (t4 .* (-t35 + t88 + x_m - xi_1)) + t41 + i .* t44 + t45 + t47 + t48 + t49));
t103 = log(0.1e1 ./ (t4 + i .* x_m + t69) .* (t64 .* t86 + (t4 .* (-t66 + t88 + x_m - xi_3)) + t71 + i .* t74 + t45 + t47 + t48 + t49));
J_A0 = -0.1e1 ./ 0.2e1.*i ./ t4 ./ t15 ./ t84 .* (t84 .* (t55 - t79) - (t95 - t103) .* t15);
end
