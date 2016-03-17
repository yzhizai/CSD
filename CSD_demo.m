clear variables
close all


OriFileName = spm_select(1, 'any');
OriFileName = cellstr(OriFileName);
Ori_cart = load(OriFileName{1});
x = Ori_cart(1,:)';
y = Ori_cart(2,:)';
z = Ori_cart(3,:)';

%-----------------------------------------
%abandon the 0,0,0 direction.
del_ele = sqrt(x.^2 + y.^2 + z.^2);
x(del_ele == 0) = [];
y(del_ele == 0) = []; 
z(del_ele == 0) = [];
%-----------------------------------------

[Theta, Phi, R] = cart2sph(x, y, z);
Ori = [Theta, pi/2 - Phi];
X = getComplexMatrix(Ori, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filenames = spm_select(1, '.img');
filenames = cellstr(filenames);
coordinates = [51, 55, 16];
Y = spm_read_vols(spm_vol(filenames{1}));
sample_vox = Y(66, 47, 17, :);
sample_vox = reshape(sample_vox, numel(sample_vox), 1);
RealADC = getRealADC(1000, sample_vox);
RealADC([1, 22, 43, 64]) = []; 
F = RealADC;

[C, Order] = order_select(X, F, Ori);

