function [child1, child2] = crossover1(p1, p2)
 cycle = zeros(1,length(p1));
 child1 = zeros(1,length(p1));
 child2 = zeros(1,length(p1));
 cycleNumber = 1;
 while length(find(cycle)) < length(cycle)
 index = findIndex(cycle,0);
 cycle(index(1)) = cycleNumber;
 valueOnP1 = p1(index(1));
 firstValue = valueOnP1;
 valueOnP2 = p2(index(1));
 while firstValue ~= valueOnP2
 cycle(findIndex(p1,valueOnP2)) = cycleNumber;
 valueOnP2 = p2(findIndex(p1, valueOnP2));
 valueOnP1 = p1(findIndex(p2, valueOnP2)); 
 end
 cycleNumber = cycleNumber + 1;
 end
 for i = 1:length(p1)
 if mod(cycle(i),2) == 0
 child1(i) = p1(i);
 child2(i) = p2(i);
 else
 child1(i) = p2(i);
 child2(i) = p1(i);
 end
 end
end