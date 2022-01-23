global count;
global need_print_out;
function main()
  count = 0;
  need_print_out = 1;
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
    
    

    if mod(count, 10) == 0
      need_print_out = 1;
      printf('print out == 1')
    else
      need_print_out = 0;
      printf('print out == 0')
    end

    if count > 20
      break
    end

    count += 1;
    
  end % end while sastifyStopCriterion 
  finish()
  
  