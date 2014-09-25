%
% This function performs validation of whole kCSD
% it generates point csd and potential from 5 point charges in random locations
% and then compares the result with reconstructed CSD
%
% csd_example->generated potential->reconstructed_csd 
%
% All computations are for cube=[0,1]^3 and point charges q=1
% 
function kcsdValidate(visual=0)
  params = [1/8,1.0];
  sigma = 1/8;

  % UTIL FUNTIONS DEFINITON
  

  % DEFINING GRID
  % preparing input for kCSD
  % grid of base functions 8x8x8
  n=10;
  t=linspace(-0.2,1.2,n);
  [xx,yy]=meshgrid(t,t);
  base_grid=[];
  X=reshape(xx,1,n^2); 
  Y=reshape(yy,1,n^2); 
  for z=t;
    Z=z*ones(1,n^2);
    base_grid=[base_grid, [X;Y; Z]];
  end
  
  % preparing grid for output for comparision of both pictures
  m=8;
  t=linspace(0,1,m);
  [xx,yy]=meshgrid(t,t);
  out_grid=[];
  X=reshape(xx,1,m^2); 
  Y=reshape(yy,1,m^2); 
  for z=t;
    Z=z*ones(1,m^2);
    out_grid=[out_grid, [X;Y;Z]];
  end
  % grid for visualistaion of potential 
  [X3,Y3,Z3]=meshgrid(t,t,t);
  % END OF GRID DEFINITION


  % DEFINITION OF CSD AND POTENTIAL
  %
  % definition of current (list of gassian charges centers)
  pos_ind=randi(m,3,1);
  csd3d = zeros(m,m,m);
  V3d = zeros(m,m,m);

  for ind=pos_ind
    p = (pos_ind/m);
    r2=(X3-p(1)).^2 + (Y3-p(2)).^2 + (Z3-p(3)).^2;
    r2=0.5*r2/(sigma^2);
    csd3d=csd3d + exp(-r2)/(sqrt(2*pi*sigma^2)^3);
    % potential
    V3d=V3d + erf(sqrt(r2))./ (4*pi*params(2)*sqrt(sqrt(r2+eps)) );
  end
  maxC=max(max(max(csd3d)));
  maxV=max(max(max(V3d)));
  % corresponding potential
  % positions of electrodes (15 of them) and points to calculate potential
  src_grid=rand(3,int32(0.5*n^3));
     
  % calculate potential in ele_pos positions (lame code but still)
  V=[];
  for x=src_grid
    temp= interp3(X3,Y3,Z3,V3d, x(1),x(2),x(3));
    V=[V;temp];
  end



  % RECONSTRUCTION
  obj = kcsd(params, src_grid, out_grid, base_grid, V);
  obj = estimate(obj)
  CSDr = obj.CSD;
  maxCSDr= max(CSDr)
  CSDr = reshape(CSDr,m,m,m);
 


  % PLOTTING
  %
  % FIGURE 1: base functions, electrodes, charges
  figure(1); 
  h=plot3(base_grid(1,:),base_grid(2,:),base_grid(3,:),'.',
    pos_ind(1,:)/m, pos_ind(2,:)/m, pos_ind(3,:)/m,'o',
    src_grid(1,:), src_grid(2,:), src_grid(3,:), 'x'
  );
  set(h,'linewidth',3);
  %hold on
  legend('Base function centers', 'charges', 'measures');
  xlabel('X');
  ylabel('Y');
  zlabel('Z');


  % FIGURE 2++:
  [~,~,Nz]=size(CSDr);
  view_size=ceil(sqrt(Nz));
  for ind=(1:Nz)
    figure(2);
    subplot(view_size, view_size, ind);
    %imagesc(CSD_r(:,:,ind) ),shading('flat');
    imagesc(V3d(:,:,ind),[0,maxV] ),shading('flat');
    title(strcat('z=', num2str(ind/m)) );
    figure(3);
    subplot(view_size, view_size, ind);
    imagesc(csd3d(:,:,ind),[0,maxC] ), shading('flat');
    title(strcat('z=', num2str(ind/m)) );
    figure(4)
    subplot(view_size, view_size, ind);
    imagesc(CSDr(:,:,ind),[0,maxC] ), shading('flat');
    title(strcat('z=', num2str(ind/m)) );
  end
  colorbar();
  figure(3) 
  colorbar();
  figure(2) 
  colorbar();
  %mini=min(min(CSD_r))
  %maxi=max(max(CSD_r))-mini;
  %figure(3)
  %hist(CSD_r,20)

  % end of 3D case
  % plotting for human comparision
  %refresh()
  %figure(1)
  %isosurface(X3,Y3,Z3,val,0.5);
  %hold on
  %plot3(positions(1,:),positions(2,:),positions(3,:),'.');
  %hold off
  %figure(2)
  %isosurface(X3,Y3,Z3,CSD_r,15);
  %hold on
  %plot3(positions(1,:),positions(2,:),positions(3,:),'.');
  %hold off
end