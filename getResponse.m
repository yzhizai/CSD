function R = getResponse(C, lmax)

n = (lmax + 1)*(lmax + 2)/2;
R = zeros(n, 1);
for l = 0:2:lmax
    R(((l-1)*l/2 + 1):(l + 1)*(l + 2)/2) = C((l^2 + l + 2)/2);
end
R = diag(R);