function df=f_derivate(s,a)
%
% Compute the derivate of the function expressed as a serie
%   f(s)= \sum_{i=1}^ a_i*e_i(s)
%
% s: current distance along the wire
% a: vector of the serie coefficients
%

global L n

e(1)=0;
e(2)=1;

for i=3:n,
    if mod(i,2) ==1,
        k=(i-1)/2;
        e(i)=(2*pi*k/L)*cos(2*pi*k*s/L);
    end
    if mod(i,2) == 0,
        k=(i-2)/2;
        e(i)=-(2*pi*k/L)*sin(2*pi*k*s/L);
    end
end

df=0;
for i=1:n,
    df= df + a(i)*e(i);
end
