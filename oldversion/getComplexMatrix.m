function X = getComplexMatrix(Ori, lmax)
%GETCOMPLEXMATRIX is the function used to get the complex matrix consisted
%of the SH series. Now it is limited by 10, merely lmax = 0:2:10;
%
%Usage: X = GETCOMPLEXMATRIX(Ori, lmax)
%
%Input:
%  Ori - must be the spherical coordinates,[Theta, Phi].
%  lmax - the maximum degree you limited to model the ADC profile.
%
%Output:
%  X - the complex matrix.size(X) is N*(lmax + 1)^2.N is the number of
%  the direction.

deg = 0:2:lmax;
lmax = deg(end);
X = zeros(size(Ori, 1), (lmax + 1)^2);
Ycell = SH_mat_matrix; %get the even items of 10 degree spherical harmonics functional handles.
for aa = 1:size(Ori, 1)
    temp(aa, :) = map(num2cell(Ori(aa, :)), Ycell);
end

dd = 1;
for bb = 1:numel(deg)
    l = deg(bb);
    for cc = (l^2 + 1) :(l + 1)^2
        X(:, cc) = temp(:, dd);
        dd = dd + 1;
    end
end
