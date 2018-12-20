function I = fcnK6ip(S, t, u, alpha, F, tol)

F(abs(F(:,:,1)) < tol,:,1) = sign(F(abs(F(:,:,1)) < tol,:,1)).*tol;
F(abs(F(:,:,2)) < tol,:,2) = sign(F(abs(F(:,:,2)) < tol,:,2)).*tol;
t1 = sqrt(S);
t2 = t1 .* S;
t6 = F .* t;
t10 = log(0.2e1);
t13 = F .^ 2;
t16 = sqrt(t13 .* S + t6 + u);
t20 = log(0.2e1 .* S .* F + 0.2e1 .* t1 .* t16 + t);
t21 = log(S);
t24 = S .* u;
t25 = t .^ 2;
t40 = 0.8e1 ./ (0.8e1 .* t24 - 0.2e1 .* t25) ./ t16 ./ t2 .* (-u .* t2 .* F + (t6 + u) .* t1 .* t ./ 0.2e1 + t16 .* (t24 - t25 ./ 0.4e1) .* (-t10 + t20 - t21 ./ 0.2e1));

I = t40(:,:,2) - t40(:,:,1);

end
