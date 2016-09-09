function [ xsi ] = glob_star_3D( x,nu,eps,psi )
   
        
    % INPUT:
    % X(m,n,[x y z]) - 3D matrix 
    % mu(m,n)        - 2D matrix 
    % eps(m,n)       - 2D matrix 
    % psi(m,n)       - 2D matrix 
    
    % OUTPUT:
    % xsi(m,n,[x y z]) - 3D matrix
    
    % rot is now 4D matrix.   rot([],[],m,n);
    % Alton Dec3 2015
    
    % Check input matrix size
    [A,B,C] = size(x);
    
    if C ~= 3
        warning('Input matrix x must be 3D');
        return
    else
    
    % transformation from x-reference frame to xsi_star-reference frame
    %first rotation:  x   -> x', rotation about x-axis by nu
    %second rotation: x'  -> xsi, rotation about y'-axis by eps
    %third rotation:  xsi -> xsi*, rotation about zeta-axis by psi
    %all rotations follow right-hand rule
    %
    cnu = cosd(nu);
    snu=sind(nu);
    ceps = cosd(eps);
    seps=sind(eps);
    cpsi = cosd(psi);
    spsi=sind(psi);
    %
    %the rotation matrix:
    % 	rot[0][0] = cpsi*ceps;
    % 				rot[0][1] = cpsi*seps*snu+spsi*cnu;
    % 							rot[0][2] =-cpsi*seps*cnu+spsi*snu;
    % 	rot[1][0] =-spsi*ceps;
    % 				rot[1][1] =-spsi*seps*snu+cpsi*cnu;
    %  							rot[1][2] = spsi*seps*cnu+cpsi*snu;
    % 	rot[2][0] = 	 seps;
    % 				rot[2][1] = 	-ceps*snu;
    % 			 					rot[2][2] =		 ceps*cnu;
    rot(1,1,:,:) = cpsi.*ceps;
    rot(1,2,:,:) = cpsi.*seps.*snu+spsi.*cnu;
    rot(1,3,:,:) = -cpsi.*seps.*cnu+spsi.*snu;
    rot(2,1,:,:) = -spsi.*ceps;
    rot(2,2,:,:) = -spsi.*seps.*snu+cpsi.*cnu;
    rot(2,3,:,:) = spsi.*seps.*cnu+cpsi.*snu;
    rot(3,1,:,:) = seps;
    rot(3,2,:,:) = -ceps.*snu;
    rot(3,3,:,:) = ceps.*cnu;
    %printf("\n rot0 %2.2lf %2.3lf %2.3lf ",rot[0][0],rot[0][1],rot[0][2]);
    %printf("\n rot1 %2.2lf %2.3lf %2.3lf ",rot[1][0],rot[1][1],rot[1][2]);
    %printf("\n rot2 %2.2lf %2.3lf %2.3lf ",rot[2][0],rot[2][1],rot[2][2]);
    %
        %the rotation matrix:
    % 	rot[0][0] = cpsi*ceps;
    % 				rot[0][1] = cpsi*seps*snu+spsi*cnu;
    % 							rot[0][2] =-cpsi*seps*cnu+spsi*snu;
    % 	rot[1][0] =-spsi*ceps;
    % 				rot[1][1] =-spsi*seps*snu+cpsi*cnu;
    %  							rot[1][2] = spsi*seps*cnu+cpsi*snu;
    % 	rot[2][0] = 	 seps;
    % 				rot[2][1] = 	-ceps*snu;
    % 			 					rot[2][2] =		 ceps*cnu;
    %transforming x into xsi*
%     xsi[0] = x[0]*rot[0][0] + x[1]*rot[0][1] + x[2]*rot[0][2];
%     xsi[1] = x[0]*rot[1][0] + x[1]*rot[1][1] + x[2]*rot[1][2];
%     xsi[2] = x[0]*rot[2][0] + x[1]*rot[2][1] + x[2]*rot[2][2];
%     
    xsi(:,:,1) = x(:,:,1).*reshape(rot(1,1,:,:),A,B) + x(:,:,2).*reshape(rot(1,2,:,:),A,B) + x(:,:,3).*reshape(rot(1,3,:,:),A,B);
    xsi(:,:,2) = x(:,:,1).*reshape(rot(2,1,:,:),A,B) + x(:,:,2).*reshape(rot(2,2,:,:),A,B) + x(:,:,3).*reshape(rot(2,3,:,:),A,B);
    xsi(:,:,3) = x(:,:,1).*reshape(rot(3,1,:,:),A,B) + x(:,:,2).*reshape(rot(3,2,:,:),A,B) + x(:,:,3).*reshape(rot(3,3,:,:),A,B);
    end
   
    
end