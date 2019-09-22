function [p_dat, PHI_dat]=plotDLO(param)

%
% Draw the DLO in 3D
%
% param: vector of serie parameters
%
%

global s0 ds s1 L

% figure(1);grid on;hold on;
% axis([-L L -L L]);
% xlabel('x');ylabel('y');

scale=L/10;
T=eye(4,4);
DrawFrame(T,scale,2.0);

p_dat=[];
PHI_dat=[];
for s=s0:ds:s1,
    p=CalcPosition(s,param);
    PHI=CalcOrientation(s,param);
    T=RotAxeAngle('z',PHI(1))*RotAxeAngle('y',PHI(2))*RotAxeAngle('z',PHI(3));
    T(1:3,4)=p;
%     DrawFrame(T,scale,1.0);
    DrawRJoint(T,[0;0;1.0],1,scale);
    p_dat=[p_dat p];
    PHI_dat=[PHI_dat PHI];
end