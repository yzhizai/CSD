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

[theta, phi] = cart2sph(x, y, z);

phi = pi/2 - phi;
