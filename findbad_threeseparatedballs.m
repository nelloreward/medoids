%three separated balls
R=2.5;
nPerBall=15;
while 1
    firstBall=randsphere(nPerBall,2,1);
    secondBall=randsphere(nPerBall,2,1);
    thirdBall=randsphere(nPerBall,2,1);
    secondBall(:,1)=secondBall(:,1) + R;
    thirdBall(:,1)=thirdBall(:,1) + R/2;
    thirdBall(:,2)=thirdBall(:,2) + R*sqrt(3)/2;
    pts=[firstBall; secondBall; thirdBall];
    sol=getmeds(sqdistance(pts'),3);
    thresh=reshape(sol.x,nPerBall*3,nPerBall*3)'>.0001;
    if ~(size(unique(thresh(1:nPerBall,:), 'rows'), 1)==1 & size(unique(thresh(nPerBall+1:nPerBall*2,:), 'rows'), 1)==1 & size(unique(thresh(nPerBall*2+1:nPerBall*3,:), 'rows'), 1)==1)
        break;
    end
end