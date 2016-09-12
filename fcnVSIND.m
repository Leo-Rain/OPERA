function [al, bl, cl] = fcnVSIND(endpoints, phi, psi, fpl, k)

% Computationally, this function appears inefficient because we do calculations that we later overwrite
% with special conditions. Also, there are indices that are computed repeatedly instead of once and saved.
% I'm not sure how these affect run-time, but they improve readability.
% T.D.K 2016-09-07 745-55 RIVER OAKS PLACE, SAN JOSE, CALIFORNIA, USA 95134

% INPUT:
%   endpoints - nx3x2 matrix, where (:,:,1) are first points and (:,:,2) are second. First are 
%           left LE points, second are right LE points.
%   phi - nx1 vector of leading edge sweep, direction matters
%   psi - rotation of the vortex sheet. Zero rotation is eta of the VS aligned with local eta axis of HDVE
%           90 degrees is for up to down (I think)
%   fpl - nx3 matrix of field points in local coordinates of HDVE
%   k - singularity factor, not sure if we are using this now
%
% OUTPUT:
%   al, bl, cl - local a, b, c for calculation of induced velocity

% Most equation labels are from Appendix 2 of Bramesfeld's thesis

% First we need to translate and rotate to the get the fp coordinates in the VS reference frame (_0)
dbl_eps = 1e-14;

eta_translation = mean(endpoints,3);

% idxVS = ismember(eta_VS, [0 1 0], 'rows');
% 
% % half-span of the elements
% % hspan = endpoints(:,1,:);
% % hspan(idxVS,:,:) = endpoints(idxVS,2,:);
% % hspan = mean(hspan,3);
% 
% hspan = abs(endpoints(:,1,2) - endpoints(:,1,1))./2;
% hspan(idxVS) = endpoints(endpoints(idxVS,2,2) - endpoints(idxVS,2,1))./2;

hspan1 = abs(endpoints(:,1,2) - endpoints(:,1,1))./2;
hspan2 = abs(endpoints(:,2,2) - endpoints(:,2,1))./2;

hspan = hspan1.*cos(psi) + hspan2.*sin(psi);

fp_0 = fpl - eta_translation;
% fp_0(:,2) = -fp_0(:,2); % flipping xsi direction so it goes downwards in local ref frame

eta_0 = fp_0(:,1).*cos(psi) + fp_0(:,2).*sin(psi);
xsi_0 = fp_0(:,1).*sin(psi) + fp_0(:,2).*cos(psi);
zeta_0 = fp_0(:,3);

% fp_0(idxVS,:) = [-fp_0(idxVS,2) fp_0(idxVS,1) fp_0(idxVS,3)];
% 
% eta_0 = fp_0(:,1);
% xsi_0 = fp_0(:,2);
% zeta_0 = fp_0(:,3);

len = length(eta_0(:,1));

% Eqn A2-12
a2 = 1 + (tan(phi).^2);
b2 = (xsi_0 - eta_0.*tan(phi)).*tan(phi);
c2 = (xsi_0 - eta_0.*tan(phi)).^2 + zeta_0.^2;
t1 = eta_0 + hspan;
t2 = eta_0 - hspan;
rt_1 = sqrt((t1.^2).*a2 + 2.*t1.*b2 + c2);
rt_2 = sqrt((t2.^2).*a2 + 2.*t2.*b2 + c2);

% Eqn A2-5
eps = ((xsi_0 - eta_0.*tan(phi)).^2) - (zeta_0.^2).*(tan(phi)).^2;
rho = sqrt(eps.^2 + 4.*(zeta_0.^2).*(b2.^2));
beta1 = -sqrt((rho + eps)./2);
beta2 = -sqrt((rho - eps)./2);

% Corrections to beta for special conditions
beta1(0.5.*(rho + eps) <= dbl_eps) = 0;
beta2(0.5.*(rho - eps) <= dbl_eps) = 0;

idx_B2 = (abs(zeta_0.*b2) > dbl_eps);
beta2(idx_B2) = beta2(idx_B2).*(zeta_0(idx_B2).*b2(idx_B2))./abs(zeta_0(idx_B2).*b2(idx_B2));

% Eqn A2-8
mu3_1 = a2.*t1 + b2 + sqrt(a2).*rt_1;
mu3_2 = a2.*t2 + b2 + sqrt(a2).*rt_2;

% gamma1 = (1./rho).*(a2.*beta2.*zeta_0 + b2.*beta1);
% gamma2 = (1./rho).*(a2.*beta1.*zeta_0 - b2.*beta2);
% delta1 = (1./rho).*(b2.*beta2.*zeta_0 + c2.*beta1);
% delta2 = (1./rho).*(b2.*beta1.*zeta_0 - c2.*beta2);
% mu1_1 = ((gamma1.*t1 + delta1 - rt_1).^2 + (gamma2.*t1 + delta2).^2)./(k + t1.^2 + zeta_0.^2);
% mu1_2 = ((gamma1.*t2 + delta1 - rt_2).^2 + (gamma2.*t2 + delta2).^2)./(k + t2.^2 + zeta_0.^2);
% mu2_1 = atan2(zeta_0,t1) + atan2(gamma2.*t1 + delta2, gamma1.*t1 + delta1 - rt_1);
% mu2_2 = atan2(zeta_0,t2) + atan2(gamma2.*t2 + delta2, gamma1.*t2 + delta1 - rt_2);

% He changed the above equations to the below ones
gamma1 = (a2.*beta2.*zeta_0 + b2.*beta1);
gamma2 = (a2.*beta1.*zeta_0 - b2.*beta2);
delta1 = (b2.*beta2.*zeta_0 + c2.*beta1);
delta2 = (b2.*beta1.*zeta_0 - c2.*beta2);
mu1_1 = ((gamma1.*t1 + delta1 - rt_1.*rho).^2 + (gamma2.*t1 + delta2).^2);
mu1_2 = ((gamma1.*t2 + delta1 - rt_2.*rho).^2 + (gamma2.*t2 + delta2).^2);
mu2_1 = atan(zeta_0./t1) + atan((gamma2.*t1 + delta2)./(gamma1.*t1 + delta1 - rt_1.*rho));
mu2_2 = atan(zeta_0./t2) + atan((gamma2.*t2 + delta2)./(gamma1.*t2 + delta1 - rt_2.*rho));

%% Implementing special conditions

idx_m21 = (t1.^2 < dbl_eps);
mu2_1(idx_m21) = (pi/2).*abs(zeta_0(idx_m21))./zeta_0(idx_m21) + ...
    atan((gamma2(idx_m21).*t1(idx_m21) + delta2(idx_m21))./ ...
    (gamma1(idx_m21).*t1(idx_m21) + delta1(idx_m21) - rt_1(idx_m21).*rho(idx_m21)));

mu2_1(zeta_0 > 0 & t1 < 0 & t1.^2 > dbl_eps) = mu2_1(zeta_0 > 0 & t1 < 0 & t1.^2 > dbl_eps) + pi;
mu2_1(zeta_0 < 0 & t1 < 0 & t1.^2 > dbl_eps) = mu2_1(zeta_0 < 0 & t1 < 0 & t1.^2 > dbl_eps) - pi;
mu2_1(gamma1.*t1 + delta1 - rt_1.*rho < 0) = mu2_1(gamma1.*t1 + delta1 - rt_1.*rho < 0) + pi;
mu2_1(gamma2.*t1 + delta2 < 0 & gamma1.*t1 + delta1 - rt_1.*rho > 0) = ...
    mu2_1(gamma2.*t1 + delta2 < 0 & gamma1.*t1 + delta1 - rt_1.*rho > 0) + 2*pi;

idx_m22 = (t2.^2 < dbl_eps);
mu2_2(idx_m22) = (pi/2).*abs(zeta_0(idx_m22))./zeta_0(idx_m22) + ...
    atan((gamma2(idx_m22).*t2(idx_m22) + delta2(idx_m22))./ ...
    (gamma1(idx_m22).*t2(idx_m22) + delta1(idx_m22) - rt_2(idx_m22).*rho(idx_m22)));

mu2_2(zeta_0 > 0 & t2 < 0 & ~idx_m22) = mu2_2(zeta_0 > 0 & t2 < 0 & ~idx_m22) + pi;
mu2_2(zeta_0 < 0 & t2 < 0 & ~idx_m22) = mu2_2(zeta_0 < 0 & t2 < 0 & ~idx_m22) - pi;
mu2_2(gamma1.*t2 + delta1 - rt_2.*rho < 0) = mu2_2(gamma1.*t2 + delta1 - rt_2.*rho < 0) + pi;
mu2_2(gamma2.*t2 + delta2 < 0 & gamma1.*t2 + delta1 - rt_2.*rho > 0) = ...
    mu2_2(gamma2.*t2 + delta2 < 0 & gamma1.*t2 + delta1 - rt_2.*rho > 0) + 2*pi;

% Using half span instead of half chord - unconfirmed if this is OK
mu3_1(abs(phi) > dbl_eps) = 0.0001.*hspan(abs(phi) > dbl_eps) + mu3_1(abs(phi) > dbl_eps);
mu3_2(abs(phi) > dbl_eps) = 0.0001.*hspan(abs(phi) > dbl_eps) + mu3_2(abs(phi) > dbl_eps);

%%

G25b = zeros(len,1);
G25c = zeros(len,1);
G26a = zeros(len,1);
G21b = zeros(len,1);
G21c = zeros(len,1);

G25b = -0.5.*log((k + zeta_0.^2 + t2.^2)./(k + zeta_0.^2 + t1.^2));
G25c = -hspan.*log((k + zeta_0.^2 + t1.^2).*(k + zeta_0.^2 + t2.^2));

G25c(abs(t1) > dbl_eps) = G25c(abs(t1) > dbl_eps) + t1(abs(t1) > dbl_eps).* ...
    log(zeta_0(abs(t1) > dbl_eps) + t1(abs(t1) > dbl_eps).^2);
G25c(abs(t2) > dbl_eps) = G25c(abs(t2) > dbl_eps) - t2(abs(t2) > dbl_eps).* ...
    log(zeta_0(abs(t2) > dbl_eps) + t2(abs(t2) > dbl_eps).^2);

% Eqn A2-9
% G25 = (0.5.*log(k + t2.^2 + zeta_0.^2)) - (0.5.*log(k + t1.^2 + zeta_0.^2));
G25 = (0.5.*log(t2.^2 + zeta_0.^2)) - (0.5.*log(t1.^2 + zeta_0.^2));

% Eqn A2-3
% G21 = ((beta1./(2.*rho)).*log(mu1_2) + (beta2./rho).*mu2_2) - ((beta1./(2.*rho)).*log(mu1_1) + (beta2./rho).*mu2_1);
G21 = (beta1.*(0.5.*log(mu1_2./mu1_1) - G25) + beta2.*(mu2_2 - mu2_1))./rho;
 
% Eqn A2-4
% G22 = ((1./xsi_0).*(-(beta2./(2.*rho)).*log(mu1_2) + (beta1./rho).*mu2_2)) ...
%     - ((1./xsi_0).*(-(beta2./(2.*rho)).*log(mu1_1) + (beta1./rho).*mu2_1));

G22 = (-beta2.*(0.5.*log(mu1_2./mu1_1) - G25) + beta1.*(mu2_2 - mu2_1))./(rho.*zeta_0);

% Eqn A2-6
G23 = ((1./a2).*rt_2 - (b2./sqrt(a2.^3)).*log(mu3_2)) - ((1./a2).*rt_1 - (b2./sqrt(a2.^3)).*log(mu3_1));

% Eqn A2-7
G24 = ((1./sqrt(a2)).*log(mu3_2)) - ((1./sqrt(a2)).*log(mu3_1));

% Eqn A2-10
% G26 = ((1./zeta_0).*atan2(t2,zeta_0)) - (1./zeta_0).*atan2(t1,zeta_0);
G26 = ((1./zeta_0).*atan(t2./zeta_0)) - (1./zeta_0).*atan(t1./zeta_0);

% Eqn A2-11
G27 = t2 - t1;

% Eqn A2-13
b21 = -(xsi_0 - (eta_0.*tan(phi)));
b22 = (zeta_0.^2).*tan(phi);
b23 = zeros(len,1);
b24 = -tan(phi);
b25 = -ones(len,1);
b26 = zeros(len,1);
b27 = zeros(len,1);

c21 = -2.*((zeta_0.^2).*tan(phi) + eta_0.*(xsi_0 - eta_0.*tan(phi)));
c22 = -2.*(zeta_0.^2).*(xsi_0 - 2.*eta_0.*tan(phi));
c23 = 2.*tan(phi);
c24 = 2.*(xsi_0 - 2.*eta_0.*tan(phi));
c25 = -2.*eta_0;
c26 = -2.*(zeta_0.^2);
c27 = repmat(2,len,1);

% Point is in plane spanned by bound vortex and zeta axis
idx20 = (abs(xsi_0 - eta_0.*tan(phi)) <= dbl_eps);
G21(idx20) = 0;
G22(idx20) = 0;
G25(idx20) = 0.5.*log((t2(idx20).^2 + zeta_0(idx20).^2)./(t1(idx20).^2 + zeta_0(idx20).^2));
G26a(idx20) = atan(((t2(idx20) - t1(idx20)).*zeta_0(idx20)./(zeta_0(idx20).^2 + t1(idx20).*t2(idx20))));

idx21 = (abs(xsi_0 - eta_0.*tan(phi)) <= dbl_eps & (zeta_0.^2 + t1.*t2) < 0 & t2./zeta_0 > 0 );
G26a(idx21) = G26(idx21) + pi;

idx22 = (abs(xsi_0 - eta_0.*tan(phi)) <= dbl_eps & (zeta_0.^2 + t1.*t2) < 0 & t2./zeta_0 < 0 );
G26a(idx22) = G26(idx22) - pi;

G26(idx20) = G26a(idx20)./zeta_0(idx20);

idx23 = (abs(xsi_0 - eta_0.*tan(phi)) <= dbl_eps & abs(zeta_0) <= dbl_eps);
G26(idx23) = 0;

% Point is in plane of vortex sheet, but not on bound vortex
idx30 = (abs(xsi_0 - eta_0.*tan(phi)) > dbl_eps & abs(zeta_0) < dbl_eps);
G21(idx30) = 0;

G21b(idx30) = b21(idx30).*beta1(idx30).*(0.5.*log(mu1_2(idx30)./mu1_1(idx30)) + G25b(idx30))./rho(idx30);
G21c(idx30) = b21(idx30).*beta1(idx30).*(eta_0(idx30).*log(mu1_2(idx30)./mu1_1(idx30)) + G25c(idx30))./rho(idx30);

G22(idx30) = 0;
G26(idx30) = 0;

G24(logical(abs(mu3_2 <= dbl_eps | abs(mu3_1) <= dbl_eps))) = 0;

% Eqn A2-2
b2_eta = -zeta_0.*(G21.*b24 + G22.*b21 + G26.*b25);
b2_zeta = G21.*b21 + G22.*b22 + G23.*b23 + G24.*b24 + G25.*b25 + G26.*b26 + G27.*b27;

c2_eta = -zeta_0.*(G21.*c24 + G22.*c21 + G24.*c23 + G25.*c27 + G26.*c25);
c2_zeta = G21.*c21 + G22.*c22 + G23.*c23 + G24.*c24 + G25.*c25 + G26.*c26 + G27.*c27;

b2_xsi = zeros(size(b2_eta));
c2_xsi = zeros(size(c2_eta));

% If point lies on eta-xsi plane
idx40 = (zeta_0.^2 <= dbl_eps);
b2_eta(idx40) = 0;
c2_eta(idx40) = 0;
b2_zeta(idx40) = G21b(idx40) + G24(idx40).*b24(idx40) + G25b(idx40);
c2_zeta(idx40) = G21c(idx40) + G23(idx40).*c23(idx40) + G24(idx40).*c24(idx40) + G25c(idx40) + G27(idx40).*c27(idx40);

% G21b wrong
% G25b negative sign

% a, b, c in local ref frame
bl = [b2_xsi b2_eta b2_zeta];
cl = [c2_xsi c2_eta c2_zeta];
al = zeros(size(bl));

% If the point lies on a swept leading edge
idx_LE = abs(zeta_0) <= dbl_eps & abs(xsi_0 - eta_0.*tan(phi)) <= dbl_eps; %& abs(phi) <= dbl_eps;
bl(idx_LE,:) = zeros(size(bl(idx_LE,:)));
cl(idx_LE,:) = zeros(size(cl(idx_LE,:)));

clear idx_LE 

% If the point lies on an unswept leading edge
idx_LE = abs(zeta_0) <= dbl_eps & abs(xsi_0 - eta_0.*tan(phi)) <= dbl_eps & abs(phi) <= dbl_eps;
bl(idx_LE,1:2) = zeros(size(bl(idx_LE,1:2)));
cl(idx_LE,1:2) = zeros(size(cl(idx_LE,1:2)));
bl(idx_LE,3) = 0.5.*log((t1(idx_LE).^2 + k(idx_LE))./(t2(idx_LE).^2 + k(idx_LE)));
cl(idx_LE,3) = -4.*hspan(idx_LE) + eta_0(idx_LE).*2.*bl(idx_LE,3);


%% Rotate 90 degrees to appropriate direction if needed

tempb(:,2) = bl(:,1).*cos(psi) + bl(:,2).*sin(psi);
tempb(:,1) = bl(:,1).*sin(psi) + bl(:,2).*cos(psi);
bl(:,1:2) = tempb;

tempc(:,2) = cl(:,1).*cos(psi) + cl(:,2).*sin(psi);
tempc(:,1) = cl(:,1).*sin(psi) + cl(:,2).*cos(psi);
cl(:,1:2) = tempc;

end

