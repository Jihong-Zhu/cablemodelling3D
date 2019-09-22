function PHI=CalcOrientation(s,param)

% Compute the Eulerian angles at s
%
%
% s: distance
% param: vector of the serie parameters
%
% Return PHI the vector of Eulerian angles
%

global n state0

a_phi=param(1:n,1);
a_theta=param(n+1:2*n,1);
a_psi=param(2*n+1:3*n,1);

phi=f_evaluate(s,a_phi,state0(4));
theta=f_evaluate(s,a_theta,state0(5));
psi=f_evaluate(s,a_psi,state0(6));

PHI=[phi;theta;psi];
