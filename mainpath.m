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
% Option
optimpath=true;            % compute the optimal path
optimpathcst=true;         % compute with constraints
optimpathview=true;         % Display the path

global Rf Rt Re D L
global n s0 s1 ds lx ly lz state0 state1 dk zcmin zcmax
global param0 param1

% Length of the wire
L=1;

% Material properties
Rf=1;       % Flexural coefficient
Rt=1;       % Torsional coefficient
Re=0.0;     % extension coefficient
D=0.0;      % weight par m

% Number of functions in the series
kmax=2;
n=2*kmax+2;

% Discretization
N=50;
s0=0;
s1=L;       % normalized???
ds=(s1-s0)/N;

% Optimal path computation
dk=0.1;
nc=5;
zcmax=0.8;
zcmin=0.5;


% Computation of the first congiguration
state0=zeros(1,6);
lx=-0.8;
ly=0.0;
lz=0.5;
state1=[state0(1)+lx state0(2)+ly state0(3)+lz 0.0 -pi/2 0.0];

param_init=zeros(4*n,1);
[param0, cost]=fmincon(@costfun,param_init,[],[],[],[],[],[],@nonlinc);

% Computation of the second congiguration
state0=zeros(1,6);
lx=0.6;
ly=0.0;
lz=0.7;
state1=[state0(1)+lx state0(2)+ly state0(3)+lz 0.0 pi/2 0.0];

param_init=zeros(4*n,1);
[param1, cost]=fmincon(@costfun,param_init,[],[],[],[],[],[],@nonlinc);


% 3D view of the wire
f1=figure(1);grid on;hold on;
ca=gca(f1);
title(ca,'3D view');
view(0,0);
axis([-L L -L L 0.0 L]);
xlabel(ca,'X');ylabel(ca,'Y');zlabel(ca, 'Z');
plotDLO(param0);
plotDLO(param1);

pause(2);

% Computation of the optimal path
if optimpath,
    disp('Search for optimal path...');
    cinit=zeros(4*n,nc);
    if optimpathcst,
        c=fminimax(@costfunpath,cinit,[],[],[],[],[],[],@nonlincpath);
    else
        c=fminimax(@costfunpath,cinit,[],[],[],[],[],[],[]);
    end
end

if optimpathview && optimpath,
    for k=dk:dk:1-dk,
        param=zeros(4*n,1);
        for j=1:nc,
            param=param + k^j*(1-k)*c(:,j);
        end
        param=(1-k)*param0 + k*param1 + param;
        [p_dat, PHI_dat]=plotDLO(param);
        pend=p_dat(:,length(p_dat));
        text(pend(1)+0.02,pend(2)+0.02,pend(3)+0.02,strcat('k=',num2str(k)));
    end
end