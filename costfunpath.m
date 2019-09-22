function F=costfunpath(c)
%
%
%
%
%
%
%

global param0 param1 dk

nc=size(c,2); 

i=1;
for k=0:dk:1,
    param=0.0;
    for j=1:nc,
        param=param + k^j*(1-k)*c(:,j);
    end
    param=(1-k)*param0 + k*param1 + param;
    % Compute the potential energy
    F(i)=costfun(param);
    i=i+1;
end