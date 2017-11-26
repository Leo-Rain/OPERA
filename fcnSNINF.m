function [infl] = fcnSNINF(qm, qn, c3, z, h)

c2 = (qn - qm);
c2 = c2./sqrt(sum(c2.^2,2));
c1 = cross(c2,c3);

a = dot(qm, c1, 2);
l1 = dot(qm, c2, 2);
l2 = dot(qn, c2, 2);

[H00, H10, H01, H20, H11, H02] = fcnHINTEGRAL_2(a,h,l1,l2);

ori = dot(c3, cross(qm,qn), 2)./abs(dot(c3, cross(qm,qn), 2));
% bs_1 = z.*(b00.*H00(:,1) + b10.*H10(:,1) + b01.*H01(:,1)).*c1 - z.*(a00.*H00(:,1) + a10.*H10(:,1) + a01.*H01(:,1)).*c2 + (b00.*H10(:,1) + b10.*H20(:,1) + b01.*H11(:,1) - a00.*H01(:,1) - a10.*H11(:,1) - a01.*H02(:,1)).*c3;

% First order term
b = [-z.*H00.*c2(:,1) - H01.*c3(:,1), -z.*H00.*c2(:,2) - H01.*c3(:,2), -z.*H00.*c2(:,3) - H01.*c3(:,3)];
% Second order term
c = [-z.*H10.*c2(:,1) - H11.*c3(:,1), -z.*H10.*c2(:,2) - H11.*c3(:,2), -z.*H10.*c2(:,3) - H11.*c3(:,3)];

% First order term
e = [z.*H00.*c1(:,1) + H10.*c3(:,1), z.*H00.*c1(:,2) + H10.*c3(:,2), z.*H00.*c1(:,3) + H10.*c3(:,3)];
% Second order term
f = [z.*H01.*c1(:,1) + H11.*c3(:,1), z.*H01.*c1(:,2) + H11.*c3(:,2), z.*H01.*c1(:,3) + H11.*c3(:,3)];

% Orientation of the triangle (determines whether to add or subtract influence)
% First, set all orientations the same, then apply comb to add or subtract
ori = dot(c3, cross(qm, qn), 2)./abs(dot(c3, cross(qm, qn), 2));

% Order: [Second Order | First Order | 0 | Second Order | First Order | 0]
infl = [reshape(c',3,1,[]) reshape(b',3,1,[]) reshape(c'.*0,3,1,[]) reshape(f',3,1,[]) reshape(e',3,1,[]) reshape(f'.*0,3,1,[])];
infl = infl.*repmat(reshape(ori,1,1,[]),3,6,1);

end