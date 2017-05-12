% N: refractive indices of all layers
% lambda: wavelenth you're calculating reflectance for
% numLayers: how many layers of thin films
% reflectance: reflectance (from 0 to 1)
function [reflectance] = thinFilm(N, lambda, numLayers)

% wavelength you're trying to reflect
targetWavelength = 950;
% you are able to deposit thin films at +/- variance thickness
variance = 80;
mat = {};
for i = 1:numLayers
	n = N(mod(i - 1,length(N)) + 1);
	k = 2 * pi * n / lambda;
	T = targetWavelength / (4 * n) + rand() * variance*2 - variance;
	mat{i} = [cos(k*T) 1/k*sin(k*T); -k*sin(k*T) cos(k*T)];
end

matrix = mat{end};
for i=length(mat)-1:-1:1
	matrix = matrix * mat{i};
end
kl = 2 * pi * N(1) / lambda;
kr = 2 * pi * N(mod(2*numLayers - 1,length(N)) + 1) / lambda;
r = (matrix(2,1) + kl*kr*matrix(1,2)) + j*(kl*matrix(2,2) - kr*matrix(1,1)) / ...
((-matrix(2,1) + kl*kr*matrix(1,2)) + j*(kl*matrix(2,2) + kr*matrix(1,1)));
reflectance = abs(r)^2;
