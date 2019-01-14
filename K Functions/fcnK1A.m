function I = fcnK1A(S, T, u, alpha, F, tol)
t2 = sqrt(-alpha);t3 = t2 ./ alpha;t4 = S .* alpha;t5 = t2 .* T;t6 = -t4 + t5 + u;t7 = t6 .^ 2;t8 = 0.1e1 ./ t7;t11 = T .^ 2;t13 = 0.1e1 ./ (0.4e1 .* S .* u - t11);t14 = t13 .* t8;t16 = F - t2;t17 = t16 .^ 2;t20 = 0.2e1 .* t2 .* S;t22 = t16 .* (T + t20);t24 = sqrt(t17 .* S + t22 - t4 + t5 + u);t25 = 0.1e1 ./ t24;t26 = S .* t25;t27 = F .* t11;t31 = -t4 - t5 + u;t32 = t31 .^ 2;t33 = 0.1e1 ./ t32;t34 = t13 .* t33;t36 = F + t2;t37 = t36 .^ 2;t40 = t36 .* (T - t20);t42 = sqrt(t37 .* S - t4 + t40 - t5 + u);t43 = 0.1e1 ./ t42;t44 = S .* t43;t48 = S .^ 2;t49 = t48 .* t3;t50 = 0.1e1 ./ t31;t51 = t13 .* t50;t56 = t3 .* S;t60 = 0.1e1 ./ t6;t61 = t13 .* t60;t69 = sqrt(t31);t72 = 0.2e1 .* t4;t73 = 0.2e1 .* t5;t74 = 0.2e1 .* u;t78 = 0.1e1 ./ t36;t80 = log(t78 .* (0.2e1 .* t42 .* t69 + t40 - t72 - t73 + t74));t81 = t80 ./ t69 ./ t32;t84 = t25 .* t8;t87 = sqrt(t6);t93 = 0.1e1 ./ t16;t95 = log(t93 .* (0.2e1 .* t24 .* t87 + t22 - t72 + t73 + t74));t96 = t95 ./ t87 ./ t7;t99 = t43 .* t33;t112 = -0.3e1 ./ 0.4e1 .* t27 .* t26 .* t14 .* t3 + 0.3e1 ./ 0.4e1 .* t27 .* t44 .* t34 .* t3 - 0.2e1 .* F .* t43 .* t51 .* t49 - T .* t43 .* t51 .* t56 + 0.2e1 .* F .* t25 .* t61 .* t49 + T .* t25 .* t61 .* t56 + 0.3e1 ./ 0.4e1 .* S .* t81 - 0.3e1 ./ 0.4e1 .* S .* t84 + 0.3e1 ./ 0.4e1 .* S .* t96 - 0.3e1 ./ 0.4e1 .* S .* t99 + 0.3e1 ./ 0.2e1 .* t11 .* t26 .* t14 - 0.3e1 ./ 0.8e1 .* T .* t96 .* t3 - t43 .* t78 .* t50 .* t3 ./ 0.4e1;t130 = t13 .* t33 .* t2;t131 = t48 .* S;t138 = T .* F .* t48;t147 = t11 .* T;t152 = t13 .* t8 .* t2;t169 = -0.3e1 ./ 0.8e1 .* T .* t99 .* t3 + 0.3e1 ./ 0.2e1 .* t11 .* t44 .* t34 + 0.3e1 ./ 0.8e1 .* T .* t81 .* t3 + t25 .* t93 .* t60 .* t3 ./ 0.4e1 + 0.3e1 ./ 0.8e1 .* T .* t84 .* t3 - 0.3e1 .* F .* t131 .* t43 .* t130 + 0.3e1 .* t138 .* t43 .* t34 - 0.3e1 ./ 0.2e1 .* T .* t48 .* t43 .* t130 + 0.3e1 ./ 0.8e1 .* t147 .* t43 .* t13 .* t33 .* t3 + 0.3e1 .* F .* t131 .* t25 .* t152 + 0.3e1 .* t138 .* t25 .* t14 + 0.3e1 ./ 0.2e1 .* T .* t48 .* t25 .* t152 - 0.3e1 ./ 0.8e1 .* t147 .* t25 .* t13 .* t8 .* t3;t170 = t112 + t169;
I = t170(:,:,2) - t170(:,:,1);

end
