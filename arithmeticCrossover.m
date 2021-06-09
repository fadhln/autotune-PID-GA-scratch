function [children] = arithmeticCrossover(parent1, parent2)
    alpha = rand;
    child1 = alpha*parent1 + (1-alpha)*parent2;
    child2 = (1-alpha)*parent1 + alpha*parent2;
    children = [child1; child2];
end

