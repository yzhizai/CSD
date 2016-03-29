function CSD_demo7
%This is the most useful demo to test CSD method.
D1 = diag([1.7, 0.2, 0.2]);
D2 = diag([0.2, 0.2, 1.7]);

myfunc = @(k) -1/1000*log(0.5*(exp(-k*D1*k') + exp(-k*D2*k')));

filename1 = 'Grad_dirs_60.txt';


[Q, F] = getMatrixForSample(filename1, myfunc);

M = pinv(Q'*Q)*Q';
S = M*F;

% C0 = CSD_demo6;
% Beta = [1, 1, 1, 0.8, 0.1, 0.02];
% 
% R = getResponse(C0, 10);
% 
% 
% C = fi;

save('exchange.mat', 'S');
