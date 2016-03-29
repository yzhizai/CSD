Gamma = 2000*(1.7 - 0.2)*10^-3;

filename1 = 'Grad_dirs_60.txt';
filename2 = 'Grad_dirs_300.txt';

A = getResponseMatrix(filename1, filename2, Gamma);


D1 = diag([1, 0.25, 0.25])*10^-3;
D2 = diag([0.25, 0.25, 1])*10^-3;

myfunc = @(k) 0.5*(exp(-2000*k*D1*k') + exp(-2000*k*D2*k'));
func = @(k) exp(-2000*k*D1*k');
[~, F] = getMatrixForSample(filename1, myfunc);
Q = getMatrixForSample(filename2);

f0 = lsqnonneg(A, F);

C = pinv(Q'*Q)*Q'*f0;
save('exchange.mat', 'C');