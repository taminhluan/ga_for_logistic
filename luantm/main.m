printf('VERSION 0.0.2')
global need_print_out; % cho viec logging

global n_customers; % so luong khach hang
global n_vehicles; % so luong xe
global n_NST; % so luong NST(Nhiễm sắc thể) - 1NST có chiều dài = số khách hàng + (số xe - 1)
n_NST = 100
global population; % lưu danh sách NST
global distances_matrix; % ma tran khoang cach
global fitness_array;

  count = 0;
  need_print_out = 1;
  start()
  
  generateInitialPopulation()

  while ( ! sastifyStopCriterion() )
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

    printf('\tCount: %d\n', count)
    
    selection()
    crossOver()
    evaluateFitness()
    elitism()
    newGeneration()

    count += 1;
    
  end % end while sastifyStopCriterion 
  finish()
  
  