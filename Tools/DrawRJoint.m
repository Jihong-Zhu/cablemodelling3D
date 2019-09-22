function DrawRJoint(T, a, flag, s)
%
% function DrawSJoint(T, a, flag)
%
% Draw a rotoid joint represented by a cylinder aligned with the a axis
%
% T: 4x4 homogeneous matrix associated with the joint in the world frame
% a: axe that specifies the orientation of the joint in local coordinates
% flag: if 1, draw the frame associated with the joint
% s: scale factor
%

[m,n]=size(T);
if m ~= 4,
    disp('Invalid dimension of T');
    return;
end
if n ~= 4,
    disp ('Invalid dimension of T');
    return;
end


% Draw the frame associated with the joint
if flag == 1,
    DrawFrame(T, s, 1.0);
end

% Draw the revolute joint
% By default, the cylinder axis is aligned with the z-axis
r1=s/10;r2=s/10;h=s/2;

if abs(abs(a(1)) - 1.0) <= 1e-6,
    R= RotAxeAngle('y', pi/2);
    col=[1.0;0.0;0.0];
end
if abs(abs(a(2)) - 1) <= 1e-6,
    R= RotAxeAngle('x', -pi/2);
    col=[0.0;1.0;0.0];
end
if abs(abs(a(3)) - 1) <= 1e-6,
    R= eye(4,4);
    col=[0.0;0.0;1.0];
end

[X,Y,Z]=cylinder([r1 r2]);
[m,n]=size(X);

for i=1:m,
    for j=1:n,
        P=T*R*[X(i,j);Y(i,j);h*(Z(i,j)-0.5);1.0];
        XX(i,j)=P(1);
        YY(i,j)=P(2);
        ZZ(i,j)=P(3);
    end
end
C=zeros(m,n,3);
C(:,:,1)=col(1);
C(:,:,2)=col(2);
C(:,:,3)=col(3);
mesh(XX,YY,ZZ, C);
    
