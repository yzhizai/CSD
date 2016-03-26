function CSD_demo4
%This is the most useful demo to test CSD method.
D1 = diag([1, 0.25, 0.25]);
D2 = diag([0.25, 0.25, 1]);

myfunc = @(k) -1/1000*log(0.5*(exp(-k*D1*k') + exp(-k*D2*k')));

filename1 = 'Grad_dirs_60.txt';
filename2 = 'Grad_dirs_300.txt';

[Q, F] = getMatrixForSample(filename1, myfunc);
P = getMatrixForSample(filename2);
M = pinv(Q'*Q)*Q';
S = M*F;
C0 = CSD_demo6;

R = getResponse(C0, 10);
f0 = pinv(R'*R + 1)*R'*S;

A = Q*R; 
lambda = 1;
fi = f0;
fi(16:end) = 0;
u = P*fi;
L1 = P;
L0 = ones(size(L1));
L1(u >= 0.1*mean(u), :) = 0;
while sum(sum((L1 - L0).^2)) ~= 0
    L = lambda*L1;
    fi = pinv(A'*A + L'*L)*A'*F;
    L0 = L1;
    u = P*fi;
    L1 = P;
    L1(find(u >= 0.1*mean(u)), :) = 0;
end
C = fi;

save('exchange.mat', 'C');
