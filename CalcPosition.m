function p=CalcPosition(s,param)

% Compute the position vector at s
%
% s: distance
% param: vector of the serie parameters
%
% Return P the position vector
%

global n s0 ds state0 Re
% state0: initial state of the frame at s=0
% state0=[x_0, y_0, z_0, phi0, theta0, psi0]

a_phi=param(1:n,1);
a_theta=param(n+1:2*n,1);
a_epsilon=param(3*n+1:4*n,1);

p=state0(1:3)';

epsilon_l=0.0;
for sc=s0:ds:s,
    if Re ~= 0.0,
        epsilon_l=f_evaluate(sc, a_epsilon, 0.0);
    end
    
    theta_l=f_evaluate(sc,a_theta,state0(5));
    phi_l=f_evaluate(sc,a_phi,state0(4));
    zeta=[sin(theta_l)*cos(phi_l);sin(theta_l)*sin(phi_l);cos(theta_l)]; 
    p=p + (1 + epsilon_l)*zeta*ds;
end