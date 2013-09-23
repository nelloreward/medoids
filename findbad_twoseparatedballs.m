%two separated balls
R=2.5;
nPerBall=15;
while 1
    firstBall=randsphere(nPerBall,2,1); 
    secondBall=randsphere(nPerBall,2,1);
    secondBall(:,1)=secondBall(:,1) + R;
    pts=[firstBall; secondBall];
    sol=getmeds(sqdistance(pts'),2);
    thresh=reshape(sol.x,nPerBall*2,nPerBall*2)'>.0001;
    if ~(size(unique(thresh(1:nPerBall,:), 'rows'), 1)==1 & size(unique(thresh(nPerBall+1:nPerBall*2,:), 'rows'), 1)==1)
        break;
    end
end