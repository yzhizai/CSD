function X = getComplexMatrix(lmax)
%GETCOMPLEXMATRIX is the function used to get the complex matrix consisted
%of the SH series. Now it is limited by 10, merely lmax = 0:2:10;
%

fname = spm_select(1, 'any');
[theta, phi] = orient_cal(fname);
Ori = [theta, phi];
deg = 0:2:lmax;
lmax = deg(end);
X = zeros(size(Ori, 1), lmax^2 + 2*lmax);
Ycell = SH_mat; %get the even items of 10 degree spherical harmonics functional handles.
for aa = 1:size(Ori, 1)
    temp(aa, :) = map(num2cell(Ori(aa, :)), Ycell);
end

dd = 1;
for bb = 1:size(deg)
    l = deg(bb);
    for cc = l^2 :l^2 + 2*l
        X(:, cc + 1) = temp(:, dd);
        dd = dd + 1;
    end
end
