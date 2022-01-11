clcfunction [child1, child2] = crossover2(p1, p2)
 child1 = zeros(1,length(p1));
 child2 = zeros(1,length(p1));
 a = ceil(rand*length(p1));
 b = ceil(rand*length(p1));
 while b == a
 b = ceil(rand*length(p1));
 end
 
 % Identify 2 cut points
 cp1= min(a,b);
 cp2 = max(a,b);
 
 child1(cp1:cp2) = p1(cp1:cp2);
 for i = 1:length(child1)
 if child1(i) == 0
 for j = 1:length(p2)
 if isempty(findIndex(child1,p2(j))) == 1
 child1(i) = p2(j);
K
 break
 end
 end
 end
 end
 
 child2(cp1:cp2) = p2(cp1:cp2);
 for i = 1:length(child2)
 if child2(i) == 0
 for j = 1:length(p1)
 if isempty(findIndex(child2,p1(j))) == 1
 child2(i) = p1(j);
break
 end
 end
 end
 end
 
end