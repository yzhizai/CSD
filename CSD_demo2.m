D = diag([1.7, 0.2, 0.2])*10^-3;
diff_ori = load('Grad_dirs_60.txt');
F = zeros(size(diff_ori, 1), 1);
for aa = 1:size(diff_ori, 1)
    k = diff_ori(aa, :);
    F(aa) = k*D*k';
end


x = diff_ori(:,1);
y = diff_ori(:,2);
z = diff_ori(:,3);

[Phi, Theta, R] = cart2sph(x, y, z);
Ori = [pi/2 - Theta, Phi];
X = getComplexMatrix(Ori, 10);

[C, order] = order_select(X, F, Ori);
save('exchange.mat', 'C', 'F', 'Ori');