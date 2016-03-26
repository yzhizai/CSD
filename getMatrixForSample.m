function varargout = getMatrixForSample(varargin)
%GETMATRIXFORSAMPLE - used to obtain the sample oriention's attenuation
%profile.
%Usage :[Q, F] = GETMATRIXFORSAMPLE(filename, func);
%       Q = GETMATRIXFORSAMPLE(filename);
%
%IHEP
%Shaofeng Duan
%20160326
diff_ori = load(varargin{1});
x = diff_ori(:,1);
y = diff_ori(:,2);
z = diff_ori(:,3);

[Phi, Theta, ~] = cart2sph(x, y, z);
Ori = [Theta, Phi];
Q = getQMatrix(Ori, 10);

varargout{1} = Q;
if  nargin < 2
    return;
end
func = varargin{2};
F = zeros(size(diff_ori, 1), 1);
for aa = 1:size(diff_ori, 1)
    k = diff_ori(aa, :);
    F(aa) = func(k);
end
varargout{2} = F;