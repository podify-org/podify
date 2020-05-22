import VueRouter from 'vue-router';

import FeedIndex from 'components/feeds/index';

const routes = [
  {
    path: '/feeds/:feedId',
    name: 'feedRequests',
    component: FeedIndex,
  },
];

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
export default new VueRouter({
  routes,
  mode: 'history',
});
