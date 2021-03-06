OriFileName = spm_select(1, 'any');
OriFileName = cellstr(OriFileName);
Ori_cart = load(OriFileName{1});
x = Ori_cart(1,:)';
y = Ori_cart(2,:)';
z = Ori_cart(3,:)';

%-----------------------------------------
%abandon the 0,0,0 direction.
del_ele = sqrt(x.^2 + y.^2 + z.^2);
x(del_ele == 0) = [];
y(del_ele == 0) = []; 
z(del_ele == 0) = [];
%-----------------------------------------

[Phi, Theta, R] = cart2sph(x, y, z);
Ori = [pi/2 - Theta, Phi];
X = getComplexMatrix(Ori, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filenames = spm_select(1, '.img');
filenames = cellstr(filenames);
coordinates = [51, 55, 16];
Vol = spm_vol(filenames{1});
Y = spm_read_vols(Vol);
Y_dim  = size(Y);
temp = zeros(Y_dim(1:3));

h = waitbar(0, 'processing...');

RealADC = getRealADC(1000, Y);
RealADC(:, :, :, [1, 22, 43, 64]) = [];
for aa = 1:Y_dim(3)
    for bb = 1:Y_dim(2)
        parfor cc = 1:Y_dim(1)
            sample_vox = RealADC(cc, bb, aa, :);  
            sample_vox = reshape(sample_vox, numel(sample_vox), 1);
            F = sample_vox;
            [C, Order] = order_select(X, F, Ori);
            temp(cc, bb, aa) = Order;
        end
        waitbar(aa*bb/(Y_dim(2)* Y_dim(3)));
    end
end
close(h);
vol = Vol(1);
fname = 'orderImage.img';
vol.fname = fname;
vol = spm_create_vol(vol);
spm_write_plane(vol, temp, ':');
