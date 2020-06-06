/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'main' %> (and
// <%= stylesheet_pack_tag 'main' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import 'es6-promise/auto';

import Vue from 'vue';
import ActionCableVue from 'actioncable-vue';
import App from 'components/app';

import ApolloClient from "apollo-client";
import { HttpLink } from "apollo-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";

import VueApollo from "vue-apollo";

const apiUrl = document.querySelector('meta[name="api-url"]').content;
const actionCableUrl = document.querySelector('meta[name="action-cable-url"]').content;

Vue.use(VueApollo);
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'error',
  connectionUrl: actionCableUrl,
  connectImmediately: true,
});

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue';
Vue.use(BootstrapVue);
Vue.use(IconsPlugin);

import VueClipboard from 'vue-clipboard2';
VueClipboard.config.autoSetContainer = true;
Vue.use(VueClipboard);

import VueQrcode from '@chenfengyuan/vue-qrcode';
Vue.component(VueQrcode.name, VueQrcode);

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

const cache = new InMemoryCache({
  addTypename: true
});

const client = new ApolloClient({
  link,
  cache,
});

const apolloProvider = new VueApollo({
  defaultClient: client,
});

Vue.directive('visible', (el, binding) => {
  el.style.visibility = !!binding.value ? 'visible' : 'hidden';
});

import store from 'store/index';

import VueRouter from 'vue-router';
import router from 'router';
Vue.use(VueRouter);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    apolloProvider,
    router,
    store,
    render: h => h(App),
  }).$mount("#main");
});
