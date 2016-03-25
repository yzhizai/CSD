function C = CSD_demo6

D = diag([0.25, 0.25, 1])*10^-3;
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
Q = getQMatrix(Ori, 10);
M = pinv(Q'*Q)*Q';
C = M*F;
