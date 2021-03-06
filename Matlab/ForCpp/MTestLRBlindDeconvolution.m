function MTestLRMatrixCompletion()
    seed = floor(rand() * 100000);
    seed = 2;
    fprintf('MTestLRMatrixCompletion seed:%d\n', seed);
    rand('state', seed);
    randn('state', seed);
    L = 200;
    K = 10;
    N = 8;
    r = 1;
    
    idx2 = randperm(L);
    idx2 = idx2(1:K);
    Breal = speye(L);
    Breal = Breal(:,idx2);
    B = sparse(2 * L, K);
    B(1:2:end, :) = Breal;
    
%     B = randn(2 * L, K);
    C = randn(2 * L, N);
    y = randn(2 * L, 1);
    
    [U, D, V] = svds(randn(K, N), r);
    Xinitial = [U(:); D(:); V(:)];
    
    SolverParams.method = 'LRBFGS';
%     SolverParams.method = 'RTRSR1';
%     SolverParams.method = 'RTRNewton';
    SolverParams.IsCheckParams = 0;
    SolverParams.Max_Iteration = 1000;
    SolverParams.OutputGap = 200;
    SolverParams.LengthSY = 4;
    SolverParams.DEBUG = 3;
    HasHHR = 0;
    [Xopt, f, gf, gfgf0, iter, nf, ng, nR, nV, nVp, nH, ComTime, funs, grads, times, dists, eigvs] = TestLRBlindDeconvolution(y, B, C, Xinitial, r, HasHHR, SolverParams);
%     eigvs
end
