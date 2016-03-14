function X = getComplexMatrix(Ori, lmax)
%GETCOMPLEXMATRIX is the function used to get the complex matrix consisted
%of the SH series. Now it is limited by 10, merely lmax = 0:2:10;
%
%Input:
%  Ori - must be the spherical coordinates,[Theta, Phi].
%  lmax - the maximum degree you limited to model the ADC profile.
%
%Output:
%  X - the complex matrix.size(X) is N*(lmax^2 + 2*lmax).N is the number of
%  the direction.

deg = 0:2:lmax;
lmax = deg(end);
X = zeros(size(Ori, 1), lmax^2 + 2*lmax);
Ycell = SH_mat_matrix; %get the even items of 10 degree spherical harmonics functional handles.
for aa = 1:size(Ori, 1)
    temp(aa, :) = map(num2cell(Ori(aa, :)), Ycell);
end

dd = 1;
for bb = 1:numel(deg)
    l = deg(bb);
    for cc = l^2 :l^2 + 2*l
        X(:, cc + 1) = temp(:, dd);
        dd = dd + 1;
    end
end
