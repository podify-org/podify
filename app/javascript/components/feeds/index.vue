<template>
<div>
  <NewRequest />

  <router-view></router-view>

  <Requests :requests="requests"></Requests>

  <div class="big-subscribe">
    <Subscribe :feed="feed" scope="big"></Subscribe>
  </div>
</div>
</template>

<script>
import HasFeed from 'components/feeds/has_feed_mixin.js';
import Requests from 'components/requests';
import NewRequest from 'components/feeds/new_request_form';
import Subscribe from 'components/subscribe';

export default {
  mixins: [HasFeed],
  computed: {
    requests() {
      return this.$store.getters.requestsForFeed(this.feed);
    },
  },
  components: {
    Requests,
    NewRequest,
    Subscribe,
  },
}
</script>
