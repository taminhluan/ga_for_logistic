function index = findIndex(array, value)
 index = find(array < value + 1 & array > value - 1);
end