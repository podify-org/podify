import Vue from 'vue';
import mutations from 'mutations';
import queries from 'queries';

const indexById = (state, id) => state.all.findIndex(request => request.id == id);
const indexBySourceId = (state, id) => state.all.findIndex(request => request.source.id == id);

const findById = (state, id) => state.all[indexById(state, id)];

export default {
  state: {
    all: [],
  },

  getters: {
    requestsForFeed(state, getters) {
      return feed => {
        let all = getters.allRequests;
        if (feed.type == 'all') {
          return all;
        } else {
          return all.filter(request => request.feedId == feed.id);
        }
      };
    },
    allRequests(state) {
      return [...state.all].sort((a, b) => a.id < b.id ? 1 : -1);
    },
    requestById(state) {
      return id => findById(state, id);
    }
  },

  mutations: {
    setRequests(state, { requests }) {
      state.all = requests;
    },
    updateRequest(state, { id, ...attributes }) {
      const index = indexById(state, id);
      Vue.set(state.all, index, { ...state.all[index], ...attributes });
    },
    addRequest(state, { request }) {
      state.all.unshift(request);
    },
    removeRequest(state, { id }) {
      const index = indexById(state, id);
      state.all.splice(index, 1);
    },

    updateSource(state, { id, ...attributes }) {
      const index = indexBySourceId(state, id);
      state.all[index].source = { ...state.all[index].source, ...attributes };
    },

    updateDownloadStatus(state, { sourceId, ...attributes }) {
      const index = indexBySourceId(state, sourceId);
      const downloadStatus = state.all[index].source.downloadStatus;
      state.all[index].source.downloadStatus = { ...downloadStatus, ...attributes };
    },
  },

  actions: {
    createRequest({ commit }, { apollo, params }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.requestForUrl,
          variables: params,
        }).then(({ data: { requestForUrl: { request, errors } } }) => {
          if (errors.length > 0) {
            reject(errors);
          } else {
            commit('addRequest', { request });
            resolve(request);
          }
        });
      });
    },

    updateRequest({ state, commit }, { apollo, id, feedId }) {
      const storedFeedId = findById(state, id).feedId;
      commit('updateRequest', { id, feedId: feedId });

      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.updateRequest,
          variables: { id, feedId },
        }).then(({ data: { updateRequest: { request, errors } } }) => {
          if (errors.length > 0) {
            commit('updateRequest', { id, feedId: storedFeedId });
            reject(errors);
          } else {
            commit('updateRequest', request);
            resolve();
          }
        });
      });
    },

    destroyRequest({ commit, getters }, { apollo, id }) {
      const storedRequest = getters.requestById(id);
      commit('removeRequest', { id });

      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.destroyRequest,
          variables: { id },
        }).then(({ data: { destroyRequest: { errors } } }) => {
          if (errors.length > 0) {
            commit('addRequest', { request: storedRequest });
            reject(errors);
          } else {
            resolve();
          }
        });
      });
    },

    refreshSource({ commit }, { apollo, id }) {
      return new Promise((resolve, reject) => {
        apollo.query({
          query: queries.source,
          variables: { id },
        }).then(({ data: { source } }) => {
          commit('updateSource', { id, ...source });
          resolve(source);
        }).catch(reject);
      });
    }
  },
};
