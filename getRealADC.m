function dk = getRealADC(b_value, voxel_value)

S = voxel_value./(voxel_value(1));
dk = -1/b_value*log(S);