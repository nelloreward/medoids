%two separated balls
numSims = 1000;
recoveries = [];
for d=[2,3,4,10]
    for nPerBall=5:5:30
        for R=2:.2:5
            numIntegerRecoveries=0;
            numBallRecoveries=0;
            for i=1:numSims
                firstBall=randsphere_r2_dist(nPerBall,d,1);
                secondBall=randsphere_r2_dist(nPerBall,d,1);
                secondBall(:,1)=secondBall(:,1) + R;
                pts=[firstBall; secondBall];
                sol=getmeds(sqdistance(pts'),2);
                thresh=reshape(sol.x,nPerBall*2,nPerBall*2)'>.0001;
                if size(unique(thresh, 'rows'),1)==2
                    numIntegerRecoveries = numIntegerRecoveries + 1;
                end
                if size(unique(thresh(1:nPerBall,:), 'rows'), 1)==1 & size(unique(thresh(nPerBall+1:nPerBall*2,:), 'rows'), 1)==1
                    numBallRecoveries = numBallRecoveries + 1;
                end
            end
            recoveries = [recoveries; d nPerBall R numIntegerRecoveries numBallRecoveries];
        end
    end
end