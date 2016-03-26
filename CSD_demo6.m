function C = CSD_demo6

D = diag([1.7, 0.2, 0.2])*10^-3;

filename = 'Grad_dirs_60.txt';
func = @(k) k*D*k';
[Q, F] = getMatrixForSample(filename, func);

M = pinv(Q'*Q)*Q';
C = M*F;

save('exchange.mat', 'C');
