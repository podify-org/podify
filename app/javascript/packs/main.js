/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'main' %> (and
// <%= stylesheet_pack_tag 'main' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue';
import App from 'components/app';

import ApolloClient from "apollo-client";
import { HttpLink } from "apollo-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";

import VueApollo from "vue-apollo";

Vue.use(VueApollo);

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
  uri: 'http://podify.localhost:3000/graphql',
  fetch,
  headers: getHeaders()
});

const client = new ApolloClient({
  link: link,
  cache: new InMemoryCache({
    addTypename: true
  })
});

const apolloProvider = new VueApollo({
  defaultClient: client,
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    apolloProvider,
    render: h => h(App),
  }).$mount();
  document.body.appendChild(app.$el);

  console.log(app);
});
