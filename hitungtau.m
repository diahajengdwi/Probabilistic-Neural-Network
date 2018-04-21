% Nama	: Diah Ajeng Dwi Yuniasih
% Kelas	: IF39-12
% NIM	: 1301154558
function tau = hitungtau(kls0, kls1, kls2)
    m = 1; n = 1;
    % Mencari jarak terdekat antara data pada kelas 0
    for i = 1 : size(kls0,1)
        for j = 1 : size(kls0, 1)
            if i ~= j
                dist0(m,1) = norm([kls0(i,1) kls0(i,2) kls0(i,3)] - [kls0(j,1) kls0(j,2) kls0(j,3)]);
                m = m + 1;
            end
        end
        % Mencari jarak terdekat atau kecil
        mindist0(n,1) = min(dist0); 
        n = n + 1;
    end
    m = 1; n = 1;
    % Mencari jarak terdekat antara data pada kelas 1
    for i = 1 : size(kls1,1)
        for j = 1 : size(kls1, 1)
            if i ~= j 
                dist1(m,1) = norm([kls1(i,1) kls1(i,2) kls1(i,3)] - [kls1(j,1) kls1(j,2) kls1(j,3)]);
                m = m + 1;
            end
        end
        % Mencari jarak terdekat atau kecil
        mindist1(n,1) = min(dist1);
        n = n + 1;
    end
    m = 1; n = 1;
    % Mencari jarak terdekat antara data pada kelas 2
    for i = 1 : size(kls2,1)
        for j = 1 : size(kls2, 1)
            if i ~= j
                dist2(m,1) = norm([kls2(i,1) kls2(i,2) kls2(i,3)] - [kls2(j,1) kls2(j,2) kls2(j,3)]);
                m = m + 1;
            end
        end
        % Mencari jarak terdekat atau kecil
        mindist2(n,1) = min(dist2);
        n = n + 1;
    end
    
    % Menjumlahnya jarak-jarak terdekat
    dtot0 = sum(mindist0);
    dtot1 = sum(mindist1);
    dtot2 = sum(mindist2);
    
    % Mengisi nilai g dengan brute force
    g = 0.059;
    
    % Mencari nilai tau pada masing-masing kelas
    tau0 = (g * dtot0) / size(kls0,1);
    tau1 = (g * dtot1) / size(kls1,1);
    tau2 = (g * dtot2) / size(kls2,1);
    
    % Mereturn nilai tau
    tau = [tau0 tau1 tau2];
end

