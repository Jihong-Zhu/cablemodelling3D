function f=f_evaluate(s,a,f0)
%
% Compute the function expressed as a serie
%   f(s)= \sum_{i=1}^ a_i*e_i(s) + f0
%
% s: current distance along the wire
% a: vector of the serie coefficients
% f0: f0=f(s=0) - initial value
%

global L n

e(1)=1;
e(2)=s;

for i=3:n,
    if mod(i,2)==1,
        k=(i-1)/2;
        e(i)=sin(2*pi*k*s/L);
    end
    if mod(i,2)== 0,
        k=(i-2)/2;
        e(i)=cos(2*pi*k*s/L);
    end
end

f=f0;
for i=1:n,
    f= f + a(i)*e(i);
end