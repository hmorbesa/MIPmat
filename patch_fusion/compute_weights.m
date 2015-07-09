
function [w]=compute_weights(BTH,Aph,rho)

opts=[];
% Starting point
opts.init=2;        % starting from a zero point
opts.tFlag=5;       % run .maxIter iterations
opts.maxIter=100;   % maximum number of iterations
% normalization
opts.nFlag=0;       % without normalization
% regularization
opts.rFlag=1;       % the input parameter 'rho' is a ratio in (0, 1)
%opts.rsL2=0.01; 

[w, funVal]= nnLeastR(BTH, Aph, rho, opts);


