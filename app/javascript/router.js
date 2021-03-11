import VueRouter from 'vue-router';

import FeedIndex from 'components/feeds/index';
import FeedSettings from 'components/feeds/settings';
import AddRequest from 'components/feeds/add_request';

const routes = [
  {
    path: '/feeds/:feedId',
    name: 'feedIndex',
    component: FeedIndex,
    children: [
      {
        path: 'add',
        name: 'addRequest',
        component: AddRequest,
      },
      {
        path: 'settings',
        name: 'feedSettings',
        component: FeedSettings,
      },
    ],
  },
];

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
export default new VueRouter({
  routes,
  mode: 'history',
});
