function Q = getQMatrix(Ori, lmax)
%GETQMATRIX is the function used to get the Q matrix consisted
%of the SH series as Tournier surgested. Now it is limited by 10, merely lmax = 0:2:10;
%
%Usage: X = GETCOMPLEXMATRIX(Ori, lmax)
%
%Input:
%  Ori - must be the spherical coordinates,[Theta, Phi].
%  lmax - the maximum degree you limited to model the ADC profile.
%
%Output:
%  Q - the Q matrix, its value is Re(Ylm) when m>=0 and Im(Ylm) when m < 0
%
%IHEP
%Shaofeng Duan
%20160323

deg = 0:2:lmax;
lmax = deg(end);

Ycell = SH_mat_matrix; %get the even items of 10 degree spherical harmonics functional handles.
for aa = 1:size(Ori, 1)
    temp(aa, :) = map(num2cell(Ori(aa, :)), Ycell);
end

Q = temp;
for l = 2:2:lmax
    Q(:, ((l-1)*l/2+1):((l-1)*l/2+l)) = imag(Q(:, ((l-1)*l/2+1):((l-1)*l/2+l)));
    Q(:, ((l+1)*(l+2)/2 - l):(l+1)*(l+2)/2) = real(Q(:, ((l+1)*(l+2)/2 - l):(l+1)*(l+2)/2));
end


