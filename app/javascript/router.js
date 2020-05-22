import VueRouter from 'vue-router';

const Foo = { template: '<div>foo</div>' };
const Bar = { template: '<div>bar</div>' };


const routes = [
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar },
  {
    path: '/feeds/:feedId/downloads',
    name: 'feedRequests',
  },
];

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
export default new VueRouter({
  routes
});
