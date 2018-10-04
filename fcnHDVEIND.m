function [infl_glob] = fcnHDVEIND(dvenum, dvetype, fpg, matPLEX, matROTANG, matCENTER)
warning('on')
fpl = fcnGLOBSTAR(fpg - matCENTER(dvenum,:), matROTANG(dvenum,:));
len = size(fpl,1);

%%
xi_1 = permute(matPLEX(1,1,dvenum),[3 2 1]);
xi_2 = permute(matPLEX(2,1,dvenum),[3 2 1]);
xi_3 = permute(matPLEX(3,1,dvenum),[3 2 1]);

eta_1 = permute(matPLEX(1,2,dvenum),[3 2 1]);
eta_2 = permute(matPLEX(2,2,dvenum),[3 2 1]);
eta_3 = permute(matPLEX(3,2,dvenum),[3 2 1]);

% Checking which elements are on the element, moving them off by a small
% amount
le_eta = eta_2 + (fpl(:,1) - xi_2).*((eta_3 - eta_2)./(xi_3 - xi_2));
te_eta = eta_1 + (fpl(:,1) - xi_1).*((eta_3 - eta_1)./(xi_3 - xi_1));

% tester = abs(fpl(:,3)) < 1e-3;
% fpl(tester,3) = 1e-5
margin_edge = 1e-10;
margin_on_element = 1e-10;
idx_on_element = fpl(:,2) >= te_eta - margin_edge & fpl(:,2) <= le_eta + margin_edge & fpl(:,1) >= xi_1 - margin_edge & fpl(:,1) <= xi_3 + margin_edge & abs(fpl(:,3)) <= margin_on_element;

% margin_above_below_element = 1e-3;
% idx_above_below_element = fpl(:,2) >= te_eta - margin_edge & fpl(:,2) <= le_eta + margin_edge & fpl(:,1) >= xi_1 - margin_edge & fpl(:,1) <= xi_3 + margin_edge & abs(fpl(:,3)) > margin_on_element & abs(fpl(:,3)) <= margin_above_below_element;
idx_on_edge = idx_on_element & ((xi_1 - margin_edge <= fpl(:,1) & fpl(:,1) <= xi_1 + margin_edge) | (le_eta - margin_edge <= fpl(:,2) & fpl(:,2) <= le_eta + margin_edge) | (te_eta - margin_edge <= fpl(:,2) & fpl(:,2) <= te_eta + margin_edge));

% fpl(idx_on_element,3) = fpl(idx_on_element,3).*0 + 1e-4;
% fpl(idx_on_edge,:) = fpl(idx_on_edge,:) - margin.*fpl(idx_on_edge,:);
% fpl(idx_on_edge,3) = fpl(idx_on_edge,3) + margin;

xi_p = fpl(:,1);
eta_p = fpl(:,2);
zeta_p = fpl(:,3);

%%
x_m = xi_p;
y_m = eta_p;
z_m = zeta_p;
C = (eta_3 - eta_2)./(xi_3 - xi_2);
D_LE = eta_2 - ((xi_2.*(eta_3 - eta_2))./(xi_3 - xi_2));
E = (eta_3 - eta_1)./(xi_3 - xi_1);
D_TE = eta_1 - ((xi_1.*(eta_3 - eta_1))./(xi_3 - xi_1));
tic
J_1 = 0.1e1 ./ 0.2e1.*i .* (2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .^ (-0.1e1 ./ 0.2e1) .* (-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .^ (-0.1e1 ./ 0.2e1) .* (-(i .* E .* abs(z_m) - x_m .* E - D_TE + y_m) .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* log((-i .* sqrt(-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt(xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + (-E .^ 2 .* xi_1 + (-D_TE + y_m) .* E + x_m - xi_1) .* abs(z_m) + -i .* x_m .* xi_1 .* E .^ 2 + -i .* (x_m + xi_1) .* (D_TE - y_m) .* E + -i .* D_TE .^ 2 + 2.*i .* D_TE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_1)) + (i .* E .* abs(z_m) - x_m .* E - D_TE + y_m) .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* log((-i .* sqrt(-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt(E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) + (-E .^ 2 .* xi_3 + (-D_TE + y_m) .* E - xi_3 + x_m) .* abs(z_m) + -i .* x_m .* xi_3 .* E .^ 2 + -i .* (x_m + xi_3) .* (D_TE - y_m) .* E + -i .* D_TE .^ 2 + 2.*i .* D_TE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_3)) + (((log((-i .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(xi_1 .^ 2 .* C .^ 2 + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + (-C .^ 2 .* xi_1 + (-D_LE + y_m) .* C + x_m - xi_1) .* abs(z_m) + -i .* xi_1 .* x_m .* C .^ 2 + -i .* (x_m + xi_1) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_1)) - log((-i .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(C .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) + (-C .^ 2 .* xi_3 + (-D_LE + y_m) .* C - xi_3 + x_m) .* abs(z_m) + -i .* x_m .* xi_3 .* C .^ 2 + -i .* (x_m + xi_3) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_3))) .* (i .* C .* abs(z_m) - C .* x_m - D_LE + y_m) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) + (i .* C .* abs(z_m) + C .* x_m + D_LE - y_m) .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* (log((-i .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(xi_1 .^ 2 .* C .^ 2 + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + (C .^ 2 .* xi_1 + (D_LE - y_m) .* C - x_m + xi_1) .* abs(z_m) + -i .* xi_1 .* x_m .* C .^ 2 + -i .* (x_m + xi_1) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (i .* x_m + -i .* xi_1 - abs(z_m))) - log((-i .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(C .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) + (C .^ 2 .* xi_3 + (D_LE - y_m) .* C - x_m + xi_3) .* abs(z_m) + -i .* x_m .* xi_3 .* C .^ 2 + -i .* (x_m + xi_3) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (i .* x_m + -i .* xi_3 - abs(z_m))))) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) + sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* (log((-2.*i .* sqrt(E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) + (2 .* E .^ 2 .* xi_3 + (2 .* D_TE - 2 .* y_m) .* E + 2 .* xi_3 - 2 .* x_m) .* abs(z_m) + -2.*i .* x_m .* xi_3 .* E .^ 2 + -2.*i .* (x_m + xi_3) .* (D_TE - y_m) .* E + -2.*i .* (D_TE .^ 2 - 2 .* D_TE .* y_m + y_m .^ 2 + (z_m .^ 2))) ./ (i .* x_m + -i .* xi_3 - abs(z_m))) - log((-i .* sqrt(xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) + (E .^ 2 .* xi_1 + (D_TE - y_m) .* E - x_m + xi_1) .* abs(z_m) + -i .* x_m .* xi_1 .* E .^ 2 + -i .* (x_m + xi_1) .* (D_TE - y_m) .* E + -i .* (D_TE .^ 2 - 2 .* D_TE .* y_m + y_m .^ 2 + (z_m .^ 2))) ./ (i .* x_m + -i .* xi_1 - abs(z_m))) - log(0.2e1)) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* (i .* E .* abs(z_m) + x_m .* E + D_TE - y_m)) .* sqrt(-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m))) .* (-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .^ (-0.1e1 ./ 0.2e1) .* (2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .^ (-0.1e1 ./ 0.2e1) ./ abs(z_m);
J_2 = -i .* (2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .^ (-0.1e1 ./ 0.2e1) .* ((C .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) .* (2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .^ (-0.1e1 ./ 0.2e1) .* (E .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1) .* (-2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .^ (-0.1e1 ./ 0.2e1) .* (-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .^ (-0.1e1 ./ 0.2e1) .* (sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt((C .^ 2 + 1)) .* sqrt(2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(E .^ 2 + 1) .* ((i .* x_m .* E + 0.1e1 ./ 0.2e1.*i .* D_TE + -0.1e1 ./ 0.2e1.*i .* y_m) .* abs(z_m) - E .* x_m .^ 2 ./ 2 + (-D_TE ./ 2 + y_m ./ 2) .* x_m + E .* (z_m .^ 2) ./ 2) .* log((-i .* sqrt(-2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt(xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + (-E .^ 2 .* xi_1 + (-D_TE + y_m) .* E + x_m - xi_1) .* abs(z_m) + -i .* x_m .* xi_1 .* E .^ 2 + -i .* (x_m + xi_1) .* (D_TE - y_m) .* E + -i .* D_TE .^ 2 + 2.*i .* D_TE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_1)) - sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt((C .^ 2 + 1)) .* sqrt(2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(E .^ 2 + 1) .* ((i .* x_m .* E + 0.1e1 ./ 0.2e1.*i .* D_TE + -0.1e1 ./ 0.2e1.*i .* y_m) .* abs(z_m) - E .* x_m .^ 2 ./ 2 + (-D_TE ./ 2 + y_m ./ 2) .* x_m + E .* (z_m .^ 2) ./ 2) .* log((-i .* sqrt(-2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt(E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) + (-E .^ 2 .* xi_3 + (-D_TE + y_m) .* E - xi_3 + x_m) .* abs(z_m) + -i .* x_m .* xi_3 .* E .^ 2 + -i .* (x_m + xi_3) .* (D_TE - y_m) .* E + -i .* D_TE .^ 2 + 2.*i .* D_TE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_3)) + (((i .* (C .* (log((sqrt(xi_1 .^ 2 .* (C .^ 2) + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) .* sqrt((C .^ 2 + 1)) + (C .^ 2) .* xi_1 + (D_LE - y_m) .* C - x_m + xi_1) .* ((C .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1))) - log(((C .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) .* (sqrt((C .^ 2) .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) .* sqrt((C .^ 2 + 1)) + (C .^ 2) .* xi_3 + (D_LE - y_m) .* C - x_m + xi_3))) .* sqrt(E .^ 2 + 1) - E .* sqrt((C .^ 2 + 1)) .* (log((sqrt(xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) .* sqrt(E .^ 2 + 1) + E .^ 2 .* xi_1 + (D_TE - y_m) .* E - x_m + xi_1) .* (E .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) - log((E .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1) .* (sqrt(E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) .* sqrt(E .^ 2 + 1) + E .^ 2 .* xi_3 + (D_TE - y_m) .* E - x_m + xi_3)))) .* abs(z_m) .* sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) - ((0.1e1 ./ 0.2e1.*i .* D_LE + -0.1e1 ./ 0.2e1.*i .* y_m + i .* C .* x_m) .* abs(z_m) - C .* x_m .^ 2 ./ 2 + (-D_LE ./ 2 + y_m ./ 2) .* x_m + ((C .* z_m .^ 2) ./ 0.2e1)) .* sqrt((C .^ 2 + 1)) .* (log((-i .* sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(xi_1 .^ 2 .* (C .^ 2) + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + (-(C .^ 2) .* xi_1 + (-D_LE + y_m) .* C + x_m - xi_1) .* abs(z_m) + -i .* xi_1 .* x_m .* (C .^ 2) + -i .* (x_m + xi_1) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_1)) - log((-i .* sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt((C .^ 2) .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) + (-(C .^ 2) .* xi_3 + (-D_LE + y_m) .* C - xi_3 + x_m) .* abs(z_m) + -i .* x_m .* xi_3 .* (C .^ 2) + -i .* (x_m + xi_3) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_3))) .* sqrt(E .^ 2 + 1)) .* sqrt(2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) + sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* (log((-i .* sqrt(2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt((C .^ 2) .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) + ((C .^ 2) .* xi_3 + (D_LE - y_m) .* C - x_m + xi_3) .* abs(z_m) + -i .* x_m .* xi_3 .* (C .^ 2) + -i .* (x_m + xi_3) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (i .* x_m + -i .* xi_3 - abs(z_m))) - log((-i .* sqrt(2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(xi_1 .^ 2 .* (C .^ 2) + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + ((C .^ 2) .* xi_1 + (D_LE - y_m) .* C - x_m + xi_1) .* abs(z_m) + -i .* xi_1 .* x_m .* (C .^ 2) + -i .* (x_m + xi_1) .* (D_LE - y_m) .* C + -i .* D_LE .^ 2 + 2.*i .* D_LE .* y_m + -i .* y_m .^ 2 + -i .* (z_m .^ 2)) ./ (i .* x_m + -i .* xi_1 - abs(z_m)))) .* ((0.1e1 ./ 0.2e1.*i .* D_LE + -0.1e1 ./ 0.2e1.*i .* y_m + i .* C .* x_m) .* abs(z_m) + C .* x_m .^ 2 ./ 2 + (D_LE ./ 2 - y_m ./ 2) .* x_m - ((C .* z_m .^ 2) ./ 0.2e1)) .* sqrt((C .^ 2 + 1)) .* sqrt(E .^ 2 + 1)) .* sqrt(2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) - sqrt(-2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* (log((-2.*i .* sqrt(E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + (z_m .^ 2)) .* sqrt(2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) + (2 .* E .^ 2 .* xi_3 + (2 .* D_TE - 2 .* y_m) .* E + 2 .* xi_3 - 2 .* x_m) .* abs(z_m) + -2.*i .* x_m .* xi_3 .* E .^ 2 + -2.*i .* (x_m + xi_3) .* (D_TE - y_m) .* E + -2.*i .* (D_TE .^ 2 - 2 .* D_TE .* y_m + y_m .^ 2 + (z_m .^ 2))) ./ (i .* x_m + -i .* xi_3 - abs(z_m))) - log((-i .* sqrt(2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m)) .* sqrt(xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + (z_m .^ 2) + xi_1 .^ 2) + (E .^ 2 .* xi_1 + (D_TE - y_m) .* E - x_m + xi_1) .* abs(z_m) + -i .* x_m .* xi_1 .* E .^ 2 + -i .* (x_m + xi_1) .* (D_TE - y_m) .* E + -i .* (D_TE .^ 2 - 2 .* D_TE .* y_m + y_m .^ 2 + (z_m .^ 2))) ./ (i .* x_m + -i .* xi_1 - abs(z_m))) - log(0.2e1)) .* ((i .* x_m .* E + 0.1e1 ./ 0.2e1.*i .* D_TE + -0.1e1 ./ 0.2e1.*i .* y_m) .* abs(z_m) + E .* x_m .^ 2 ./ 2 + (D_TE ./ 2 - y_m ./ 2) .* x_m - E .* (z_m .^ 2) ./ 2) .* sqrt((C .^ 2 + 1)) .* sqrt(2.*i .* (C .* x_m + D_LE - y_m) .* C .* abs(z_m) + ((x_m + z_m) .* C + D_LE - y_m) .* ((x_m - z_m) .* C + D_LE - y_m)) .* sqrt(E .^ 2 + 1)) .* sqrt(-2.*i .* (x_m .* E + D_TE - y_m) .* E .* abs(z_m) + (D_TE + (x_m + z_m) .* E - y_m) .* (D_TE + (x_m - z_m) .* E - y_m))) ./ abs(z_m);
J_4 = -0.1e1 ./ 0.2e1.*i .* ((C .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) .* ((E .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) .* (sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* (i .* E .* abs(z_m) - (x_m .* E) - D_TE + y_m) .* sqrt((E .^ 2 + 1)) .* sqrt((C .^ 2 + 1)) .* y_m .* log((-i .* sqrt((xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + z_m .^ 2 + xi_1 .^ 2)) .* sqrt(-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) + ((-E .^ 2 .* xi_1 + (-D_TE + y_m) .* E + x_m - xi_1) .* abs(z_m)) + -i .* x_m .* xi_1 .* (E .^ 2) + -i .* (D_TE - y_m) .* (x_m + xi_1) .* E + -i .* (D_TE .^ 2) + 2.*i .* D_TE .* y_m + -i .* (y_m .^ 2) + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_1)) - sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* (i .* E .* abs(z_m) - (x_m .* E) - D_TE + y_m) .* sqrt((E .^ 2 + 1)) .* sqrt((C .^ 2 + 1)) .* y_m .* log((-i .* sqrt(-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .* sqrt((E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + z_m .^ 2)) + ((-E .^ 2 .* xi_3 + (-D_TE + y_m) .* E - xi_3 + x_m) .* abs(z_m)) + -i .* x_m .* xi_3 .* (E .^ 2) + -i .* (x_m + xi_3) .* (D_TE - y_m) .* E + -i .* (D_TE .^ 2) + 2.*i .* D_TE .* y_m + -i .* (y_m .^ 2) + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_3)) + sqrt(-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .* (((-2.*i .* abs(z_m) .* ((log(((C .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) .* (sqrt((xi_1 .^ 2 .* C .^ 2 + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + z_m .^ 2 + xi_1 .^ 2)) .* sqrt((C .^ 2 + 1)) + (C .^ 2 .* xi_1) + ((D_LE - y_m) .* C) - x_m + xi_1)) - log((sqrt((C .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + z_m .^ 2)) .* sqrt((C .^ 2 + 1)) + (C .^ 2 .* xi_3) + ((D_LE - y_m) .* C) - x_m + xi_3) .* ((C .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)))) .* sqrt((E .^ 2 + 1)) - sqrt((C .^ 2 + 1)) .* (log(((E .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1)) .* (sqrt((xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + z_m .^ 2 + xi_1 .^ 2)) .* sqrt((E .^ 2 + 1)) + (E .^ 2 .* xi_1) + ((D_TE - y_m) .* E) - x_m + xi_1)) - log((sqrt((E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + z_m .^ 2)) .* sqrt((E .^ 2 + 1)) + (E .^ 2 .* xi_3) + ((D_TE - y_m) .* E) - x_m + xi_3) .* ((E .^ 2 + 1) .^ (-0.1e1 ./ 0.2e1))))) .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) - (i .* C .* abs(z_m) - (C .* x_m) - D_LE + y_m) .* (log((-i .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt((xi_1 .^ 2 .* C .^ 2 + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + z_m .^ 2 + xi_1 .^ 2)) + ((-C .^ 2 .* xi_1 + (-D_LE + y_m) .* C + x_m - xi_1) .* abs(z_m)) + -i .* xi_1 .* x_m .* (C .^ 2) + -i .* (D_LE - y_m) .* (x_m + xi_1) .* C + -i .* (D_LE .^ 2) + 2.*i .* D_LE .* y_m + -i .* (y_m .^ 2) + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_1)) - log((-i .* sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt((C .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + z_m .^ 2)) + ((-C .^ 2 .* xi_3 + (-D_LE + y_m) .* C - xi_3 + x_m) .* abs(z_m)) + -i .* x_m .* xi_3 .* (C .^ 2) + -i .* (x_m + xi_3) .* (D_LE - y_m) .* C + -i .* (D_LE .^ 2) + 2.*i .* D_LE .* y_m + -i .* (y_m .^ 2) + -i .* (z_m .^ 2)) ./ (abs(z_m) + i .* x_m + -i .* xi_3))) .* sqrt((E .^ 2 + 1)) .* sqrt((C .^ 2 + 1)) .* y_m) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) + sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt((E .^ 2 + 1)) .* sqrt((C .^ 2 + 1)) .* (i .* C .* abs(z_m) + (C .* x_m) + D_LE - y_m) .* y_m .* (log((-i .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt((C .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_LE - y_m) .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + z_m .^ 2)) + ((C .^ 2 .* xi_3 + (D_LE - y_m) .* C - x_m + xi_3) .* abs(z_m)) + -i .* x_m .* xi_3 .* (C .^ 2) + -i .* (x_m + xi_3) .* (D_LE - y_m) .* C + -i .* (D_LE .^ 2) + 2.*i .* D_LE .* y_m + -i .* (y_m .^ 2) + -i .* (z_m .^ 2)) ./ (i .* x_m + -i .* xi_3 - abs(z_m))) - log((-i .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* sqrt((xi_1 .^ 2 .* C .^ 2 + 2 .* (D_LE - y_m) .* xi_1 .* C + D_LE .^ 2 - 2 .* D_LE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + z_m .^ 2 + xi_1 .^ 2)) + ((C .^ 2 .* xi_1 + (D_LE - y_m) .* C - x_m + xi_1) .* abs(z_m)) + -i .* xi_1 .* x_m .* (C .^ 2) + -i .* (D_LE - y_m) .* (x_m + xi_1) .* C + -i .* (D_LE .^ 2) + 2.*i .* D_LE .* y_m + -i .* (y_m .^ 2) + -i .* (z_m .^ 2)) ./ (i .* x_m + -i .* xi_1 - abs(z_m))))) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) - sqrt(-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* (i .* E .* abs(z_m) + (x_m .* E) + D_TE - y_m) .* sqrt(2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .* (log((-2.*i .* sqrt((E .^ 2 .* xi_3 .^ 2 + 2 .* xi_3 .* (D_TE - y_m) .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_3 .* x_m + xi_3 .^ 2 + y_m .^ 2 + z_m .^ 2)) .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) + ((2 .* E .^ 2 .* xi_3 + (2 .* D_TE - 2 .* y_m) .* E + 2 .* xi_3 - 2 .* x_m) .* abs(z_m)) + -2.*i .* x_m .* xi_3 .* (E .^ 2) + -2.*i .* (x_m + xi_3) .* (D_TE - y_m) .* E + -2.*i .* (D_TE .^ 2 - 2 .* D_TE .* y_m + y_m .^ 2 + z_m .^ 2)) ./ (i .* x_m + -i .* xi_3 - abs(z_m))) - log((-i .* sqrt(2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .* sqrt((xi_1 .^ 2 .* E .^ 2 + 2 .* (D_TE - y_m) .* xi_1 .* E + D_TE .^ 2 - 2 .* D_TE .* y_m + x_m .^ 2 - 2 .* xi_1 .* x_m + y_m .^ 2 + z_m .^ 2 + xi_1 .^ 2)) + ((E .^ 2 .* xi_1 + (D_TE - y_m) .* E - x_m + xi_1) .* abs(z_m)) + -i .* x_m .* xi_1 .* (E .^ 2) + -i .* (D_TE - y_m) .* (x_m + xi_1) .* E + -i .* (D_TE .^ 2 - 2 .* D_TE .* y_m + y_m .^ 2 + z_m .^ 2)) ./ (i .* x_m + -i .* xi_1 - abs(z_m))) - log(0.2e1)) .* sqrt((E .^ 2 + 1)) .* sqrt((C .^ 2 + 1)) .* y_m)) .* (-2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .^ (-0.1e1 ./ 0.2e1) .* (2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .^ (-0.1e1 ./ 0.2e1) .* (-2.*i .* E .* (x_m .* E + D_TE - y_m) .* abs(z_m) + ((D_TE + (x_m - z_m) .* E - y_m) .* (D_TE + (x_m + z_m) .* E - y_m))) .^ (-0.1e1 ./ 0.2e1) .* (2.*i .* C .* (C .* x_m + D_LE - y_m) .* abs(z_m) + (((x_m - z_m) .* C + D_LE - y_m) .* ((x_m + z_m) .* C + D_LE - y_m))) .^ (-0.1e1 ./ 0.2e1) ./ abs(z_m);

infl_new = zeros(3,6,len);

infl_new(1,3,:) = reshape(z_m.*J_2,1,1,[]);
infl_new(1,4,:) = reshape(z_m.*J_1,1,1,[]);
infl_new(1,5,:) = reshape(z_m.*J_4,1,1,[]);

infl_new(2,1,:) = reshape(z_m.*J_4,1,1,[]);
infl_new(2,2,:) = reshape(z_m.*J_1,1,1,[]);
infl_new(2,5,:) = reshape(z_m.*J_2,1,1,[]);

infl_new(3,2,:) = (-reshape(z_m.*J_1.*y_m ,1,1,[])+ reshape(z_m.*J_4,1,1,[]));
infl_new(3,4,:) = (-reshape(z_m.*J_1.*x_m,1,1,[]) + reshape(z_m.*J_2,1,1,[]));
toc
%%
count = 1;
D = parallel.pool.DataQueue;
h = waitbar(0, 'Please wait ...');
afterEach(D, @nUpdateWaitbar);

AbsTol = 1e-7;
RelTol = 1e-7;

% infl_loc = zeros(3,6,len);
infl_loc = real(infl_new);
parfor r = 1:len
% for i = 1:len
    le_eta = @(x) eta_2(r) + (x - xi_2(r)).*((eta_3(r) - eta_2(r))./(xi_3(r) - xi_2(r)));
    te_eta = @(x) eta_1(r) + (x - xi_1(r)).*((eta_3(r) - eta_1(r))./(xi_3(r) - xi_1(r)));
    
    tmp = zeros(3,6);
    
    if idx_on_element(r) == false
        %{
        denom = @(x,y) (((abs(zeta_p(r)).^2) + (abs(y - eta_p(r)).^2) + (abs(xi_p(r) - x).^2)).^(3/2));
%         disp(['Off Element Totally: ', num2str(r)])
                
        % A1
        term = @(x,y) (y.*zeta_p(r))./denom(x,y);
        tmp(2,1) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % A2
        term = @(x,y) zeta_p(r)./denom(x,y);
        tmp(2,2) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % B1
        term = @(x,y) (x.*zeta_p(r))./denom(x,y);
        tmp(1,3) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % B2
        term = @(x,y) zeta_p(r)./denom(x,y);
        tmp(1,4) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % C2
        term = @(x,y) (y.*zeta_p(r))./denom(x,y);
        tmp(1,5) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        term = @(x,y) (x.*zeta_p(r))./denom(x,y);
        tmp(2,5) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        
        % A1
        term = @(x,y) -(y.*(eta_p(r)-y))./denom(x,y);
        tmp(3,1) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % A2
        term = @(x,y) (y - eta_p(r))./denom(x,y);
        tmp(3,2) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % B1
        term = @(x,y) -(x.*(xi_p(r)-x))./denom(x,y);
        tmp(3,3) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % B2
        term = @(x,y) (x - xi_p(r))./denom(x,y);
        tmp(3,4) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        % C2
        term = @(x,y) (-x.*(eta_p(r) - y) - y.*(xi_p(r) - x))./denom(x,y);
        tmp(3,5) = integral2(term, xi_1(r), xi_3(r), le_eta, te_eta,'AbsTol',AbsTol','RelTol',RelTol);
        %}
    elseif idx_on_element(r) == true && idx_on_edge(r) == false
        denom = @(x,y) ((abs(y-eta_p(r)).^2 + abs(xi_p(r)-x).^2).^(3/2));
%         margin_edge = 2e-2;
        margin_edge = 1e-8;
%         disp(['On Element: ', num2str(r)])
        % A1
        term = @(x,y) -(y.*(eta_p(r)-y))./denom(x,y);        
        tmp(3,1) =  integral2(term, xi_1(r), xi_p(r) - margin_edge, le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_p(r) + margin_edge, xi_3(r), le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_1(r), xi_p(r) - margin_edge, eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_p(r) + margin_edge, xi_3(r), eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated');
        % A2
%         term = @(x,y) (y - eta_p(r))./denom(x,y);
%         tmp(3,2) =  integral2(term, xi_1(r), xi_p(r) - margin_edge, le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
%             integral2(term, xi_p(r) + margin_edge, xi_3(r), le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
%             integral2(term, xi_1(r), xi_p(r) - margin_edge, eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
%             integral2(term, xi_p(r) + margin_edge, xi_3(r), eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated');
        % B1
        term = @(x,y) -(x.*(xi_p(r)-x))./denom(x,y);
        tmp(3,3) =  integral2(term, xi_1(r), xi_p(r) - margin_edge, le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_p(r) + margin_edge, xi_3(r), le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_1(r), xi_p(r) - margin_edge, eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_p(r) + margin_edge, xi_3(r), eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated');
        % B2
%         term = @(x,y) (x - xi_p(r))./denom(x,y);
%         tmp(3,4) =  integral2(term, xi_1(r), xi_p(r) - margin_edge, le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
%             integral2(term, xi_p(r) + margin_edge, xi_3(r), le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
%             integral2(term, xi_1(r), xi_p(r) - margin_edge, eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
%             integral2(term, xi_p(r) + margin_edge, xi_3(r), eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated');
        % C2
        term = @(x,y) (-x.*(eta_p(r) - y) - y.*(xi_p(r) - x))./denom(x,y);
        tmp(3,5) =  integral2(term, xi_1(r), xi_p(r) - margin_edge, le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_p(r) + margin_edge, xi_3(r), le_eta, eta_p(r) + margin_edge,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_1(r), xi_p(r) - margin_edge, eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated') + ...
            integral2(term, xi_p(r) + margin_edge, xi_3(r), eta_p(r) - margin_edge, te_eta,'AbsTol',AbsTol','RelTol',RelTol, 'method', 'iterated');
    end
    
    infl_loc(:,:,r) = tmp;
    
    send(D, r);
end
close(h);

    function nUpdateWaitbar(~)
        waitbar(count/len, h);
        count = count + 1;
    end

% Only using the normal velocities for points on the element
% infl_loc(1:2,:,tester) = infl_loc(1:2,:,tester).*0;

%%
dvenum = reshape(repmat(dvenum,1,6,1)',[],1,1);

infl_tot = fcnSTARGLOB(reshape(permute(infl_loc,[2 3 1]),[],3,1), matROTANG(dvenum,:));
infl_tot(isnan(infl_tot)) = 0;

infl_glob = reshape(infl_tot',3,6,[]);


end

