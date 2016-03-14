function F = degree_contrast(C1, C2, N)

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
SumVal1 = real(getSumVal(Ycell_C1, C1));
SumVal2 = real(getSumVal(Ycell_C2, C2));


F = double((N - p2 - 1)*(var(SumVal2) - var(SumVal1))/(p2 - p1)/mean(SumVal2));

% according to the degree to get the sample value.
function SumVal = getSumVal(Ycell, C)

theta = 0:pi/180:2*pi;
phi = 0:pi/180:pi;

[Theta, Phi] = meshgrid(theta, phi);

Val = cellfun(@(f) f(Theta(:), Phi(:)), Ycell, 'UniformOutput', 0);

SumVal = 0;
for aa = 1:numel(Val)
    SumVal = SumVal + Val{aa}*C(aa);
end

    
