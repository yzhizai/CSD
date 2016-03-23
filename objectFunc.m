function o = objectFunc(f, A, b, L)

lambda = 1;
o = sum((A*f - b).^2) + lambda^2*sum((L*f).^2);
o = -o;