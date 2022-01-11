function fitnessScore = fitness(solutionArray)
 global noOfCustomers
 global distance
 global travelTime
 global demand
 global timeWindow
 global capacity
 
 breakPoint = 0;
 index = 1;

 noOfVehicles = length(solutionArray) - noOfCustomers + 1;
 
% Solution analysis 
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
 vehicleRoutes(i).arrivalTime(1) = vehicleRoutes(i).startingTime + travelTime(1 , vehicleRoutes(i).Nodes(1) + 1);
 else
 vehicleRoutes(i).departureTime(j) = max(timeWindow(vehicleRoutes(i).Nodes(j-1),1), vehicleRoutes(i).arrivalTime(j-1));
 vehicleRoutes(i).arrivalTime(j) = vehicleRoutes(i).departureTime(j) + travelTime(vehicleRoutes(i).Nodes(j-1) + 1,vehicleRoutes(i).Nodes(j) + 1);
 end
 
 % Return to depot
 if j == length(vehicleRoutes(i).Nodes)
 vehicleRoutes(i).departureTime(j+1) = max(timeWindow(vehicleRoutes(i).Nodes(j),1), vehicleRoutes(i).arrivalTime(j));
 vehicleRoutes(i).arrivalTime(j+1) = vehicleRoutes(i).departureTime(j+1) + travelTime(vehicleRoutes(i).Nodes(j) + 1, 1);
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
 
 % Assign travel time
 for j = 1:length(vehicleRoutes(i).departureTime)
 vehicleRoutes(i).timeTraveled(j) = vehicleRoutes(i).arrivalTime(j) - vehicleRoutes(i).departureTime(j);
 end
 end
% Total distance calculation
 fitnessScore = 0;
 for i = 1:noOfVehicles
 for j = 1:length(vehicleRoutes(i).distanceTraveled)
 fitnessScore = fitnessScore + vehicleRoutes(i).distanceTraveled(j);
 end
 end
% Feasibility
 for i = 1:noOfVehicles
 for j = 1:length(vehicleRoutes(i).Nodes)
 if vehicleRoutes(i).arrivalTime(j) > timeWindow(vehicleRoutes(i).Nodes(j),2)
 fitnessScore = 999999999999999;
 end
 end
 
 if max(vehicleRoutes(i).carriedLoad) > capacity
 fitnessScore = 999999999999999;
 end
 end

end