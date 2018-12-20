function I = fcnK3ip(S, t, u, alpha, F, tol)

F(abs(F(:,:,1)) < tol,:,1) = sign(F(abs(F(:,:,1)) < tol,:,1)).*tol;
F(abs(F(:,:,2)) < tol,:,2) = sign(F(abs(F(:,:,2)) < tol,:,2)).*tol;
t1 = sqrt(u);
t2 = t1 .* u;
t10 = S .* u;
t11 = t .^ 2;
t15 = F .* t;
t16 = F .^ 2;
t19 = sqrt(t16 .* S + t15 + u);
t23 = log(0.2e1 .* t19 .* t1 + t15 + 0.2e1 .* u);
t24 = log(F);
t37 = -0.4e1 ./ (0.4e1 .* t10 - t11) ./ t19 .* (-t2 .* S + (S .* F + t) .* t1 .* t ./ 0.2e1 + t19 .* (t23 - t24) .* (t10 - t11 ./ 0.4e1)) ./ t2;

I = t37(:,:,2) - t37(:,:,1);

end
