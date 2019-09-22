function [c,ceq]=nonlinc(param)
%
% Evaluate the constraints
%
% param: vecteur of the serie parameters - p=[a_phi, a_theta, a_psi, a_epsilon] 
%    is 1x4n vector 
%
% state0: initial state of the frame at s=s0
%         state0=[x_0, y_0, z_0, phi0, theta0, psi0]
%
% state1: final state of the frame at s=s1
%         state1=[x_1, y_1, z_1, phi1, theta1, psi1]

global n s0 s1 ds lx ly lz state0 state1 Re


c=[];

a_phi=param(1:n,1);
a_theta=param(n+1:2*n,1);
a_psi=param(2*n+1:3*n,1);
a_epsilon=param(3*n+1:4*n,1);

% Constraints at s=s0
i=1;ceq(i)=state0(4)-f_evaluate(s0,a_phi, state0(4));
i=i+1;ceq(i)=state0(5)-f_evaluate(s0,a_theta, state0(5));
i=i+1;ceq(i)=state0(6)-f_evaluate(s0,a_psi, state0(6));
if Re ~= 0.0,
    i=i+1;ceq(i)=f_evaluate(s0,a_epsilon, 0.0);
end


% Constraints at s=s1
% Orientations
i=i+1;ceq(i)=state1(4)-f_evaluate(s1,a_phi, state0(4));
i=i+1;ceq(i)=state1(5)-f_evaluate(s1,a_theta, state0(5));
i=i+1;ceq(i)=state1(6)-f_evaluate(s1,a_psi, state0(6));
%ceq(8)=f_evaluate(s0,a_epsilon, 0.0); to be bixed

% Positions
p=CalcPosition(s1,param);
i=i+1;ceq(i)=lx - (p(1) - state0(1));
i=i+1;ceq(i)=ly - (p(2) - state0(2));
i=i+1;ceq(i)=lz - (p(3) - state0(3));
