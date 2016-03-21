function [C, Order] = order_select(X, F, Ori)
%ORDER_SELECT - used to deduce the order of the fitted spherical harmonics
%
%Input:
%  X - the complex matrix
%  F - the observed ADC profile
%  Ori - the sampled direction
%
%Output:
%  Order - the selected order
%  C - the fitted coefficient
%
%IHEP
%Shaofeng Duan
%2016-03-21

X0 = X(:, 1);
M0 = pinv(X0'*X0)*X0';
C0 = M0*F;
for aa = 2:2:10
    Xaa = X(:, 1:(aa + 1)^2);
    Maa = pinv(Xaa'*Xaa)*Xaa';
    Caa = Maa*F;
    FVal = degree_contrast(C0, Caa, F, Ori);
    if FVal < 3
        if aa == 10
            C = 0;
            Order = 0;
        end
        C0 = Caa;
    else
        Order = aa; 
        C = Caa;
        break;
    end
end

function FVal = degree_contrast(C1, C2, RealVal, Ori)
%DEGREE_CONTRAST - is used to caculate the difference between two model.
%
%Input:
%  C1, C2 - the coefficients of two models
%  RealVal - the sample point observed value
%  Ori - the sampled direction
%Output:
%  F - the value to access the differcence between two models.
N  = numel(RealVal);
syms l
l1 = double(max(solve((l + 1)^2 == numel(C1), l)));
l2 = double(max(solve((l + 1)^2 == numel(C2), l)));
p1 = (l1 + 1)*(l1/2 + 1);
p2 = (l2 + 1)*(l2/2 + 1);

del_idx1 = SimMatrix(C1);
del_idx2 = SimMatrix(C2);
C1(del_idx1) = [];
C2(del_idx2) = [];

Ycell = SH_mat_matrix;
Ycell_C1 = Ycell(1:numel(C1));
Ycell_C2 = Ycell(1:numel(C2));
SumVal1 = real(getSumVal(Ycell_C1, C1, Ori));
SumVal2 = real(getSumVal(Ycell_C2, C2, Ori));


FVal = double((N - p2 - 1)*(var(SumVal2) - var(SumVal1))/(p2 - p1)/immse(RealVal, SumVal2));

% according to the degree to get the sample value.
function SumVal = getSumVal(Ycell, C, Ori)


Val = cellfun(@(f) f(Ori(: ,1), Ori(:, 2)), Ycell, 'UniformOutput', 0);

SumVal = 0;
for aa = 1:numel(Val)
    SumVal = SumVal + Val{aa}*C(aa);
end