<template>
<div>
  <NewRequest />
  <Requests :requests="requests"></Requests>

  <div class="big-subscribe">
    <Subscribe :feed="feed" scope="big"></Subscribe>
  </div>
</div>
</template>

<script>
import Requests from 'components/requests';
import NewRequest from 'components/new_request';
import Subscribe from 'components/subscribe';

export default {
  props: ['data'],
  computed: {
    requests() {
      return this.data.requests.filter(request => request.feedId == this.$route.params.feedId);
    },
    feed() {
      return this.data.feeds.find(feed => feed.id == this.$route.params.feedId);
    },
  },
  components: {
    Requests,
    NewRequest,
    Subscribe,
  }
}
</script>
