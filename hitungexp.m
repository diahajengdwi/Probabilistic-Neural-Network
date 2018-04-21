% Nama	: Diah Ajeng Dwi Yuniasih
% Kelas	: IF39-12
% NIM	: 1301154558
function expo = hitungexp(x1,x2,x3,y1,y2,y3,tau)
    % x sbg testing & y sbg training
    hasil = norm([(x1 - y1) (x2 - y2) (x3 - y3)]);
    expo = exp(-((hasil^2)/(2*(tau)^2)));
end

