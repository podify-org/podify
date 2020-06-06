let _currentOptimisticId = 2147480000;
export function optimisticId() {
  return _currentOptimisticId++;
}
