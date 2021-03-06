function A = getResponseMatrix(filename_real, filename_sim, Gamma)
%GETRESPONSEMATRIX - get the response matrix
%
%Usage: A = GETRESPONSEMATRIX(filename_real, filename_sim, Gamma)
%
%Input:
%  filename_real - the real collect diffusion gradient
%  filename_sim  - the simulated diffusion gradient
%  Gamma         - the value of the largest diffusion eigenvalue - smallest
%  diffusion eigenvalue
%
%Output:
%  A - the response matrix
%
%IHEP
%Shaofeng Duan
%2016-03-29
Ori_real = load(filename_real);
Ori_sim  = load(filename_sim);

Ori_real_nrow = size(Ori_real, 1);
Ori_sim_nrow  = size(Ori_sim, 1);

A = zeros(Ori_real_nrow, Ori_sim_nrow);

for aa = 1:Ori_real_nrow
    for bb = 1:Ori_sim_nrow
        A(aa, bb) = exp(-Gamma*(Ori_real(aa, :)*Ori_sim(bb, :)')^2);
    end
end
        
