import queries from 'queries';

export function updateRequests(store, fn) {
  const data = store.readQuery({ query: queries.requests });
  window.ff = fn;
  fn(data.requests);
  store.writeQuery({ query: queries.requests, data });
};

export function removeRequest(store, id) {
  updateRequests(store, requests => {
    const index = requests.findIndex(request => request.id == id);
    if (index > -1)
      requests.splice(index, 1);
  });
};
