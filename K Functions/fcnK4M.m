function I = fcnK4M(S, T, u, alpha, F, tol)
t2 = 0.1e1 ./ u .* F;t3 = F .^ 2;t5 = sqrt(t3 + u);t8 = -alpha + u;t9 = 0.1e1 ./ t8;t10 = t9 .* alpha;t11 = sqrt(-alpha);t12 = F - t11;t13 = 0.1e1 ./ t12;t14 = t12 .^ 2;t15 = t12 .* t11;t18 = sqrt(t14 + 0.2e1 .* t15 - alpha + u);t19 = 0.1e1 ./ t18;t23 = t11 .* alpha;t24 = t8 .^ 2;t25 = 0.1e1 ./ t24;t29 = alpha .^ 2;t30 = t25 .* t29;t31 = t19 .* t2;t34 = sqrt(t8);t36 = 0.1e1 ./ t34 ./ t24;t40 = log(0.2e1 .* (t18 .* t34 - alpha + t15 + u) .* t13);t46 = F + t11;t47 = 0.1e1 ./ t46;t48 = t46 .^ 2;t49 = t46 .* t11;t52 = sqrt(t48 - 0.2e1 .* t49 - alpha + u);t53 = 0.1e1 ./ t52;t60 = t53 .* t2;t66 = log(0.2e1 .* t47 .* (t52 .* t34 - alpha - t49 + u));t73 = 0.1e1 ./ t11 .* alpha;t78 = 0.1e1 ./ t34 ./ t8;t88 = 0.1e1 ./ t5 .* t2 + t19 .* t13 .* t10 ./ 0.4e1 + 0.3e1 ./ 0.4e1 .* t19 .* t25 .* t23 + 0.3e1 ./ 0.4e1 .* t31 .* t30 - 0.3e1 ./ 0.4e1 .* t40 .* t36 .* t23 + 0.5e1 ./ 0.4e1 .* t31 .* t10 + t53 .* t47 .* t10 ./ 0.4e1 - 0.3e1 ./ 0.4e1 .* t53 .* t25 .* t23 + 0.3e1 ./ 0.4e1 .* t60 .* t30 + 0.3e1 ./ 0.4e1 .* t66 .* t36 .* t23 + 0.5e1 ./ 0.4e1 .* t60 .* t10 - 0.3e1 ./ 0.4e1 .* t9 .* t19 .* t73 + 0.3e1 ./ 0.4e1 .* t40 .* t78 .* t73 + 0.3e1 ./ 0.4e1 .* t53 .* t9 .* t73 - 0.3e1 ./ 0.4e1 .* t66 .* t78 .* t73;
I = t88(:,:,2) - t88(:,:,1);

end
