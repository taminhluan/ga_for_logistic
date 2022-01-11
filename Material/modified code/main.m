clear
tic
 global noOfCustomers
 global noOfVehicles
 global distance
 global demand
 global timeWindow
 global travelTime
 global capacity
load(fullfile(tempdir, 'customers.mat'),'noOfCustomers','noOfVehicles','distance','demand','timeWindow','travelTime','capacity');


fprintf('Instance info: \n');
fprintf('- Number of customer is %2.0f\n', noOfCustomers);
fprintf('- Number of vehicles is %2.0f\n', noOfVehicles);
pop = input('Enter number of individuals in a population: ');
convergLimit = input('Enter convergence limit: ');
chromLength = noOfCustomers + noOfVehicles - 1;
solutionArray = zeros(1,chromLength);

TC = 999999999999999;
TD = 0;
mutationProba = 0.3;
% Two best individuals
S1 = zeros(1, chromLength + 1);
S2 = zeros(1, chromLength + 1);
% Two worst individuals
W1 = zeros(1, chromLength + 1);
W2 = zeros(1, chromLength + 1);
initialPop = zeros(pop, chromLength + 1);
offsprings = zeros(2, chromLength + 1);
% GENERATE INITIAL POPULATION (Generation 1)
for i = 1:pop
 initialPop(i,1:chromLength) = randperm(chromLength);
initialPop(i,chromLength + 1) = fitness(initialPop(i,1:chromLength));
 while initialPop(i,chromLength + 1) > 99999999999999
 initialPop(i,1:chromLength) = randperm(chromLength);
 initialPop(i,chromLength + 1) = fitness(initialPop(i,1:chromLength));
 end
end
gen = 1;
convergCount = 0;
% BIG LOOP
while convergCount < convergLimit
 bestTC(:,:,gen) = min(initialPop(:, chromLength + 1, gen));
 for i = 1:pop
 if initialPop(i, chromLength + 1, gen) == bestTC(:,:,gen)
 bestSolution(:,:,gen) = initialPop(i, 1:chromLength, gen);
 end
 end
 if bestTC(:,:,gen) < TC
 TC = bestTC(:,:,gen);
 solutionArray = bestSolution(:,:,gen);
 end
 if bestTC(:,:,gen) >= min(bestTC(:,:,1:gen-1))
 convergCount = convergCount + 1;
 else
 convergCount = 0;
 end
 
 % Selecting parents
 best = mink(initialPop(:,chromLength + 1, gen),2);
 for i = 1:pop
 if initialPop(i, chromLength + 1, gen) == best(1) || initialPop(i, chromLength + 1, gen) == best(2)
 S1(1,:,gen) = initialPop(i,:, gen);
 for j = i+1:pop
 if initialPop(j, chromLength + 1, gen) == best(1) || initialPop(j, chromLength + 1, gen) == best(2)
 S2(1,:,gen) = initialPop(j,:, gen);
break
 end
 end
 break
 end
 end
 worst = maxk(initialPop(:,chromLength + 1, gen),2);
 for i = 1:pop
 if initialPop(i, chromLength + 1, gen) == worst(1) || initialPop(i, chromLength + 1, gen) == worst(2)
 W1(1,:,gen) = initialPop(i,:, gen);
 for j = i+1:pop
 if initialPop(j, chromLength + 1, gen) == worst(1) || initialPop(j, chromLength + 1, gen) == worst(2)
 W2(1,:,gen) = initialPop(j,:, gen);
break
 end
 end
 break
 end
 end
 % Crossover: choose a random crossover method. If offspring = parent, use another method
 coMethod(gen) = rand;
 if coMethod < 0.5
 [offsprings(1,1:chromLength,gen), offsprings(2,1:chromLength,gen)] = crossover1(S1(1,1:chromLength,gen),S2(1,1:chromLength,gen));
 offsprings(1,chromLength + 1,gen) = fitness(offsprings(1,1:chromLength,gen));
 offsprings(2,chromLength + 1,gen) = fitness(offsprings(2,1:chromLength,gen));
 if isequal(offsprings(1,:,gen), S1(1,:,gen)) == 1 || isequal(offsprings(1,:,gen),S2(1,:,gen)) == 1
 [offsprings(1,1:chromLength,gen), offsprings(2,1:chromLength,gen)] = crossover2(S1(1,1:chromLength,gen),S2(1,1:chromLength,gen));
 offsprings(1,chromLength + 1,gen) = fitness(offsprings(1,1:chromLength,gen));
 offsprings(2,chromLength + 1,gen) = fitness(offsprings(2,1:chromLength,gen));
 end
 else
 [offsprings(1,1:chromLength,gen), offsprings(2,1:chromLength,gen)] = crossover2(S1(1,1:chromLength,gen),S2(1,1:chromLength,gen));
 offsprings(1,chromLength + 1,gen) = fitness(offsprings(1,1:chromLength,gen));
 offsprings(2,chromLength + 1,gen) = fitness(offsprings(2,1:chromLength,gen));
 if isequal(offsprings(1,:,gen), S1(1,:,gen)) == 1 || isequal(offsprings(1,:,gen),S2(1,:,gen)) == 1
[offsprings(1,1:chromLength,gen), offsprings(2,1:chromLength,gen)] = crossover1(S1(1,1:chromLength,gen),S2(1,1:chromLength,gen));
 offsprings(1,chromLength + 1,gen) = fitness(offsprings(1,1:chromLength,gen));
 offsprings(2,chromLength + 1,gen) = fitness(offsprings(2,1:chromLength,gen));
 end
 end
 % Replace the 2 worst individual with new offspring, create new 
generation
 gen = gen + 1;
 initialPop(:,:,gen) = initialPop(:,:,gen - 1);
 for i = 1:pop
 if initialPop(i, chromLength + 1, gen) == worst(1) || initialPop(i, chromLength + 1, gen) == worst(2)
 initialPop(i,:, gen) = offsprings(1,:,gen - 1);
 for j = i+1:pop
 if initialPop(j, chromLength + 1, gen) == worst(1) || initialPop(j, chromLength + 1, gen) == worst(2)
 initialPop(j,:, gen) = offsprings(2,:,gen - 1);
 break
 end
 end
 break
 end
 end
 % Mutation
 mutant(:,:,1) = 0;
 if rand < mutationProba
 mutant(:,:,gen) = ceil(1 + rand*(pop - 1));
 while mutant(:,:,gen) == findIndex(transpose(initialPop(:,chromLength + 1,gen)),fitness(solutionArray))
 mutant(:,:,gen) = ceil(1 + rand*(pop - 1));
 end
 initialPop(mutant(:,:,gen), 1:chromLength, gen) = mutation(initialPop(mutant(:,:,gen), 1:chromLength, gen));
 initialPop(mutant(:,:,gen), chromLength + 1, gen) = fitness(initialPop(mutant(:,:,gen), 1:chromLength, gen));
 else
 mutant(:,:,gen) = 0;
 end
 
end
% SOLUTION ANALYSIS 
 breakPoint = 0;
 index = 1;
 % Assign name and route
 for m = 1:length(solutionArray)
 if solutionArray(m) > noOfCustomers
 vehicleRoutes(index).Name = strcat('Vehicle ', num2str(index));
 vehicleRoutes(index).Nodes = solutionArray(breakPoint + 1 :m-1);
 breakPoint = m;
 index = index + 1;
 end
 if m == length(solutionArray)
 vehicleRoutes(index).Name = strcat('Vehicle ', num2str(index));
 vehicleRoutes(index).Nodes = solutionArray(breakPoint + 1 : m);
 end
 end
 
 for i = 1:noOfVehicles
 if isempty(vehicleRoutes(i).Nodes) == 1
 continue
 end
 
 % Assign starting time + departure time + arrival time
 for j = 1 : length(vehicleRoutes(i).Nodes)
 % Beginning
 if j == 1
 vehicleRoutes(i).startingTime = 0;
 vehicleRoutes(i).departureTime(1) = vehicleRoutes(i).startingTime;
 vehicleRoutes(i).arrivalTime(1) = vehicleRoutes(i).startingTime + travelTime(1 , vehicleRoutes(i).Nodes(1)+ 1);
 else
 vehicleRoutes(i).departureTime(j) = max(timeWindow(vehicleRoutes(i).Nodes(j-1),1),...vehicleRoutes(i).arrivalTime(j-1));
 vehicleRoutes(i).arrivalTime(j) == vehicleRoutes(i).departureTime(j) + travelTime(vehicleRoutes(i).Nodes(j1) + 1,vehicleRoutes(i).Nodes(j) + 1));
 end
 
 % Return to depot
 if j == length(vehicleRoutes(i).Nodes)
 vehicleRoutes(i).departureTime(j+1) = max(timeWindow(vehicleRoutes(i).Nodes(j),1),...vehicleRoutes(i).arrivalTime(j));
 vehicleRoutes(i).arrivalTime(j+1) == vehicleRoutes(i).departureTime(j+1) + travelTime(vehicleRoutes(i).Nodes(j) + 1, 1));
 end
 end
 
 % Assign carried load before each nodes
 vehicleRoutes(i).carriedLoad(1) = 0;
 for j = 1:length(vehicleRoutes(i).Nodes)
 vehicleRoutes(i).carriedLoad(1) = vehicleRoutes(i).carriedLoad(1) + demand(vehicleRoutes(i).Nodes(j),1);
 end
 
 for j = 2:length(vehicleRoutes(i).Nodes)+1

 vehicleRoutes(i).carriedLoad(j) = vehicleRoutes(i).carriedLoad(j-1) - demand(vehicleRoutes(i).Nodes(j-1),1);
 end 
 
 % Assign distance traveled
 for j = 1:length(vehicleRoutes(i).Nodes) + 1
 if j == 1 
 vehicleRoutes(i).distanceTraveled(j) = distance(1, vehicleRoutes(i).Nodes(j) + 1);
 continue
 elseif j == length(vehicleRoutes(i).Nodes) + 1
 vehicleRoutes(i).distanceTraveled(j) = distance(vehicleRoutes(i).Nodes(j-1) + 1, 1);
 continue
 else
 vehicleRoutes(i).distanceTraveled(j) = distance(vehicleRoutes(i).Nodes(j-1) +1, vehicleRoutes(i).Nodes(j) +1);
 end
 end
 a = 0;
b = 0;
for i = 1:size(bestSolution,3)
a(i,1) = fitness(bestSolution(:,:,i));
end
figure
plot(a, 'LineWidth', 1)
 
 % Assign travel time
 for j = 1:length(vehicleRoutes(i).departureTime)
 vehicleRoutes(i).timeTraveled(j) = vehicleRoutes(i).arrivalTime(j) - vehicleRoutes(i).departureTime(j);
 end
 end
toc
%plot result
fprintf('Total distance traveled (in km) is %4.2f\n', TC);
disp('For more detailed solution, inspect the variable "vehicleRoutes"');
a = 0;
b = 0;
for i = 1:size(bestSolution,3)
a(i,1) = fitness(bestSolution(:,:,i));
end
figure
plot(a, 'LineWidth', 1)
