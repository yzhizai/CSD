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

[Phi, Theta, R] = cart2sph(x, y, z);
Ori = [pi/2 - Theta, Phi];
X = getComplexMatrix(Ori, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filenames = spm_select(1, '.img');
filenames = cellstr(filenames);
Y = spm_read_vols(spm_vol(filenames{1}));
sample_vox = Y(66, 47, 17, :);
sample_vox = reshape(sample_vox, numel(sample_vox), 1);
RealADC = getRealADC(1000, sample_vox);
RealADC([1, 22, 43, 64]) = []; 
F = RealADC;

[C, Order] = order_select(X, F, Ori);

F = [F; F];
Ori = [Ori; [pi - Ori(:, 1), pi + Ori(:, 2)];
save('exchange.mat', 'C', 'F', 'Ori');
%----------------------------------------------------------------
scaF = scatteredInterpolant(Ori(:, 1), Ori(:, 2), F);
[Xq, Yq] = meshgrid(linspace(0, pi, 100), linspace(0, 2*pi, 100));
Vq = scaF(Xq, Yq);

figure
surf(Xq, Yq, Vq)


