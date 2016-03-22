function Bmat = Bmatrix(qSpace)
%BMATRIX - is a function used to caculate diffusion tensor conviniently.
%
% Usage: Bmat = BMATRIX(qSpace)
%
%Input:
%  qSpace - b value vector
%Output:
%  Bmat - B matrix type.
%
%IHEP
%Shaofeng Duan
%2016-03-22


x = qSpace(:, 1);
y = qSpace(:, 2);
z = qSpace(:, 3);

Bmat = [x.^2, y.^2, z.^2, 2*x.*y, 2*x.*z, 2*y.*z];