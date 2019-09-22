function T=RotAxeAngle(axe, angle)
%
% T=RotAxeAngle(axe, angle)
%
% Compute the 4x4 homogeneous matrix for an
% elementary rotation along a given axe
% axe: 'x', 'y', 'z'
% angle: angle in rd
%
%

flag=0;
if axe =='x',
    T=[1 0 0 0;0 cos(angle) -sin(angle) 0;0 sin(angle) cos(angle) 0;0 0 0 1];
    flag=1;
end
if axe =='y',
    T=[cos(angle) 0 sin(angle) 0;0 1 0 0;-sin(angle) 0 cos(angle) 0;0 0 0 1];
    flag=1;
end
if axe =='z',
    T=[cos(angle) -sin(angle) 0 0;sin(angle) cos(angle) 0 0;0 0 1 0;0 0 0 1];
    flag=1;
end
if flag ~= 1,
    disp('Specified axe is not known - set matrix to indentity')
    T=eye(4,4);
end

            