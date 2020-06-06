import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

import queries from 'queries';

export default new Vuex.Store({
  // TODO: enable strict mode, only in development (https://vuex.vuejs.org/guide/strict.html)
  // strict: true,
  state: {
    loading: true,
    requests: [],
    feeds: [],
  },
  mutations: {
    setRequests(state, { requests }) {
      state.requests = requests;
    },
    setFeeds(state, { feeds }) {
      state.feeds = feeds;
    },
    loadingState(state, payload) {
      state.loading = payload.state;
    },
  },
  actions: {
    fetchData({ commit }, apollo) {
      commit('loadingState', { state: true });
      apollo.query({
        query: queries.data,
      }).then(({ data: { data: { requests, feeds } } }) => {
        commit('setFeeds', { feeds });
        commit('setRequests', { requests });
        commit('loadingState', { state: false });
      });
    },
  },
});
