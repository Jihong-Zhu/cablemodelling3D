function C=costfun(param)
%
% Cost function to minimize
%  
% C is expressed as the sum of the potential energy due
%   a) flexural energy
%   b) torsion energy
%   c) extensional energy - supposed to be
%   d) gravitational energy
%
% param: vecteur of the serie parameters - p=[a_phi, a_theta, a_psi, a_epsilon] 
%    is 1x4n vector
%

global n s0 s1 ds Rf Rt Re D state0
% state0: initial state of the frame at s=0
% state0=[x_0, y_0, z_0, phi0, theta0, psi0]

Uflex=0;
Utor=0.0;
Uext=0.0;
Ugrav=0.0;

for s=s0:ds:s1,
    % Compute kappa^2=(dtheta/ds)^2 + sin^2(theta)*(dphi/ds)^2
    a_phi=param(1:n,1);
    a_theta=param(n+1:2*n,1);
    theta=f_evaluate(s,a_theta,state0(5));
    dtheta=f_derivate(s, a_theta);
    dphi=f_derivate(s, a_phi);
    kappa_2=dtheta^2 + sin(theta)^2*dphi^2;
    Uflex=Uflex + Rf*kappa_2*ds;
    
    % Compute omega^2=((dphi/ds)*cos(theta) + dpsi/ds)^2
    a_psi=param(2*n+1:3*n,1);
    dpsi=f_derivate(s, a_psi);
    omega_2=(dphi*cos(theta) + dpsi)^2;
    Utor=Utor + Rt*omega_2*ds;
    
    % Compute the extensional energy
    if Re ~= 0.0,
        a_epsilon=param(3*n+1:4*n,1);
        epsilon=f_evaluate(s,a_epsilon,0.0);
        Uext=Uext + Re*epsilon^2*ds;
    end
    
    % Compute gravitational energy: 
    %   1) first compute the current position along x
    %   2) compute the energy
    
    if D~= 0.0,
        x=state0(1);
        epsilon_l=0.0;
        for sl=s0:ds:s,
            if Re ~= 0.0,
                epsilon_l=f_evaluate(sl, a_epsilon, 0.0);
            end
            theta_l=f_evaluate(sl,a_theta,state0(5));
            phi_l=f_evaluate(sl,a_phi,state0(4));
            x=x+(1 + epsilon_l)*sin(theta_l)*cos(phi_l)*ds;
        end    
        Ugrav=Ugrav + D*x*ds;
    end
end

C=0.5*Uflex + 0.5*Utor + 0.5* Uext + Ugrav;