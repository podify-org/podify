import mutations from 'mutations';

export default {
  // TODO: enable strict mode, only in development (https://vuex.vuejs.org/guide/strict.html)
  // strict: true,
  state: {
    all: [],
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

    destroyFeed({ commit }, { apollo, id }) {
      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.destroyFeed,
          variables: { id },
        }).then(({ data: { destroyFeed: { errors } } }) => {
          if (errors.length > 0) {
            reject(errors);
          } else {
            commit('removeFeed', { id });
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
