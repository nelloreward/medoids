%three separated balls
numSims = 1000;
recoveries = [];
for d=[2,3,4,10]
    for nPerBall=5:5:30
        for R=2:.2:5
            numIntegerRecoveries=0;
            numBallRecoveries=0;
            for i=1:numSims
                firstBall=randsphere(nPerBall,d,1);
                secondBall=randsphere(nPerBall,d,1);
                thirdBall=randsphere(nPerBall,d,1);
                secondBall(:,1)=secondBall(:,1) + R;
                thirdBall(:,1)=thirdBall(:,1) + R/2;
                thirdBall(:,2)=thirdBall(:,2) + R*sqrt(3)/2;
                pts=[firstBall; secondBall; thirdBall];
                sol=getmeds(sqdistance(pts'),3);
                thresh=reshape(sol.x,nPerBall*3,nPerBall*3)'>.0001;
                if size(unique(thresh, 'rows'),1)==3
                    numIntegerRecoveries = numIntegerRecoveries + 1;
                end
                if size(unique(thresh(1:nPerBall,:), 'rows'), 1)==1 & size(unique(thresh(nPerBall+1:nPerBall*2,:), 'rows'), 1)==1 & size(unique(thresh(nPerBall*2+1:nPerBall*3,:), 'rows'), 1)==1
                    numBallRecoveries = numBallRecoveries + 1;
                end
            end
            recoveries = [recoveries; d nPerBall R numIntegerRecoveries numBallRecoveries];
        end
    end
end