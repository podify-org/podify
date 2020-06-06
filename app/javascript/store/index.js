import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

import queries from 'queries';
import mutations from 'mutations';

import feeds from 'store/feeds';
import requests from 'store/requests';

export default new Vuex.Store({
  // TODO: enable strict mode, only in development (https://vuex.vuejs.org/guide/strict.html)
  // strict: true,
  state: {
    loading: true,
  },

  modules: {
    feeds,
    requests,
  },

  mutations: {
    loadingState(state, payload) {
      state.loading = payload.state;
    },
  },

  actions: {
    fetchData({ commit }, apollo) {
      commit('loadingState', { state: true });

      return new Promise((resolve, reject) => {
        apollo.query({
          query: queries.data,
        }).then(({ data: { data: { requests, feeds } } }) => {
          commit('setFeeds', { feeds });
          commit('setRequests', { requests });
          commit('loadingState', { state: false });
          resolve();
        }).catch(reject);
      });
    },
  },
});
