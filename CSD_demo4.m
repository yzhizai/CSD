D1 = diag([1.7, 0.2, 0.2]);
D2 = diag([0.2, 0.2, 1.7]);

diff_ori = load('Grad_dirs_60.txt');
F = zeros(size(diff_ori, 1), 1);
for aa = 1:size(diff_ori, 1)
    k = diff_ori(aa, :);
    F(aa) = -1/1000*log(0.5*(exp(-k*D1*k') + exp(-k*D2*k')));
end


x = diff_ori(:,1);
y = diff_ori(:,2);
z = diff_ori(:,3);

[Theta, Phi, R] = cart2sph(x, y, z);
Ori = [Theta, pi/2 - Phi];
X = getComplexMatrix(Ori, 8);

Maa = pinv(X'*X)*X';
Caa = Maa*F;


del_idx1 = SimMatrix(Caa);

Caa(del_idx1) = [];
