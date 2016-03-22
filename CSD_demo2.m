D = diag([0.95, 0.95, 0.2])*10^-3;
diff_ori = load('Grad_dirs_60.txt');
F = zeros(size(diff_ori, 1), 1);
for aa = 1:size(diff_ori, 1)
    k = diff_ori(aa, :);
    F(aa) = k*D*k';
end


x = diff_ori(:,1);
y = diff_ori(:,2);
z = diff_ori(:,3);

[Theta, Phi, R] = cart2sph(x, y, z);
Ori = [Theta, pi/2 - Phi];
X = getComplexMatrix(Ori, 2);

Maa = pinv(X'*X)*X';
Caa = Maa*F;


del_idx1 = SimMatrix(Caa);

Caa(del_idx1) = [];

% X0 = X(:,1);
% M0 = pinv(X0'*X0)*X0';
% C0 = M0*F;
% 
% for aa = 2:2:10
%     Xaa = X(:, 1:(aa + 1)^2);
%     Maa = pinv(Xaa'*Xaa)*Xaa';
%     Caa = Maa*F;
%     FVal = degree_contrast(C0, Caa, F, Ori)
%     C0 = Caa;
% end