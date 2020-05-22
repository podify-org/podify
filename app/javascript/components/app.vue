<template>
<div id="app">
  <div class="container">
    <div v-if="$apolloData.loading" class="d-flex mt-5 mb-3 justify-content-center">
      <b-spinner type="border" variant="primary"></b-spinner>
    </div>
    <template v-else>
      <Navbar :feeds="data.feeds"></Navbar>

      <router-view v-bind="{ data }"></router-view>

      <Player></Player>
    </template>
  </div>
</div>
</template>

<script>
import queries from 'queries';
import Navbar from 'components/navbar';
import Player from 'components/player';

export default {
  apollo: {
    data: {
      query: queries.data,
    },
  },
  components: {
    Navbar,
    Player,
  },
  mounted() {
    window.route = this.$route;
    window.router = this.$router;
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
