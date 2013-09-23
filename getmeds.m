function X = getmeds(P, K)
    try
        npts = size(P,1);
        clear model;
        model.obj = reshape(P,1,[]);
        model.rhs = [];
        vals = [];
        rowindices = [];
        colindices = [];
        %sum_j xij = 1
        for i=1:npts
            for j=1:npts
                vals = [vals; 1];
                rowindices = [rowindices; i];
                colindices = [colindices; j+(i-1)*npts];
            end
            model.rhs = [model.rhs; 1];
        end
        %xij<=xjj
        currentrow = npts + 1;
        for i=1:npts
            for j=1:npts
                if i ~= j
                    vals = [vals; 1; -1];
                    rowindices = [rowindices; currentrow; currentrow];
                    colindices = [colindices; (i-1)*npts+j; (j-1)*npts+j];
                    model.rhs = [model.rhs; 0];
                    currentrow = currentrow + 1; 
                end
            end
        end
        %sum_j xjj<=k
        for i=1:npts
            vals = [vals; 1];
            rowindices = [rowindices; currentrow];
            colindices = [colindices; (i-1)*npts+i];
        end
        model.rhs = [model.rhs; K];
        model.sense = zeros(1,currentrow);
        model.sense(1:npts) = '=';
        model.sense(npts+1:currentrow) = '<';
        model.sense = char(model.sense);
        model.A = sparse(rowindices,colindices,vals,currentrow,npts^2);
        params.method = 2;
        params.crossover = 0;
        X = gurobi(model,params);
    catch gurobiError
        fprintf('Error reported\n');
        X = gurobiError;
    end
end