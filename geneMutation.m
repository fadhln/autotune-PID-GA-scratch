function [child] = geneMutation(parent, mutRate, LB, UB)
    nVars = numel(parent);
    nmu = ceil(mutRate * nVars);
    j = randsample(nVars, 1);
    child = parent;
    child(j) = parent(j) - rand*parent(j);
end

