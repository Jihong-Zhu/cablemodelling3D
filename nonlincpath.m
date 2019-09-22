function [cin,ceq]=nonlincpath(c)
%
% Evaluate the non linear constraints
%
% c: vector of coefficient
%
% cin: vector of inequalities
% ceq: vector of equalities

global s1 dk param0 param1 zcmin zcmax


[m,nc]=size(c);
cin = [];

i=1;
for k=0:dk:1,
    param=zeros(m,1);
    for j=1:nc,
        param=param + k^j*(1-k)*c(:,j);
    end
    param=(1-k)*param0 + k*param1 + param;
    p=CalcPosition(s1,param);
    % Andre's original constraints
%     cin(i)=p(3)-zcmax;
%     i=i+1;
%     cin(i)=zcmin-p(3);
%     i=i+1;
    % My constraints
    if p(1) <= 0.2 && p(1) >= -0.4
        cin(i) = p(3) - 0.8;
        i = i + 1;
    else
        cin(i) = p(3) - 1;
        i = i + 1;
    end
end

ceq=[];

