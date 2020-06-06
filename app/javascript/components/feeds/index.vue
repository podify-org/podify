<template>
<div>
  <NewRequest />
  <Requests :requests="requests"></Requests>

  <div class="big-subscribe">
    <Subscribe :feed="currentFeed" scope="big"></Subscribe>
  </div>
</div>
</template>

<script>
import Requests from 'components/requests';
import NewRequest from 'components/new_request';
import Subscribe from 'components/subscribe';

export default {
  computed: {
    currentFeed() {
      return this.$store.state.feeds.all.find(feed => feed.id == this.$route.params.feedId);
    },
    requests() {
      let allRequests = this.$store.state.requests.all;
      if (this.currentFeed.type == 'all') {
        return allRequests;
      } else {
        return allRequests.filter(request => request.feedId == this.$route.params.feedId);
      }
    },
  },
  components: {
    Requests,
    NewRequest,
    Subscribe,
  },
}
</script>
