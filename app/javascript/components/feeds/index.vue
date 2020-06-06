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
      return this.$store.getters.feedById(this.$route.params.feedId);
    },
    requests() {
      return this.$store.getters.requestsForFeed(this.currentFeed);
    },
  },
  components: {
    Requests,
    NewRequest,
    Subscribe,
  },
}
</script>
