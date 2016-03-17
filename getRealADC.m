function dk = getRealADC(b_value, voxel_value)

if numel(size(voxel_value)) == 4
    S = voxel_value./repmat(voxel_value(:, :, :, 1), 1, 1, 1, size(voxel_value, 4));
else
    S = voxel_value./(voxel_value(1));
end
dk = -1/b_value*log(S);