clear all; clc;
% Nama	: Diah Ajeng Dwi Yuniasih
% Kelas	: IF39-12
% NIM	: 1301154558

% Load data training
datatraining = dlmread('data_train_PNN.txt','\t','A2..D151');
% Load data testing
datatesting = dlmread('data_test_PNN.txt','\t','A2..C31');
a = 1; b = 1; c = 1;
% Mengelompokkan atribut data training pada masing-masing kelas
for i = 1 : size(datatraining,1)
    % Mengelompokkan atribut data training  pada kelas 0
    if datatraining(i,4) == 0
        kelas0(a,1) = datatraining(i,1);
        kelas0(a,2) = datatraining(i,2);
        kelas0(a,3) = datatraining(i,3);
        a = a + 1;
    % Mengelompokkan atribut data training pada kelas 1
    elseif datatraining(i,4) == 1
        kelas1(b,1) = datatraining(i,1);
        kelas1(b,2) = datatraining(i,2);
        kelas1(b,3) = datatraining(i,3);
        b = b + 1;
    % Mengelompokkan atribut data training pada kelas 2
    elseif datatraining(i,4) == 2
        kelas2(c,1) = datatraining(i,1);
        kelas2(c,2) = datatraining(i,2);
        kelas2(c,3) = datatraining(i,3);
        c = c + 1;
    end
end

k0 = 0; k1 = 0; k2 = 0;
% Menghitung tau / smoothing effect
tau = hitungtau(kelas0, kelas1, kelas2);
for i = 1 : 30
    % Menghitung sigma pada kelas 0
    for j = 1 : size(kelas0,1)
        k0 = k0 + hitungexp(datatesting(i,1),datatesting(i,2),datatesting(i,3),kelas0(j,1),kelas0(j,2),kelas0(j,3),tau(1,1));
    end
    % Menghitung sigma pada kelas 1
    for k = 1 : size(kelas1,1)
        k1 = k1 + hitungexp(datatesting(i,1),datatesting(i,2),datatesting(i,3),kelas1(k,1),kelas1(k,2),kelas1(k,3),tau(1,2));
    end
    % Menghitung sigma pada kelas 2
    for l = 1 : size(kelas2,1)
        k2 = k2 + hitungexp(datatesting(i,1),datatesting(i,2),datatesting(i,3),kelas2(l,1),kelas2(l,2),kelas2(l,3),tau(1,3));
    end
    
    % Menghitung fungsi pdf dari sigma yang ada
    % Kelas 0
    prob(i,1) = hitungpdf(tau(1,1), size(kelas0,1), k0);
    % Kelas 1
    prob(i,2) = hitungpdf(tau(1,2), size(kelas1,1), k1);
    % Kelas 2
    prob(i,3) = hitungpdf(tau(1,3), size(kelas2,1), k2);
    
    % Mencari nilai maksimal dari ketiga kelas yang ada
    prob(i,4) = max(prob(i,:));
    
    % Mengelompokkan nilai maksimal ke kelas dimana ia berada
    if (prob(i,4) == prob(i,1))
        prob(i,5) = 0;
    elseif (prob(i,4) == prob(i,2))
        prob(i,5) = 1;
    elseif (prob(i,4) == prob(i,3))
        prob(i,5) = 2;
    end
    
    % Memasukkan kelas baru ke data testing
    datatesting(i,4) = prob(i,5);
    k0 = 0; k1 = 0; k2 = 0;
end

% Mengelompokkan atribut data testing pada masing-masing kelas
a = 1; b = 1; c = 1;
for i = 1 : size(datatesting,1)
    % Mengelompokkan atribut data testing  pada kelas 0
    if datatesting(i,4) == 0
        tkelas0(a,1) = datatesting(i,1);
        tkelas0(a,2) = datatesting(i,2);
        tkelas0(a,3) = datatesting(i,3);
        a = a + 1;
    % Mengelompokkan atribut data testing  pada kelas 1
    elseif datatesting(i,4) == 1
        tkelas1(b,1) = datatesting(i,1);
        tkelas1(b,2) = datatesting(i,2);
        tkelas1(b,3) = datatesting(i,3);
        b = b + 1;
    % Mengelompokkan atribut data testing  pada kelas 2
    elseif datatesting(i,4) == 2
        tkelas2(c,1) = datatesting(i,1);
        tkelas2(c,2) = datatesting(i,2);
        tkelas2(c,3) = datatesting(i,3);
        c = c + 1;
    end
end

% visualisasi 3D scatter plot tanpa data testing (data training saja)
figure; hold on;
scatter3(kelas0(:,1),kelas0(:,2),kelas0(:,3),'r','filled');
scatter3(kelas1(:,1),kelas1(:,2),kelas1(:,3),'g','filled');
scatter3(kelas2(:,1),kelas2(:,2),kelas2(:,3),'b','filled');
legend('kelas 0 Train','kelas 1 Train','kelas 2 Train');
hold off;

% visualisasi 3D scatter plot dengan data testing dan data training
figure; hold on;
scatter3(kelas0(:,1),kelas0(:,2),kelas0(:,3),'r','filled');
scatter3(kelas1(:,1),kelas1(:,2),kelas1(:,3),'g','filled');
scatter3(kelas2(:,1),kelas2(:,2),kelas2(:,3),'b','filled');
scatter3(tkelas0(:,1),tkelas0(:,2),tkelas0(:,3),'MarkerEdgeColor','k','MarkerFaceColor','r','LineWidth',1)
scatter3(tkelas1(:,1),tkelas1(:,2),tkelas1(:,3),'MarkerEdgeColor','k','MarkerFaceColor','b','LineWidth',1)
scatter3(tkelas2(:,1),tkelas2(:,2),tkelas2(:,3),'MarkerEdgeColor','k','MarkerFaceColor','g','LineWidth',1)
legend('kelas 0 Train','kelas 1 Train','kelas 2 Train','Testing Termasuk kelas 0','Testing Termasuk kelas 1','Testing Termasuk kelas 2')
hold off;


% Write data testing yang sudah ada labelnya ke prediksi.txt
fileID = fopen('prediksi.txt','w');
fprintf(fileID,'%6s %6s %6s %6s\r\n','att1','att2','att3','label');
fprintf(fileID,'%3.9f %3.9f %3.9f %1i\r\n',datatesting');
fclose(fileID);

% Output data testing
datatesting