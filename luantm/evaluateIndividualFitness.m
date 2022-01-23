function total_distance = evaluateIndividualFitness(NST, pretty = 0)
  % Đánh giá độ thích nghi của quần thể

  global n_customers; % so luong khach hang
  global n_vehicles; % so luong xe
  global n_NST; % so luong NST(Nhiễm sắc thể) - 1NST có chiều dài = số khách hàng + (số xe - 1)

  global population; % lưu danh sách NST
  global distances_matrix; % ma tran khoang cach
  global fitness_array;

  i_row = 0
  i_col = 0
  total_distance = 0
  for item = NST
    if item == 0
      i_row = 0
    end
    
    i_col = item

    total_distance = total_distance + distances_matrix(i_row, i_col)

    i_row = item
  end



  

  

  