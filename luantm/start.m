function start()
  % Bắt đầu
  % % Nhập dữ liệu từ tập tin
  global n_customers; % so luong khach hang
  global n_vehicles; % so luong xe
  global distances_matrix; % ma tran khoang cach
  
  printf('Genetic algorithm for logistic problem\n') %TODO: Cần viết tên thuật toán tại đây

  % TODO: nhập dữ liệu từ file và cập nhật vào biến global
  n_customers = 13; % mock data
  n_vehicles = 5; % mock data
  distances_matrix = [
    %Depot	W30	W31	W32	W33	W34	W35	W36	W37	W38	W39	W40	W41	W42	Depot
    0	11	11	16	11	8	8	10	8	10	9	11	11	9	0;
    11	0	6	7	0	3	3	0	5	1	2	2	0	8	12;
    11	6	0	11	7	4	4	6	3	6	6	7	6	12	12;
    16	7	11	0	7	8	8	8	10	8	9	10	7	15	17;
    11	0	7	7	0	3	4	1	6	1	2	2	1	8	12;
    8	3	4	8	3	0	1	2	3	3	2	3	3	8	10;
    8	3	4	8	4	1	0	3	2	3	2	4	4	9	10;
    10	0	6	8	1	2	3	0	5	0	2	2	1	7	11;
    8	5	3	10	6	3	2	5	0	5	4	6	6	11	9;
    10	1	6	8	1	3	3	0	5	0	2	2	1	7	11;
    9	2	6	9	2	2	2	2	4	2	0	2	2	7	10;
    11	2	7	10	2	3	4	2	6	2	2	0	2	7	11;
    11	0	6	7	1	3	4	1	6	1	2	2	0	7	12;
    9	8	12	15	8	8	9	7	11	7	7	7	7	0	10;
    0	12	12	17	12	10	10	11	9	11	10	11	12	10	0;
  ]; % copy data from excel

