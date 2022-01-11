function mutant = mutation(array)
 a = ceil(rand*length(array));
 b = ceil(rand*length(array));
 while b == a
 b = ceil(rand*length(array));
 end
 % Identify 2 cut points
 cp1 = min(a,b);
 cp2 = max(a,b);
 
 i = randperm(cp2 - cp1 + 1);
 mutant = array;
 
 mutant(cp1:cp2) = array(:,i + cp1 - 1);
end