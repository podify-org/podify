import mutations from 'mutations';

export default {
  // TODO: enable strict mode, only in development (https://vuex.vuejs.org/guide/strict.html)
  // strict: true,
  state: {
    all: [],
  },

  getters: {
    allFeeds(state) {
      return state.all;
    },
    feedById(state) {
      return id => state.all.find(feed => feed.id == parseInt(id));
    },
    defaultFeed(state) {
      return state.all[0];
    },
  },

  mutations: {
    setFeeds(state, { feeds }) {
      state.all = feeds;
    },
    addFeed(state, { feed }) {
      state.all.push(feed);
    },
    removeFeed(state, { id }) {
      state.all.push(feed);
    },
    removeFeed(state, { id }) {
      const index = state.all.findIndex(feed => feed.id == id);
      state.all.splice(index, 1);
    },
  },

  actions: {
    createFeed({ commit }, { apollo, feed }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.createFeed,
          variables: feed,
        }).then(({ data: { createFeed: { feed, errors } } }) => {
          if (errors.length > 0) {
            reject(errors);
          } else {
            commit('addFeed', { feed });
            resolve();
          }
        });
      });
    },

    destroyFeed({ commit, getters }, { apollo, feed }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.destroyFeed,
          variables: { id: feed.id },
        }).then(({ data: { destroyFeed: { errors } } }) => {
          if (errors.length > 0) {
            reject(errors);
          } else {
            commit('removeFeed', { id: feed.id });
            getters.requestsForFeed(feed).map(request => commit('removeRequest', { id: request.id }));
            resolve();
          }
        });
      });
    },

    orderFeeds({ commit }, { apollo, feedIds }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.orderFeeds,
          variables: { feedIds },
        }).then(({ data: { orderFeeds: { feeds } } }) => {
          commit('setFeeds', { feeds });
          resolve();
        });
      });
    }
  },
};
