function DrawFrame(T, s, lw)
%
% function DrawFrame(T, s, lw)
%
% Draw a 3D frame associated with the 
% homogeneous transformation T
%
% T: homogeneous matrx
% s: scale factor
% lw: line width
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


%s=50;
x(1)=T(1,4);y(1)=T(2,4);z(1)=T(3,4);
plot3(x,y,z);

k=1;
x(2)=x(1) + s*T(1,k);
y(2)=y(1) + s*T(2,k);
z(2)=z(1) + s*T(3,k);
plot3(x, y, z, 'r', 'LineWidth', lw);

k=2;
x(2)=x(1) + s*T(1,k);
y(2)=y(1) + s*T(2,k);
z(2)=z(1) + s*T(3,k);
plot3(x, y, z, 'g', 'LineWidth', lw);

k=3;
x(2)=x(1) + s*T(1,k);
y(2)=y(1) + s*T(2,k);
z(2)=z(1) + s*T(3,k);
plot3(x, y, z, 'b', 'LineWidth', lw);

