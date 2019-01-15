function I = fcnK0(S, t, u, alpha, F, tol, idx) 
len = size(S,1);
I = nan(len,2);
 
idx_tmp = logical(idx(:,:,1));
I(idx_tmp) = fcnK0A(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,2));
I(idx_tmp) = fcnK0B(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,3));
I(idx_tmp) = fcnK0C(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,4));
I(idx_tmp) = fcnK0D(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,5));
I(idx_tmp) = fcnK0E(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,6));
I(idx_tmp) = fcnK0F(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,7));
I(idx_tmp) = fcnK0G(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,8));
I(idx_tmp) = fcnK0H(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,9));
I(idx_tmp) = fcnK0I(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,10));
I(idx_tmp) = fcnK0J(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,11));
I(idx_tmp) = fcnK0K(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,12));
I(idx_tmp) = fcnK0L(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,13));
I(idx_tmp) = fcnK0M(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,14));
I(idx_tmp) = fcnK0N(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,15));
I(idx_tmp) = fcnK0O(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,16));
I(idx_tmp) = fcnK0P(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,17));
I(idx_tmp) = fcnK0Q(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,18));
I(idx_tmp) = fcnK0R(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,19));
I(idx_tmp) = fcnK0S(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 
idx_tmp = logical(idx(:,:,20));
I(idx_tmp) = fcnK0T(S(idx_tmp), t(idx_tmp), u(idx_tmp), alpha(idx_tmp), reshape(F(idx_tmp(:,:,[1,1])),[],1,2), tol); 

end