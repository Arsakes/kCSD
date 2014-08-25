function  testAll()
% 
% Test diagonali: diagonala kernela powinna być
% sumą kwadratów funkcji bazowych 
% dla ustalonej siatki funkcji bazowych wiadomo jak to z grubsza 
% powinno wyglądać
%

params = [1/16,1];


% przygotowywanie siatki bazowej (tj. funkcji bazowych)
% siatka jest 8x8 dwuwymiarowa
n=16
t=linspace(0,1,n);
[xx,yy]=meshgrid(t,t);
base=[reshape(xx,1,n^2); reshape(yy,1,n^2); zeros(1,n^2)];
base=[base,[base(1,:);base(2,:); base(3,:)+1 ] ];
% siatka bazowa base zdefiniowana

% siatka próbkowania
m=32;
t=linspace(0,1,m);
[xx,yy]=meshgrid(t,t);
probing_grid=[reshape(xx,1,m^2); reshape(yy,1,m^2); zeros(1,m^2)];



% siatka wyjścia, m-elementów? obszar [0,1]x[0,1]x[0]
l=32;
t=linspace(0,1,l);
[xxl,yyl]=meshgrid(t,t);
out_grid=[reshape(xxl,1,l^2); reshape(yyl,1,l^2); zeros(1,l^2)];


klasa = kcsd(params, probing_grid, out_grid, base, V = 1);
% there could be if case FUCKING PASSING THROUGH VALUE!

% speed test
klasa.updateList
klasa=recalcKernels(klasa);
klasa.updateList
klasa=recalcKernels(klasa);
klasa.updateList

figure(1)
mesh(xx, yy, reshape(diag(klasa.kernel), m,m)),shading('interp');
title('Diagnonala kernela')


end