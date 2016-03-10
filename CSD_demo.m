filenames = spm_select(1, '.img');
filenames = cellstr(filenames);
coordinates = [66, 47, 17];
Y = spm_read_vols(spm_vol(filenames{1}));

sample_vox = Y(66, 47, 17, :);
sample_vox = reshape(sample_vox, numel(sample_vox), 1);
RealADC = getRealADC(1000, sample_vox);
RealADC([1, 22, 43, 64]) = []; 
F = RealADC;
X = getComplexMatrix(4);
M = (conj(X)'*X)*conj(X)';

C = M*F;
C(C == 0) = [];
Ycell = SH_mat_matrix;
Ycell_abs = Ycell(1:numel(C));

theta = 0:pi/180:2*pi;
phi = 0:pi/180:pi;

[Theta, Phi] = meshgrid(theta, phi);
Val = cellfun(@(f) f(Theta, Phi), Ycell_abs, 'UniformOutput', 0);

SumVal = 0;
for aa = 1:numel(Val)
    SumVal = SumVal + Val{aa}*C(aa);
end
