function I = fcnK5S(S, T, u, alpha, F, tol)
t1 = F .^ 2;t4 = sqrt(F .* T + t1 + u);t5 = 0.1e1 ./ t4;t6 = 0.1e1 ./ T;t7 = t6 .* u;t8 = T .^ 2;t11 = 0.1e1 ./ (-t8 + 0.4e1 .* u);t12 = sqrt(-u);t13 = F + t12;t14 = t13 .^ 2;t15 = 0.2e1 .* t12;t17 = t13 .* (T - t15);t18 = t12 .* T;t20 = sqrt(t14 + t17 - t18);t21 = 0.1e1 ./ t20;t22 = t21 .* t11;t23 = F .* t22;t26 = T .* u;t27 = 0.1e1 ./ t12;t28 = t11 .* t27;t31 = t27 .* u;t34 = sqrt(-t18);t35 = 0.1e1 ./ t34;t37 = 0.2e1 .* t18;t41 = 0.1e1 ./ t13;t43 = log(t41 .* (0.2e1 .* t20 .* t34 + t17 - t37));t46 = t12 .* u;t47 = t11 .* t6;t48 = F - t12;t49 = t48 .^ 2;t51 = t48 .* (T + t15);t53 = sqrt(t49 + t51 + t18);t54 = 0.1e1 ./ t53;t58 = t54 .* t11;t59 = F .* t58;t66 = sqrt(t18);t67 = 0.1e1 ./ t66;t72 = 0.1e1 ./ t48;t74 = log(t72 .* (0.2e1 .* t53 .* t66 + t37 + t51));t80 = t6 .* t12;t83 = 0.1e1 ./ t8;t84 = t83 .* u;t87 = t11 .* u;t94 = -t5 + 0.3e1 .* t23 .* t7 - t21 .* t28 .* t26 - 0.2e1 .* t23 .* t31 - t43 .* t35 .* t27 .* t7 - 0.3e1 ./ 0.2e1 .* t54 .* t47 .* t46 + 0.3e1 .* t59 .* t7 + t54 .* t28 .* t26 + 0.2e1 .* t59 .* t31 + t74 .* t67 .* t27 .* t7 + 0.3e1 ./ 0.2e1 .* t21 .* t47 .* t46 + 0.3e1 ./ 0.8e1 .* t21 .* t80 + 0.3e1 ./ 0.4e1 .* t21 .* t84 + 0.3e1 ./ 0.2e1 .* t54 .* t87 + 0.3e1 ./ 0.2e1 .* t21 .* t87 - 0.3e1 ./ 0.8e1 .* t54 .* t80;t99 = t11 .* t12;t103 = t74 .* t67;t125 = t43 .* t35;t133 = t83 .* t46;t138 = 0.3e1 ./ 0.4e1 .* t54 .* t84 + 0.3e1 ./ 0.8e1 .* t58 .* t18 + 0.3e1 ./ 0.4e1 .* F .* t54 .* t99 + 0.3e1 ./ 0.8e1 .* t103 .* t80 - 0.3e1 ./ 0.4e1 .* t103 .* t84 - t5 .* t11 .* T .* (0.2e1 .* F + T) - t54 .* t27 .* t7 + t21 .* t27 .* t7 + t21 .* t41 .* t7 ./ 0.4e1 - 0.3e1 ./ 0.8e1 .* t22 .* t18 - 0.3e1 ./ 0.4e1 .* F .* t21 .* t99 - 0.3e1 ./ 0.8e1 .* t125 .* t80 - 0.3e1 ./ 0.4e1 .* t125 .* t84 + t54 .* t72 .* t7 ./ 0.4e1 + 0.3e1 .* t23 .* t133 - 0.3e1 .* t59 .* t133;t139 = t94 + t138;
I = t139(:,:,2) - t139(:,:,1);

end
