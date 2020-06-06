import Vue from 'vue';
import mutations from 'mutations';
import queries from 'queries';

export default {
  state: {
    all: [],
  },

  mutations: {
    setRequests(state, { requests }) {
      state.all = requests;
    },
    updateRequest(state, { id, ...attributes }) {
      const index = state.all.findIndex(request => request.id == id);
      Vue.set(state.all, index, { ...state.all[index], ...attributes });
    },
    addRequest(state, { request }) {
      state.all.unshift(request);
    },
    removeRequest(state, { id }) {
      const index = state.all.findIndex(request => request.id == id);
      state.all.splice(index, 1);
    },

    updateSource(state, { id, ...attributes }) {
      const index = state.all.findIndex(request => request.source.id == id);
      state.all[index].source = { ...state.all[index].source, ...attributes };
    },

    updateDownloadStatus(state, { sourceId, ...attributes }) {
      const index = state.all.findIndex(request => request.source.id == sourceId);
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

    updateRequest({ commit }, { apollo, params }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.updateRequest,
          variables: params,
        }).then(({ data: { updateRequest: { request, errors } } }) => {
          if (errors.length > 0) {
            reject(errors);
          } else {
            commit('updateRequest', request);
            resolve();
          }
        });
      });
    },

    destroyRequest({ commit }, { apollo, id }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.destroyRequest,
          variables: { id },
        }).then(({ data: { destroyRequest: { errors } } }) => {
          if (errors.length > 0) {
            reject(errors);
          } else {
            commit('removeRequest', { id });
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
