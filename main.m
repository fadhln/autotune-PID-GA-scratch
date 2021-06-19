clc; clear; close all;

%% Define system
[plant_d, desired, Ts] = defineSys();

%% Params of GA
% Define Lower Bound (LB) and Upper Bound (UB)
LB = [0 0 0];
UB = [5 5 5];
nVars = 3;

% Max number of generation
generation = 200;
populationSize = 50;

% Initialize population
population = zeros(populationSize, nVars);
tempPopulation = zeros(populationSize, nVars);
mutRate = 0.1;

sPopulation = zeros(populationSize, nVars+1);
F = zeros(populationSize, 1);
crossoverTimes = 4;
mutationTimes = 5;

for i=1:1:populationSize
    for n=1:1:nVars
        % Assign random number for population
        population(i, n) = unifrnd(LB(1,n), UB(1,n));
    end
    F(i) = fitness(population(1,:), plant_d, Ts, desired);
end

% Sorting of the population
sPopulation(:, 1:nVars) = population(:,:);
sPopulation(:, nVars+1) = F;
sPopulation = sortrows(sPopulation, nVars+1);

%% Selection and Crossover
% Generation
for ii=1:1:generation
    
    txt = sprintf('Iterating %d from %d generation', ii, generation);
    disp(txt);
    
    k=1;
    
    % Elitism
    tempPopulation(k, 1:nVars) = sPopulation(1,1:nVars);
    k=k+1;

    % Parent Selection
    for j=1:1:crossoverTimes
        y1(j) = geornd(0.1)+1;
        while y1(j) > populationSize
            y1(j) = geornd(0.1)+1;
        end
        y2(j) = geornd(0.1)+1;
        while y2(j) > populationSize
            y2(j) = geornd(0.1)+1;
        end
    end

    % Arithmetic Crossover
    for u=1:1:crossoverTimes
        parent1 = sPopulation(y1(u), 1:nVars);
        parent2 = sPopulation(y2(u), 1:nVars);
    
        [children] = arithmeticCrossover(parent1, parent2);
        tempPopulation(k, 1:nVars) = children(1,:);
        
        tempPopulation(k, 1:nVars) = max(tempPopulation(k, 1:nVars), LB);
        tempPopulation(k, 1:nVars) = min(tempPopulation(k, 1:nVars), UB);
        
        k=k+1;
        tempPopulation(k, 1:nVars) = children(2,:);
        
        tempPopulation(k, 1:nVars) = max(tempPopulation(k, 1:nVars), LB);
        tempPopulation(k, 1:nVars) = min(tempPopulation(k, 1:nVars), UB);
        
        k=k+1;
    end
    
    % Mutation
    for e=1:1:mutationTimes
        parent = sPopulation(unidrnd(populationSize), 1:nVars);
        [child] = geneMutation(parent, mutRate, LB, UB);
        
        tempPopulation(k, 1:nVars) = child;
        tempPopulation(k, 1:nVars) = max(tempPopulation(k, 1:nVars), LB);
        tempPopulation(k, 1:nVars) = min(tempPopulation(k, 1:nVars), UB);
        k = k+1;
    end
    
    % Replication
    for k=k:1:populationSize
        replicatedChild = sPopulation(randi([1 populationSize]), 1:nVars);
        tempPopulation(k, 1:nVars) = replicatedChild;
        k = k+1;
    end
    
    % Calculate fitness Function
    for iii=1:1:populationSize
        F(iii) = fitness(tempPopulation(iii,:), plant_d, Ts, desired);
    end
    
    % Sorting for next generation
    sPopulation(:, 1:nVars) = tempPopulation;
    sPopulation(:, nVars+1) = F(:,:);
    sPopulation = sortrows(sPopulation, nVars+1);
    
    bestF(ii) = sPopulation(1, nVars+1);
end

figure(1);
plot(bestF, 'b');
xlabel('Generation');
ylabel('Best Value');
grid on

%% Simulation of best Chromosome
Xmin = sPopulation(1,1:nVars)
Fval = bestF(1, generation);

c = pid(Xmin(1), Xmin(2), Xmin(3), 0, Ts);
system = feedback(series(c, plant_d),1);
figure(2)
step(system)
stepinfo(system)