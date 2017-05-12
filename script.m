g = [];
parfor lam = 400:3000
	output = thinFilm([3.03 1.46], lam, 10);
	g(lam) = output;
end

%{
% normalizing code for when error present
g = log(g) / log(max(g));
g(find(g == -Inf())) = 0;
if min(g) < 0
	g = g - min(g);
end
g = g / max(g);
%}
g(1:399) = 0;
plot(g);
xlabel('wavelength (nm)');
ylabel('reflectivity');
