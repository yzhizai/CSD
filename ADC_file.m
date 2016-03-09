function ADC_file
n = 60;
lmax = 10;

X = zeros(n, sh_idx(lmax, lmax));
for aa = 1:n
    thetai = theta(aa);
    phii = phi(aa);
    for l = 0:lmax
        lengval = lengendre(l, cos(thetai), 'sch');
        for m = -1*l:1:l
            X(aa, sh_idx(l, m)) = Ylm(l, m, lengval, phii);
        end
    end
end
function SH_idx = sh_idx(l, m)
SH_idx = l*l + l + m;

function val = Ylm(l, m, lengval,  phii)
if m < 0
    val = sqrt(2)*(-1)^m*Im(Ylm(l, abs(m)));
elseif m == 0
    val = sqrt((2*l + 1)/(4*pi))*lengval(1);
else
    val = sqrt(2)*(-1)^m*Re((-1)^m*sqrt((2*l + 1)*factorial(l - m)/(4*pi)/factorial(l + m))*exp(1i*m*phii)*lengval(m + 1));
end