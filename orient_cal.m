function [theta, phi] = orient_cal(fname)
%ORIENT_CAL is the function used to transform the q space direction to
%spherical coordinates.
%
%Input:
%  fname - the direction files
%
% Author: Shaofeng Duan (duansf@ihep.ac.cn)
% Institute of High Energy Physics 
% Feb 2016
orient_array = load(fname);
x = orient_array(1, :)';
y = orient_array(2, :)';
z = orient_array(3, :)';

% delete non-dwi direction
del_ele = sqrt(x.^2 + y.^2 + z.^2); 
x(del_ele == 0) = [];
y(del_ele == 0) = [];
z(del_ele == 0) = [];

[theta, phi] = cart2sph(x, y, z);

phi = pi/2 - phi;
