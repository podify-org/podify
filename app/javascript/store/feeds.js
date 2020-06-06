import Vue from 'vue';
import mutations from 'mutations';
import { optimisticId } from 'utils';

const indexById = (state, id) => state.all.findIndex(feed => feed.id == id);

export default {
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
    updateFeed(state, { id, ...attributes }) {
      const index = indexById(state, id);
      console.log(index, attributes, state.all[index]);
      Vue.set(state.all, index, { ...state.all[index], ...attributes });
    },
    removeFeed(state, { id }) {
      const index = indexById(state, id);
      state.all.splice(index, 1);
    },
    replaceFeed(state, { id, feed }) {
      const index = indexById(state, id);
      Vue.set(state.all, index, feed);
    },
  },

  actions: {
    createFeed({ commit }, { apollo, feed }) {
      const optimisticFeed = {
        ...feed,
        id: optimisticId(),
        type: 'manual',
        _optimisticCreate: true,
      };
      commit('addFeed', { feed: optimisticFeed });

      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.createFeed,
          variables: feed,
        }).then(({ data: { createFeed: { feed, errors } } }) => {
          if (errors.length > 0) {
            commit('removeFeed', { id: optimisticFeed.id });
            reject(errors);
          } else {
            commit('replaceFeed', { id: optimisticFeed.id, feed });
            resolve();
          }
        });
      });
    },

    destroyFeed({ commit, getters }, { apollo, id }) {
      commit('updateFeed', { id, _deleting: true });

      return new Promise((resolve, reject) => {
        apollo.mutate({
          mutation: mutations.destroyFeed,
          variables: { id },
        }).then(({ data: { destroyFeed: { errors } } }) => {
          if (errors.length > 0) {
            commit('updateFeed', { id, _deleting: false });
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
