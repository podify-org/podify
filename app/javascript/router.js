import VueRouter from 'vue-router';

import FeedRequests from 'components/feeds/requests';

const routes = [
  {
    path: '/feeds/:feedId',
    name: 'feedRequests',
    component: FeedRequests,
  },
];

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
export default new VueRouter({
  routes,
  mode: 'history',
});
