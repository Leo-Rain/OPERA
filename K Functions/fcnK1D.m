function I = fcnK1D(S, T, u, alpha, F, tol)
t1 = (F .* S);t3 = (S .^ 2);t4 = (t3 .^ 2);t5 = (F .^ 2);t6 = (t5 .^ 2);t15 = (T .^ 2);t21 = (t15 .^ 2);t31 = F .* T + S .* t5;t32 = sqrt(t31);t37 = 0.2e1 ./ 0.35e2 ./ t32 ./ t31 ./ t21 ./ T ./ t5 .* (64 .* T .* t5 .* F .* t3 .* S + 8 .* t15 .* T .* t1 - 16 .* t15 .* t5 .* t3 + 128 .* t6 .* t4 - 5 .* t21) .* (t1 + T);
I = t37(:,:,2) - t37(:,:,1);

end
