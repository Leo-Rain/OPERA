function I = fcnK0G(S, T, u, alpha, F, tol)
t1 = log(F);t2 = F .^ 2;t3 = t2 .^ 2;t6 = t2 + alpha;t7 = log(t6);t18 = alpha .^ 2;t21 = t2 .* S;t22 = sqrt(t21);t32 = -0.1e1 ./ t6 ./ t18 ./ alpha ./ t22 ./ t21 .* (0.4e1 .* alpha .* t2 .* t1 - 0.2e1 .* alpha .* t2 .* t7 + 0.2e1 .* alpha .* t2 + 0.4e1 .* t3 .* t1 - 0.2e1 .* t3 .* t7 + t18) .* F ./ 0.2e1;
I = t32(:,:,2) - t32(:,:,1);

end
