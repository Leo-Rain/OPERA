function I = fcnK5K(S, T, u, alpha, F, tol)
t1 = F .^ 2;t4 = sqrt(F .* T + t1);t5 = 0.1e1 ./ t4;t6 = sqrt(-alpha);t7 = T - t6;t8 = t7 .^ 2;t9 = 0.1e1 ./ t8;t10 = t9 .* alpha;t11 = F + t6;t12 = t11 .^ 2;t13 = 0.2e1 .* t6;t15 = t11 .* (T - t13);t16 = t7 .* t6;t18 = sqrt(t12 + t15 - t16);t19 = 0.1e1 ./ t18;t22 = T + t6;t23 = t22 .^ 2;t24 = 0.1e1 ./ t23;t25 = t24 .* alpha;t26 = F - t6;t27 = t26 .^ 2;t29 = t26 .* (T + t13);t30 = t6 .* t22;t32 = sqrt(t27 + t29 + t30);t33 = 0.1e1 ./ t32;t36 = 0.1e1 ./ T;t42 = 0.1e1 ./ t6 .* alpha;t43 = 0.1e1 ./ t7;t44 = sqrt(-t16);t45 = 0.1e1 ./ t44;t51 = 0.1e1 ./ t11;t53 = log(t51 .* (0.2e1 .* t18 .* t44 + t15 - 0.2e1 .* t16));t56 = t6 .* alpha;t61 = t19 .* t36;t62 = F .* t61;t65 = t9 .* t6;t74 = 0.1e1 ./ t22;t75 = t74 .* alpha;t76 = T .^ 2;t77 = 0.1e1 ./ t76;t79 = F .* t33 .* t77;t82 = sqrt(t30);t83 = 0.1e1 ./ t82;t89 = 0.1e1 ./ t26;t91 = log(t89 .* (0.2e1 .* t32 .* t82 + t29 + 0.2e1 .* t30));t94 = t43 .* alpha;t96 = F .* t19 .* t77;t99 = t33 .* t36;t100 = F .* t99;t103 = t24 .* t6;t111 = -t5 + 0.9e1 ./ 0.4e1 .* t19 .* t10 + 0.9e1 ./ 0.4e1 .* t33 .* t25 + t5 .* (0.2e1 .* F + T) .* t36 - t45 .* t43 .* t53 .* t42 + 0.3e1 ./ 0.2e1 .* t33 .* t36 .* t24 .* t56 + 0.3e1 .* t62 .* t10 - 0.3e1 ./ 0.8e1 .* t53 .* t45 .* T .* t65 - 0.3e1 ./ 0.2e1 .* t19 .* t36 .* t9 .* t56 - 0.6e1 .* t79 .* t75 + t91 .* t83 .* t74 .* t42 - 0.6e1 .* t96 .* t94 + 0.3e1 .* t100 .* t25 + 0.3e1 ./ 0.8e1 .* t91 .* t83 .* T .* t103 - 0.2e1 .* t100 .* t74 .* t42;t155 = 0.2e1 .* t62 .* t43 .* t42 + 0.3e1 .* t79 .* t24 .* t56 - 0.3e1 .* t96 .* t9 .* t56 + t19 .* t51 .* t94 ./ 0.4e1 + 0.3e1 ./ 0.4e1 .* t19 .* T .* t65 + 0.3e1 ./ 0.4e1 .* F .* t19 .* t65 - 0.3e1 ./ 0.4e1 .* t53 .* t45 .* t10 + 0.2e1 .* t19 .* t43 .* t42 - 0.3e1 .* t61 .* t94 + t33 .* t89 .* t75 ./ 0.4e1 - 0.3e1 ./ 0.4e1 .* t33 .* T .* t103 - 0.3e1 ./ 0.4e1 .* F .* t33 .* t103 - 0.3e1 ./ 0.4e1 .* t91 .* t83 .* t25 - 0.2e1 .* t33 .* t74 .* t42 - 0.3e1 .* t99 .* t75;t156 = t111 + t155;
I = t156(:,:,2) - t156(:,:,1);

end
