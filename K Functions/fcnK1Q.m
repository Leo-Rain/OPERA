function I = fcnK1Q(S, T, u, alpha, F, tol)
t1 = S .* u;t2 = sqrt(-u);t3 = t2 .* T;t4 = -t1 - t3 + u;t5 = t4 .^ 2;t6 = 0.1e1 ./ t5;t7 = F + t2;t8 = t7 .^ 2;t11 = 0.2e1 .* t2 .* S;t13 = (T - t11) .* t7;t15 = sqrt(t8 .* S - t1 + t13 - t3 + u);t16 = 0.1e1 ./ t15;t17 = t16 .* t6;t20 = sqrt(t4);t23 = 0.2e1 .* t1;t24 = 0.2e1 .* t3;t25 = 0.2e1 .* u;t29 = 0.1e1 ./ t7;t31 = log(t29 .* (0.2e1 .* t15 .* t20 + t13 - t23 - t24 + t25));t32 = t31 ./ t20 ./ t5;t35 = -t1 + t3 + u;t36 = t35 .^ 2;t37 = 0.1e1 ./ t36;t38 = F - t2;t39 = t38 .^ 2;t42 = t38 .* (T + t11);t44 = sqrt(t39 .* S - t1 + t3 + t42 + u);t45 = 0.1e1 ./ t44;t46 = t45 .* t37;t49 = sqrt(t35);t55 = 0.1e1 ./ t38;t57 = log(t55 .* (0.2e1 .* t44 .* t49 - t23 + t24 + t25 + t42));t58 = t57 ./ t49 ./ t36;t62 = t2 ./ u;t63 = 0.1e1 ./ t35;t72 = T .^ 2;t74 = 0.1e1 ./ (0.4e1 .* t1 - t72);t75 = t74 .* t37;t76 = S .* t45;t83 = 0.1e1 ./ t4;t91 = t74 .* t6;t92 = S .* t16;t99 = S .^ 2;t100 = t99 .* t62;t101 = t74 .* t63;t106 = -0.3e1 ./ 0.4e1 .* S .* t17 + 0.3e1 ./ 0.4e1 .* S .* t32 - 0.3e1 ./ 0.4e1 .* S .* t46 + 0.3e1 ./ 0.4e1 .* S .* t58 + t45 .* t55 .* t63 .* t62 ./ 0.4e1 + 0.3e1 ./ 0.8e1 .* T .* t46 .* t62 + 0.3e1 ./ 0.2e1 .* t72 .* t76 .* t75 - 0.3e1 ./ 0.8e1 .* T .* t58 .* t62 - t16 .* t29 .* t83 .* t62 ./ 0.4e1 - 0.3e1 ./ 0.8e1 .* T .* t17 .* t62 + 0.3e1 ./ 0.2e1 .* t72 .* t92 .* t91 + 0.3e1 ./ 0.8e1 .* T .* t32 .* t62 + 0.2e1 .* F .* t45 .* t101 .* t100;t107 = S .* t62;t111 = t74 .* t83;t121 = t72 .* T;t126 = t74 .* t6 .* t2;t127 = t99 .* S;t134 = T .* F .* t99;t147 = t74 .* t37 .* t2;t160 = F .* t72;t168 = T .* t45 .* t101 .* t107 - T .* t16 .* t111 .* t107 - 0.2e1 .* F .* t16 .* t111 .* t100 - 0.3e1 ./ 0.8e1 .* t121 .* t45 .* t74 .* t37 .* t62 - 0.3e1 .* F .* t127 .* t16 .* t126 + 0.3e1 .* t134 .* t16 .* t91 - 0.3e1 ./ 0.2e1 .* T .* t99 .* t16 .* t126 + 0.3e1 ./ 0.8e1 .* t121 .* t16 .* t74 .* t6 .* t62 + 0.3e1 .* F .* t127 .* t45 .* t147 + 0.3e1 .* t134 .* t45 .* t75 + 0.3e1 ./ 0.2e1 .* T .* t99 .* t45 .* t147 - 0.3e1 ./ 0.4e1 .* t160 .* t76 .* t75 .* t62 + 0.3e1 ./ 0.4e1 .* t160 .* t92 .* t91 .* t62;t169 = t106 + t168;
I = t169(:,:,2) - t169(:,:,1);

end
