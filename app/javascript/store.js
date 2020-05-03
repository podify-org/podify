import queries from 'queries';

export function updateRequests(store, fn) {
  const data = store.readQuery({ query: queries.requests });
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

export function updateSource(store, id, fn) {
  updateRequests(store, requests => {
    const request = requests.find(request => request.source.id == id);
    if (!request) return;
    fn(request.source);
  });
};

export function updateDownloadStatus(store, source_id, changes) {
  updateSource(store, source_id, source => {
    Object.assign(source.downloadStatus, changes);
    console.log(source_id);
    console.log(source.id);
    console.log(source.downloadStatus);
  });
};
