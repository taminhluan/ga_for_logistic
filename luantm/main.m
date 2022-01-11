function main()
  
  start()
  
  generateInitialPopulation()
  
  count = 1;
  while ( ! sastifyStopCriterion() )
    printf('\tCount: %d\n', count)
    
    selection()
    crossOver()
    evaluateFitness()
    elitism()
    newGeneration()
    
    count += 1;
    
  end % end while sastifyStopCriterion 
  finish()
  
  