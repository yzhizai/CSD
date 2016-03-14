function del_idx = SimMatrix(C)
%SIMMATRIX - this function was created to simplified the coefficent matrix
%C, which is the solution of spherical harmonics series.
syms l
l1 = double(max(solve((l + 1)^2 == numel(C), l)));
del_idx = [];
if l1 > 0
    for bb = 2:2:l1
        del_idx = [del_idx, ((bb - 1)^2 + 1):bb^2];
    end
end