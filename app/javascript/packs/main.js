/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'main' %> (and
// <%= stylesheet_pack_tag 'main' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue';
import ActionCableVue from 'actioncable-vue';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue';
import App from 'components/app';

import ApolloClient from "apollo-client";
import { HttpLink } from "apollo-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";

import VueApollo from "vue-apollo";

import VueClipboard from 'vue-clipboard2';

const apiUrl = document.querySelector('meta[name="api-url"]').content;
const actionCableUrl = document.querySelector('meta[name="action-cable-url"]').content;

Vue.use(VueApollo);
Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'error',
  connectionUrl: actionCableUrl,
  connectImmediately: true,
});

VueClipboard.config.autoSetContainer = true;
Vue.use(VueClipboard);

// Vue.config.productionTip = false;

const getHeaders = () => {
  const headers = {};
  const token = window.localStorage.getItem('apollo-token');
  if (token) {
    headers.authorization = `Bearer ${token}`;
  }
  return headers;
};

// Create an http link:
const link = new HttpLink({
  uri: apiUrl,
  fetch,
  headers: getHeaders()
});

const store = new InMemoryCache({
  addTypename: true
});
window.store = store;

const client = new ApolloClient({
  link: link,
  cache: store,
});
window.apollo = client;

const apolloProvider = new VueApollo({
  defaultClient: client,
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    apolloProvider,
    render: h => h(App),
  }).$mount("#main");
});
