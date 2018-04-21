% Nama	: Diah Ajeng Dwi Yuniasih
% Kelas	: IF39-12
% NIM	: 1301154558
function pdf = hitungpdf(tau, n, expo)
    % n = jml data per kelas
    % p jml atribut
    p = 3;
    bagi = 1 / ((2*pi)^(p/2)*(tau^p)*n);
    pdf = bagi * expo;
end

