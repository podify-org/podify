import queries from 'queries';

export function updateData(store, fn) {
  const data = getData(store);
  fn(data);
  store.writeQuery({ query: queries.data, data });
};

export function readData(store) {
  return store.readQuery({ query: queries.data }).data;
};

export function updateRequests(store, fn) {
  updateData(store, data => {
    fn(data.requests);
  });
};

export function addRequest(store, request) {
  updateRequests(store, requests => {
    requests.unshift(request);
  });
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

export function refreshSource(store, id) {
  apollo.query({
    query: queries.source,
    variables: { id },
  }).then(({ data: { source } }) => {
    updateRequests(store, requests => {
      const request = requests.find(request => request.source.id == id);
      request.source = source;
    });
  });
};

export function updateDownloadStatus(store, source_id, changes) {
  updateSource(store, source_id, source => {
    Object.assign(source.downloadStatus, changes);
  });
};

export function readFeeds(store) {
  return readData(store).feeds;
};

export function updateFeeds(store, fn) {
  updateData(store, data => {
    fn(data.feeds);
  });
};

export function addFeed(store, feed) {
  updateFeeds(store, feeds => {
    feeds.push(feed);
  });
};

export function removeFeed(store, id) {
  updateFeeds(store, feeds => {
    const index = feeds.findIndex(feed => feed.id == id);
    if (index > -1)
      feeds.splice(index, 1);
  });
};
