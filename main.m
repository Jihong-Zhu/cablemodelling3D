% 
% Modeling is from the paper "Static Modeling of Linear Object Deformation Based on Differential
% Geometry" by Wakamatsu (IJRR)
%
% Definition of the global frame:
%     x |
%       |  
%       |  
%       |
%       .--------> z
%      /
%     / 
%  y / 
%



clear
close ALL

addpath('Tools/');
global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1

% Length of the wire
L=1;

% Material properties
Rf=1;       % Flexural coefficient
Rt=1;       % Torsional coefficient
Re=0.0;     % extension coefficient
D=0.0;      % weight par m

% Numbers of function in the series
kmax=2;         % Use 2nd order approximation
n=2*kmax+2;     % number of parameters per varaible

% Discretization
N=50;
s0=0;
s1=L;       % normalized???
ds=(s1-s0)/N;

% Constraints
state0=zeros(1,6);  % One(fixed) end
% distance constraints
lx=-0.4;            
ly=0.0;             
lz=0.7;
state1=[state0(1)+lx state0(2)+ly state0(3)+lz 0.0 0.0 0.0];

% Computation
param0=zeros(4*n,1);
[param1, cost]=fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);

% Constraints
state0=zeros(1,6);
lx=0.8;
ly=0.2;
lz=0.4;
state1=[state0(1)+lx state0(2)+ly state0(3)+lz 0.0 pi/2.0 0.0];

% Computation
param0=zeros(4*n,1);
[param2, cost]=fmincon(@costfun,param0,[],[],[],[],[],[],@nonlinc);

% 3D view of the wire
f1=figure(1);grid on;hold on;
ca=gca(f1);
title(ca,'3D view');
view(0,0);
axis([-L L -L L 0.0 L]);
xlabel(ca,'X');ylabel(ca,'Y');zlabel(ca, 'Z');

plotDLO(param0);
plotDLO(param1);
plotDLO(param2);

% Plot position and orientation
[p_dat, PHI_dat]=plotDLO(param1);

time=1:1:length(p_dat);

f2=figure(2);
plot(time, p_dat);
ca=gca(f2);
title(ca,'Position');
xlabel(ca,'t');ylabel(ca, 'P(s)');
legend(ca, 'x', 'y', 'z');

f3=figure(3);
plot(time, PHI_dat);
ca=gca(f3);
title(ca,'Orientation');
xlabel(ca,'t');ylabel(ca, '\phi, \theta, \psi');
legend(ca, '\phi', '\theta', '\psi');
