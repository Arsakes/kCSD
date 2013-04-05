function D = calc_distance_matrix(Scp, Tcp)


disp('Calculating distance matrix...')

DS = zeros(size(Tcp,1)); % spatial distance
DT = zeros(size(Tcp,1)); % temporal distance

for ii=1:size(Tcp,1)-1
    for jj=ii:size(Tcp,1)
        T1 = Tcp(ii,:);
        T2 = Tcp(jj,:);
        S1 = Scp(ii,:);
        S2 = Scp(jj,:);
        mT1 = max(abs(T1));
        mT2 = max(abs(T2));
%         if not(max(abs(T1))==mT1)
%             T1 = -T1;
%             mT1 = max(T1);
%             S1 = -S1;
%         end;
%         if not(max(abs(T2))==mT2)
%             T2 = -T2;
%             mT2 = max(T2);
%             S2 = -S2;
%         end;

%         T1 = T1/mT1;
%         T2 = T2/mT2;
%         S1 = S1*mT1;
%         S2 = S2*mT2;
        distS = sum((S1-S2).^2);
        distS2 = sum((S1+S2).^2);
        distT = sum((T1-T2).^2);
        distT2 = sum((T1+T2).^2);
        DS(ii,jj) = min(distS, distS2);
        DS(jj,ii) = DS(ii,jj);
        DT(ii,jj) = min(distT, distT2);
        DT(jj,ii) = DT(ii,jj);
    end;
end;

D = DS/mean(DS(:)) + DT/mean(DT(:));
