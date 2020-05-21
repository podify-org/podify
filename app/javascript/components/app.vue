<template>
<div id="app">
  <div class="container">
    <div v-if="$apolloData.loading" class="d-flex mt-5 mb-3 justify-content-center">
      <b-spinner type="border" variant="primary"></b-spinner>
    </div>
    <template v-else>
      <Navbar :feeds="data.feeds"></Navbar>
      <Requests :requests="data.requests"></Requests>
      <Subscribe :feed="data.feeds[0]"></Subscribe>
      <Player></Player>
    </template>
  </div>
</div>
</template>

<script>
import queries from 'queries';
import Navbar from 'components/navbar';
import Requests from 'components/requests';
import Subscribe from 'components/subscribe';
import Player from 'components/player';

export default {
  apollo: {
    data: {
      query: queries.data,
    },
  },
  components: {
    Navbar,
    Requests,
    Subscribe,
    Player,
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
