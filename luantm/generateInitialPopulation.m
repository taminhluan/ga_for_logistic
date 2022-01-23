function generateInitialPopulation()
  % Khởi tạo quần thể
  global need_print_out;
  global n_customers; % so luong khach hang
  global n_vehicles; % so luong xe
  global n_NST; % so luong NST(Nhiễm sắc thể) - 1NST có chiều dài = số khách hàng + (số xe - 1)

  global population; % lưu danh sách NST

  % cho debug
  if need_print_out == 1
    fprintf('Generate initial population\n')
  

  % Khởi tạo quần thể
  length_NST = n_customers + (n_vehicles - 1);
  
  for i = 1:n_NST
    % khởi tạo NST mới
    new_NST = randperm(length_NST) % random permutation randperm(3) may be 1,2,3 or 3,2,1, or 2,1,3
    for j = 1:length_NST
      if new_NST(j) > n_customers
        new_NST(j) = 0;
      end
    end
    % thêm NST vào quần thể
    population = [population; new_NST];
  end

  end
  