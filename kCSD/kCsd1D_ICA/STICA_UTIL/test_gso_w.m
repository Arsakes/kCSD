n=3;a=randn(n,3);a(:,3)=0;% Make cols of a orthog.b=gso(a); c=randn(n,1);d=gso_w(b,c);bdd'*b  % should be [0 0 0]