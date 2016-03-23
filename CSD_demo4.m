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

[Phi, Theta, ~] = cart2sph(x, y, z);
Ori = [pi/2 - Theta, Phi];
Q = getQMatrix(Ori, 10);

M = pinv(Q'*Q)*Q';
f0 = M*F;

R  = zeros(66);
R(1, 1) = 0.0025;
R(2, 2) = 0.0016;
R(3, 3) = 0.0016;
R(4, 4) = 0.0016;
R(5, 5) = 0.0016;
R(6, 6) = 0.0016;

A = Q*R;

lambda = 1;
fi = f0;
u = Q*fi;
L1 = Q;
L0 = ones(size(L1));
L1(u < mean(u), :) = 0;
aa  = 0;
while sum(sum((L1 - L0).^2)) ~= 0
    L = lambda*L1;
    fi = pinv(A'*A + L'*L)*A'*F;
    save('test.mat', 'fi');
    L0 = L1;
    u = Q*fi;
    L1 = Q;
    L1(find(u < mean(u)), :) = 0;
end


save('exchange.mat', 'C', 'F', 'Ori');