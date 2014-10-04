%
% This function performs validation of whole kCSD
% it generates point csd and potential from 5 point charges in random locations
% and then compares the result with reconstructed CSD
%
% csd->generated potential->reconstructed_csd
%
% All computations are performed for cube = [0,1]^3
% 
% parameters: plotElectrodes = 1 or 0
%
function kcsdValidate3D(plotElectrodes)
  sigma = 1.2/9;
  params = [sigma,1.0];

  % UTIL FUNCTIONS DEFINITON
  

  % DEFINING GRID
  % preparing input for kCSD
  % grid of base functions 8x8x8
  n=10;
  t=linspace(-0.1,1.1,n);
  [xx,yy]=meshgrid(t,t);
  base_grid=[];
  X=reshape(xx,n^2,1); 
  Y=reshape(yy,n^2,1); 
  for z=t;
    Z=z*ones(1,n^2);
    base_grid=[base_grid; [X,Y, Z]];
  end
  
  % preparing grid for output for comparision of both pictures
  m=32;
  t=linspace(0,1,m);
  [xx,yy]=meshgrid(t,t);
  out_grid=[];
  X=reshape(xx,m^2,1); 
  Y=reshape(yy,m^2,1); 
  for z=t;
    Z=z*ones(1,m^2);
    out_grid=[out_grid, [X;Y;Z]];
  end
  % grid for visualistaion of potential 
  [X3,Y3,Z3]=meshgrid(t,t,t);

  % grid for measurements
  l=8;
  t=linspace(0,1,l);
  [xx,yy]=meshgrid(t,t);
  src_grid=[];
  X=reshape(xx,l^2,1); 
  Y=reshape(yy,l^2,1); 
  for z=t;
    Z=z*ones(1,l^2);
    src_grid=[src_grid, [X;Y;Z]];
  end

  % END OF GRID DEFINITION


  % DEFINITION OF CSD AND POTENTIAL
  %
  % definition of current (list of gassian charges centers)
  pos_ind=randi(m,3,2)
  csd3d = zeros(m,m,m);
  V3d = zeros(m,m,m);

  for ind=pos_ind
    p = 0.05 + 0.9*(ind/m);
    r2=(X3-p(1)).^2 + (Y3-p(2)).^2 + (Z3-p(3)).^2;
    r2=0.5*r2/(sigma^2);
    csd3d=csd3d + exp(-r2)/(sqrt(2*pi*sigma^2)^3);
    % potential
    V3d=V3d + erf(sqrt(r2))./ (4*pi*params(2)*sqrt(2*sigma^2 *r2+eps) );
  end
  % maximal and minimal value for colours
  maxC=max(max(max(csd3d)));
  minC=min(min(min(csd3d)));
  maxV=max(max(max(V3d)));


  % CALCULATION OF POTENTIAL IN ELECTRODE POSITIONS
  %
  V=[];
  for x=src_grid
    temp= interp3(X3,Y3,Z3,V3d, x(1),x(2),x(3));
    V=[V;temp];
  end



  % RECONSTRUCTION
  obj = kcsd(src_grid, out_grid, base_grid, V, sigma, 'cvON', 0);
  obj = estimate(obj);
  CSDr = obj.CSD;
  maxCSDr= max(CSDr);
  minCSDr= min(CSDr);
  CSDr = reshape(CSDr,m,m,m);
 


  % PLOTTING

  [~,~,Nz]=size(CSDr);
  view_size=3;
  X2=X3(:,:,1);
  Y2=Y3(:,:,1);
  dz=1/m;

  
  for ind=1:9
    i=ceil(ind*Nz/9);
  
    figure(3);
    subplot(view_size, view_size, ind);
    pcolor(X2,Y2, csd3d(:,:,i) ), shading('interp');
    caxis([minC,maxC] );
    title(strcat('z=', num2str(i/m)) );
  
    figure(4)
    subplot(view_size, view_size, ind);
    pcolor(X2,Y2, CSDr(:,:,i)), shading('interp');
    caxis([minCSDr,maxCSDr] );
    title(strcat('z=', num2str(i/m)) );
    % plotting circles for sources
    hold on
      % find nearby potential sources
      [~,el2plt] = find( abs(src_grid(3,:) - i/m) < 0.45*dz);
      plot( src_grid(1,el2plt), src_grid(2,el2plt), 'o');
    %hold off
  end

end
